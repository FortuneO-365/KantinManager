using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs.UserDtos
{
    public class VerifyEmailDto
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid Email Format")]
        public string Email { get; set; } = string.Empty;

        [Required(AllowEmptyStrings = false, ErrorMessage = " Verification Code is required")]
        [Length(6,6, ErrorMessage ="Verification code should be 6 characters")]
        public string Code { get; set; } = string.Empty;

    }   
}
