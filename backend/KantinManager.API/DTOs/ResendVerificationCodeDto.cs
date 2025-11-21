using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs
{
    public class ResendVerificationCodeDto
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid Email Format")]
        public string Email { get; set; } = String.Empty;
    }
}
