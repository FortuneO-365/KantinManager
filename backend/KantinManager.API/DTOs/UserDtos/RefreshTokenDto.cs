using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs.UserDtos
{
    public class RefreshTokenDto
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "RefreshToken is required")]
        public string RefreshToken { get; set; } = string.Empty;
    }
}
