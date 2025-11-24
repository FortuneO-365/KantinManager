using KantinManager.API.Data;
using KantinManager.API.DTOs;
using KantinManager.API.Models;
using KantinManager.API.Services;
using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
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

        public AuthController(AppDbContext context, JwtService jwtService, EmailService emailService)
        {
            _context = context;
            _jwtService = jwtService;
            _emailService = emailService; // Initialize EmailService
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

        [HttpPost("initiate-forgot-password")]
        public async Task<IActionResult> StartForgotPassword(ResendVerificationCodeDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);

            if (user == null)
            {
                return Ok("Password reset instructions sent if the email exists.");
            }

            // Generate a fresh reset code
            var code = GenerateCode().ToString();
            var expiration = DateTime.UtcNow.AddMinutes(10); // Better UX than 1 hour

            try
            {
                // Send email
                await _emailService.SendVerificationEmail(user.Email, code);

                // Save to DB
                user.VerificationCode = code;
                user.VerificationCodeExpiresAt = expiration;

                await _context.SaveChangesAsync();

                // Always return same message for security
                return Ok("Password reset instructions sent if the email exists.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Email sending failed: {ex.Message}");
            }
        }


        [HttpPost("complete-forgot-password")]
        public async Task<IActionResult> CompleteForgotPassword(ForgotPasswordDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.VerificationCode == dto.Code);

            if (user == null || user.VerificationCodeExpiresAt < DateTime.UtcNow) 
            {
                return BadRequest("Invalid or expired Code");
            }

            var password = HashPassword(dto.Password);
            user.PasswordHash = password;

            await _context.SaveChangesAsync();

            return Ok("Password Changed Successfully");

        }

        [HttpPost("reset-password")]
        public async Task<IActionResult> ResetPassword(ResetPasswordDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var authorization = HttpContext.Request.Headers.Authorization.ToString();
            if (string.IsNullOrEmpty(authorization) || !authorization.StartsWith("Bearer "))
            {
                return Unauthorized("Missing or invalid provided");
            }

            var token = authorization.Substring("Bearer ".Length).Trim();

            try
            {
                string userId = _jwtService.ValidateToken(token);

                if (userId == "No token" || userId == "No Claim" || userId == "Error")
                {
                    return BadRequest(userId);
                }

                var user = await _context.Users.FindAsync(int.Parse(userId));
                if (user == null)
                {
                    return NotFound("User not found");
                }

                var password = HashPassword(dto.Password);
                user.PasswordHash = password;

                await _context.SaveChangesAsync();

                return Ok("Password Reset Successfully");

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
