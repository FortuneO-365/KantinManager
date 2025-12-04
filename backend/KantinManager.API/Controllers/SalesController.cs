using KantinManager.API.Data;
using KantinManager.API.DTOs.SalesDtos;
using KantinManager.API.Models;
using KantinManager.API.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KantinManager.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SalesController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly JwtService _jwtService;

        public SalesController(AppDbContext context, JwtService jwtService)
        {
            _context = context;
            _jwtService = jwtService;
        }

        [HttpPost]
        public async Task<IActionResult> CreateSale(CreateSaleDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var userId = GetUserId();
            if (userId == null)
            {
                return Unauthorized("Missing or Invalid Token");
            } else if (userId == "No token" || userId == "No Claim" || userId == "Error")
            {
                return Unauthorized("Invalid Token");
            }

            var product = await _context.Products.FirstOrDefaultAsync(p => 
                p.Id == dto.productId && p.UploadedBy == int.Parse(userId));

            if (product == null)
            {
                return NotFound("Product not found");
            }

            if (product.Quantity < dto.quantity)
            {
                return BadRequest("Insufficient product quantity");
            }

            product.Quantity -= dto.quantity;

            var sale = new Sales
            {
                ProductId = dto.productId,
                QuantitySold = dto.quantity,
                UnitPrice = product.SellingPrice,
                TotalPrice = product.SellingPrice * dto.quantity,
                UploadedBy = int.Parse(userId)
            };

            _context.Sales.Add(sale);
            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Sale recorded successfully",
                sale
            });
        }

        [HttpGet]
        public async Task<IActionResult> GetSales()
        {
            var userId = GetUserId();
            if (userId == null)
            {
                return Unauthorized("Missing or Invalid Token");
            } else if (userId == "No token" || userId == "No Claim" || userId == "Error")
            {
                return Unauthorized("Invalid Token");
            }
            var sales = await _context.Sales
                .Where(s => s.UploadedBy == int.Parse(userId))
                .ToListAsync();
            return Ok(sales);
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
