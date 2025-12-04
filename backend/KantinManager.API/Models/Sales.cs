using System.ComponentModel.DataAnnotations.Schema;

namespace KantinManager.API.Models
{
    public class Sales
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public int QuantitySold { get; set; }
        [Column(TypeName = "decimal(18,2)")]
        public decimal UnitPrice { get; set; }
        [Column(TypeName = "decimal(18,2)")]
        public decimal TotalPrice { get; set; }
        public DateTime SaleDate { get; set; } = DateTime.UtcNow;
        public int UploadedBy { get; set; }
    }
}
