using KantinManager.API.Data;
using KantinManager.API.DTOs;
using KantinManager.API.Models;
using KantinManager.API.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Security.Cryptography;
using System.Text;

namespace KantinManager.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly JwtService _jwtService;
        private readonly EmailService _emailService;
        private readonly ILogger<AuthController> _logger;

        public AuthController(AppDbContext context, JwtService jwtService, EmailService emailService, ILogger<AuthController> logger)
        {
            _context = context;
            _jwtService = jwtService;
            _emailService = emailService; // Initialize EmailService
            _logger = logger;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register(RegisterDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (await _context.Users.AnyAsync(u => u.Email == dto.Email))
            {
                return BadRequest("Email already in use.");
            }

            var code = GenerateCode().ToString();
            var expiration = DateTime.UtcNow.AddHours(1);

            try
            {
                var userEmail = dto.Email;
                await _emailService.SendVerificationEmail(userEmail, code); // Use the instance of EmailService

                var user = new User
                {
                    FirstName = dto.FirstName,
                    LastName = dto.LastName,
                    Email = dto.Email,
                    PasswordHash = HashPassword(dto.Password),
                    VerificationCode = code,
                    VerificationCodeExpiresAt = expiration,
                };

                _context.Users.Add(user);
                await _context.SaveChangesAsync();

                return Ok("User Registered Successfully. Check your mail for a verification code");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Email sending failed: {ex.Message}");
            }

        }

        [HttpPost("verify-email")]
        public async Task<IActionResult> Verify(VerifyEmailDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);

            if (user == null)
            {
                return NotFound("User not found");
            }

            if (user.EmailVerified)
            {
                return BadRequest("User already verified");
            }

            if (user.VerificationCode != dto.Code)
            {
                return BadRequest("Invalid verification code");
            }

            user.EmailVerified = true;
            user.VerificationCode = null;
            user.VerificationCodeExpiresAt = null;

            await _context.SaveChangesAsync();

            return Ok("Email verified Successfully");
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);

            if (user == null || user.PasswordHash != HashPassword(dto.Password))
            {
                return Unauthorized("Invalid credentials.");
            }

            var token = _jwtService.GenerateToken(user);

            return Ok(new { token });
        }

        [HttpPost("resend-verification")]
        public async Task<IActionResult> ResendVerificationCode(ResendVerificationCodeDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);
            if (user == null)
            {
                return NotFound("User not found");
            }
            if (user.EmailVerified)
            {
                return BadRequest("User already verified");
            }
            var code = GenerateCode().ToString();
            var expiration = DateTime.UtcNow.AddHours(1);
            try
            {
                await _emailService.SendVerificationEmail(user.Email, code);
                user.VerificationCode = code;
                user.VerificationCodeExpiresAt = expiration;
                await _context.SaveChangesAsync();
                return Ok("Verification code resent. Check your email.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Email sending failed: {ex.Message}");
            }
        }

        //public async Task<IActionResult> StartForgotPassword(ResendVerificationCodeDto dto)
        //{
        //    if (!ModelState.IsValid)
        //    {
        //        return BadRequest(ModelState);
        //    }
        //    var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);
        //    if (user == null)
        //    {
        //        return NotFound("User not found");
        //    }
        //    var link = GenerateCode().ToString();
        //    var expiration = DateTime.UtcNow.AddHours(1);
        //    try
        //    {
        //        await _emailService.SendVerificationEmail(user.Email, code);
        //        user.VerificationCode = code;
        //        user.VerificationCodeExpiresAt = expiration;
        //        await _context.SaveChangesAsync();
        //        return Ok("Password reset code sent. Check your email.");
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, $"Email sending failed: {ex.Message}");
        //    }
        //}



        [HttpGet("me")]
        public async Task<IActionResult> GetUser()
        {
            var authorization = HttpContext.Request.Headers["Authorization"].ToString();
            if (string.IsNullOrEmpty(authorization) || !authorization.StartsWith("Bearer "))
            {
                return Unauthorized("Missing or invalid provided");
            }

            var token = authorization.Substring("Bearer ".Length).Trim();

            try
            {
                var userId = _jwtService.ValidateToken(token);
                _logger.LogInformation($"UserId: {userId}");

                var user = await _context.Users.FindAsync(userId);
                if (user == null)
                    return NotFound("User not found");

                return Ok(new
                {
                    user.Id,
                    user.FirstName,
                    user.LastName,
                    user.Email,
                    user.EmailVerified
                });
            }
            catch (Exception ex)
            {
                return Unauthorized("Token validation failed: " + ex.Message);
            }
        }


        private string HashPassword(string password)
        {
            // Simple hash for demonstration purposes. Use a stronger hashing algorithm in production.
            using var sha256 = SHA256.Create();
            var bytes = Encoding.UTF8.GetBytes(password);
            var hash = sha256.ComputeHash(bytes);
            return Convert.ToBase64String(hash);
        }

        private int GenerateCode()
        {
            var random = new Random();
            return random.Next(100000, 999999);
        }
    }
}
