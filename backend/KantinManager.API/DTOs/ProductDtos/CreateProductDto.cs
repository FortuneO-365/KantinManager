using KantinManager.API.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs.ProductDtos
{
    public class CreateProductDto
    {
        [Required(AllowEmptyStrings = false, ErrorMessage ="ProductName can't be empty.")]
        public string ProductName { get; set; } = string.Empty;

        public decimal CostPrice { get; set; }

        [Required(ErrorMessage = "Selling Price can't be empty")]
        public decimal SellingPrice { get; set; }

        [Required(ErrorMessage = "Quantity can't be empty")]
        public int Quantity { get; set; }

        [Required(ErrorMessage = "Quantity can't be empty")]
        [DataType(DataType.Currency, ErrorMessage = "Invalid currency types.")]
        public Currency Currency { get; set; } = Currency.NGN;
    }
}
