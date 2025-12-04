using KantinManager.API.Data;
using KantinManager.API.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KantinManager.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DashboardController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly JwtService _jwtService;

        public DashboardController(AppDbContext context, JwtService jwtService) 
        { 
            _context = context;
            _jwtService = jwtService;
        }

        [HttpGet("summary")]
        public async Task<IActionResult> GetDashboardSummary()
        {
            var userId = GetUserId();
            if (userId == null)
            {
                return Unauthorized("Missing or Invalid Token");
            }
            else if (userId == "No token" || userId == "No Claim" || userId == "Error")
            {
                return Unauthorized("Invalid Token");
            }

            var userIdInt = int.Parse(userId);
            var today = DateTime.UtcNow.Date;
            var monthStart = new DateTime(DateTime.UtcNow.Year, DateTime.UtcNow.Month, 1);

            var totalProducts = await _context.Products
                .Where(p => p.UploadedBy == userIdInt)
                .CountAsync();

            var totalSales = await _context.Sales
                .Where(s => s.UploadedBy == userIdInt)
                .CountAsync();

            var totalRevenue = await _context.Sales
                .Where(s => s.UploadedBy == userIdInt)
                .SumAsync(s => s.TotalPrice);

            var totalToday = await _context.Sales
                .Where(s => s.UploadedBy == userIdInt && s.SaleDate >= today)
                .SumAsync(s => s.TotalPrice);

            var totalMonth = await _context.Sales
                .Where(s => s.UploadedBy == userIdInt && s.SaleDate >= monthStart)
                .SumAsync(s => s.TotalPrice);

            var lowStock = await _context.Products
                .Where(p => p.UploadedBy == userIdInt && p.Quantity < 5)
                .ToListAsync();

            var todayOrders = await _context.Sales
                .Where(s => s.UploadedBy == userIdInt && s.SaleDate >= today)
                .ToListAsync();

            var summary = new
            {
                TotalProducts = totalProducts,
                TotalSales = totalSales,
                TotalRevenue = totalRevenue,
                MonthlyRevenue = totalMonth,
                TodayRevenue = totalToday,
                LowStockProducts = lowStock,
                TodayOrders = todayOrders,
            };
            return Ok(summary);
        }

        private String? GetUserId()
        {
            var authorization = HttpContext.Request.Headers.Authorization.ToString();

            if (string.IsNullOrEmpty(authorization) || !authorization.StartsWith("Bearer "))
                return null;

            var token = authorization.Substring("Bearer ".Length).Trim();

            var userIdString = _jwtService.ValidateToken(token);

            if (userIdString == "No token" || userIdString == "No Claim" || userIdString == "Error")
                return userIdString;

            return userIdString;
        }
    }
}
