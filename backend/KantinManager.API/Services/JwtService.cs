using KantinManager.API.Models;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace KantinManager.API.Services
{
    public class JwtService
    {
        private readonly string _jwtKey;

        public JwtService(IConfiguration config)
        {
            _jwtKey = config["JwtKey"]!;
        }

        public string GenerateToken(User user) 
        {
            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim(ClaimTypes.Email, user.Email)
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwtKey));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.UtcNow.AddDays(2),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public int? ValidateToken(string token)
        {
            if (string.IsNullOrEmpty(token))
                return null;

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.UTF8.GetBytes(_jwtKey); // Your stored secret

            try
            {
                var validationParams = new TokenValidationParameters
                {
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero
                };

                var principal = tokenHandler.ValidateToken(token, validationParams, out SecurityToken validatedToken);

                // Get the "sub" claim (standard JWT Subject claim)
                var userIdClaim = principal.Claims.FirstOrDefault(c => c.Type == "sub");

                if (userIdClaim == null)
                    return null;

                return int.Parse(userIdClaim.Value);
            }
            catch
            {
                return null; // Token invalid, expired, or signature mismatch
            }
        }

    }
}
