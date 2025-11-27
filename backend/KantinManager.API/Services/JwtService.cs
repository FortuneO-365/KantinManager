using KantinManager.API.Models;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
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
                new Claim(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
                new Claim(JwtRegisteredClaimNames.Email, user.Email)
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

        public string ValidateToken(string token)
        {


            if (string.IsNullOrEmpty(token))
                return "No token";

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwtKey)); // Your stored secret

            try
            {
                var validationParams = new TokenValidationParameters
                {
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = key,
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero
                };

                var principal = tokenHandler.ValidateToken(token, validationParams, out SecurityToken validatedToken);

                // Get the "sub" claim (standard JWT Subject claim)
                var userIdClaim =
                    principal.Claims.FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Sub) ??
                    principal.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier);


                if (userIdClaim == null)
                {
                    return "No Claim";
                }

                return int.Parse(userIdClaim.Value).ToString();
            }
            catch
            {
                return "Error"; // Token invalid, expired, or signature mismatch
            }
        }

        public string GenerateRefreshToken()
        {
            var randomBytes = new byte[64];
            using var rng = RandomNumberGenerator.Create();
            rng.GetBytes(randomBytes);
            return Convert.ToBase64String(randomBytes);
        }


    }
}
