using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs.UserDtos
{
    public class ChangePasswordDto
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Old Password is required")]
        public string OldPassword { get; set; } = string.Empty;

        [Required(AllowEmptyStrings = false, ErrorMessage = "New Password is required")]
        public string NewPassword { get; set; } = string.Empty;
    }
}
