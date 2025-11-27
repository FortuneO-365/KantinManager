using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs.UserDtos
{
    public class EditUserDto
    {
        public string FirstName { get; set; } = string.Empty;

        public string LastName { get; set; } = string.Empty;

    }
}
