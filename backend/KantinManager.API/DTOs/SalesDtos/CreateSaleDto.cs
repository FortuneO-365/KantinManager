using System.ComponentModel.DataAnnotations;

namespace KantinManager.API.DTOs.SalesDtos
{
    public class CreateSaleDto
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "ProductId can't be empty.")]
        public int productId { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Quantity can't be empty.")]
        public int quantity { get; set; }
    }
}
