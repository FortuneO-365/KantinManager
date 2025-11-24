using KantinManager.API.Data;
using KantinManager.API.Services;
using KantinManager.API.DTOs;
using Microsoft.AspNetCore.Mvc;

namespace KantinManager.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly JwtService _jwtService;
        private readonly CloudinaryService _cloudinaryService;

        public UserController(AppDbContext context, JwtService jwtService, CloudinaryService cloudinaryService)
        {
            _context = context;
            _jwtService = jwtService;
            _cloudinaryService = cloudinaryService;
        }

        [HttpGet("me")]
        public async Task<IActionResult> GetUser()
        {
            var authorization = HttpContext.Request.Headers.Authorization.ToString();
            if (string.IsNullOrEmpty(authorization) || !authorization.StartsWith("Bearer "))
            {
                return Unauthorized("Missing or invalid token provided");
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
                    return NotFound("User not found");

                return Ok(new
                {
                    user.Id,
                    user.FirstName,
                    user.LastName,
                    user.Email,
                    user.EmailVerified,
                    user.ProfileImageUrl
                });
            }
            catch (Exception ex)
            {
                return Unauthorized("Token validation failed: " + ex.Message);
            }
        }

        [HttpPatch("me")]
        public async Task<IActionResult> EditDetails(EditUserDto dto)
        {
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
                    return NotFound("User not found");

                // Update only provided fields
                if (!string.IsNullOrWhiteSpace(dto.FirstName))
                    user.FirstName = dto.FirstName;

                if (!string.IsNullOrWhiteSpace(dto.LastName))
                    user.LastName = dto.LastName;

                if (!string.IsNullOrWhiteSpace(dto.Email))
                    user.Email = dto.Email;

                await _context.SaveChangesAsync();

                return Ok(new
                {
                    message = "Profile updated successfully",
                    user = new
                    {
                        user.Id,
                        user.FirstName,
                        user.LastName,
                        user.Email,
                        user.EmailVerified,
                        user.ProfileImageUrl
                    }
                });

            }
            catch (Exception ex)
            {
                return Unauthorized("Token validation failed: " + ex.Message);
            }
        }

        [HttpPost("upload-profile-image")]
        public async Task<IActionResult> UploadProfileImage(IFormFile file)
        {
            if (file == null || file.Length == 0)
            {
                return BadRequest("No file provided.");
            }

            var authorization = HttpContext.Request.Headers.Authorization.ToString();
            if (string.IsNullOrEmpty(authorization) || !authorization.StartsWith("Bearer "))
            {
                return Unauthorized("Missing or invalid provided");
            }

            var token = authorization.Substring("Bearer ".Length).Trim();

            try
            {
                var userId = _jwtService.ValidateToken(token);
                if (userId == "No token" || userId == "No Claim" || userId == "Error")
                {
                    return BadRequest(userId);
                }

                var user = await _context.Users.FindAsync(int.Parse(userId));
                if (user == null)
                    return NotFound("User not found");

                // Upload to Cloudinary
                var imageUrl = await _cloudinaryService.UploadProfileImage(file);

                // Save to DB
                user.ProfileImageUrl = imageUrl;
                await _context.SaveChangesAsync();

                return Ok(new { imageUrl });
            }
            catch (Exception ex) 
            {
                return BadRequest(ex.TargetSite + ex.Message);
            }
        }

        public async Task<IActionResult> ChangePassword (ChangePasswordDto dto)
        {
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
            }
            catch (Exception ex) 
            {
                return Unauthorized("Token validation failed: " + ex.Message);
            }
        }
    }
}
