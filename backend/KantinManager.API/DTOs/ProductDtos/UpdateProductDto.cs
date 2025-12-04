using KantinManager.API.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs.ProductDtos
{
    public class UpdateProductDto
    {
        public string ProductName { get; set; } = string.Empty;

        public decimal SellingPrice { get; set; }

        public int Quantity { get; set; }

        [DataType(DataType.Currency, ErrorMessage = "Invalid currency types.")]
        public Currency Currency { get; set; } = Currency.NGN;
    }
}
