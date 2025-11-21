using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs
{
    public class VerifyEmailDto
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid Email Format")]
        public string Email { get; set; } = String.Empty;

        [Required(AllowEmptyStrings = false, ErrorMessage = " Verification Code is required")]
        [Length(6,6, ErrorMessage ="Verification code should be 6 characters")]
        public string Code { get; set; } = String.Empty;

    }   
}
