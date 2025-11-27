using KantinManager.API.Models.Enums;

namespace KantinManager.API.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string? PhotoUrl { get; set; }
        public decimal? CostPrice { get; set; }
        public decimal SellingPrice { get; set; }
        public int Quantity { get; set; }
        public Currency Currency { get; set; } = Currency.NGN;
        public int UploadedBy { get; set; }
    }
}
