using Microsoft.EntityFrameworkCore;
using KantinManager.API.Models;

namespace KantinManager.API.Data
{
    public class AppDbContext: DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }
        public DbSet<User> Users => Set<User>();
        public DbSet<Product> Products { get; set; }

    }
}
