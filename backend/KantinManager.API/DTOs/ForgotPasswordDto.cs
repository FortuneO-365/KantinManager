using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs
{
    public class ForgotPasswordDto
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = " Verification Code is required")]
        [Length(6, 6, ErrorMessage = "Verification code should be 6 characters")]
        public string Code { get; set; } = String.Empty;

        [Required(AllowEmptyStrings = false, ErrorMessage = "Password is required")]
        public string Password { get; set; } = String.Empty;
    }
}
