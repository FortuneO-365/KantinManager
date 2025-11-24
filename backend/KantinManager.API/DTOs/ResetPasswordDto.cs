using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs
{
    public class ResetPasswordDto
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Password is required")]
        public string Password { get; set; } = String.Empty;
    }
}
