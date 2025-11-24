using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs
{
    public class EditUserDto
    {
        public string FirstName { get; set; } = string.Empty;

        public string LastName { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;
    }
}
