using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs
{
    public class RegisterDto
    {
        [Required(AllowEmptyStrings = false,ErrorMessage ="Firstname is required")]
        public string FirstName { get; set; } = string.Empty;

        [Required(AllowEmptyStrings = false, ErrorMessage = "Lastname is required")]
        public string LastName { get; set; } = string.Empty;

        [Required(AllowEmptyStrings = false, ErrorMessage ="Email is required")]
        [EmailAddress(ErrorMessage ="Invalid Email Format")]
        public string Email { get; set; } = string.Empty;

        [Required(AllowEmptyStrings = false, ErrorMessage ="Password is required")]
        [MinLength(8,ErrorMessage ="Password should be more than 8 characters")]
        [MaxLength(30, ErrorMessage ="Password should be less than 30 characters")]
        public string Password { get; set; } = string.Empty;
    }
}
