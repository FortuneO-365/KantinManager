using KantinManager.API.Data;
using KantinManager.API.DTOs.ProductDtos;
using KantinManager.API.Models;
using KantinManager.API.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KantinManager.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly JwtService _jwtService;
        private readonly CloudinaryService _cloudinary;

        public ProductController(AppDbContext context, JwtService jwtService, CloudinaryService cloudinary)
        {
            _context = context;
            _jwtService = jwtService;
            _cloudinary = cloudinary;
        }

        [HttpPost]
        public async Task<IActionResult> CreateProduct(CreateProductDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var userId = GetUserId();
            if (userId == null)
            {
                return Unauthorized("Missing or Invalid Token");
            }
            else if (userId == "No token" || userId == "No Claim" || userId == "Error")
            {
                return Unauthorized("Invalid Token");
            }

            var product = new Product
            {
                Name = dto.ProductName,
                SellingPrice = dto.SellingPrice,
                Quantity = dto.Quantity,
                Currency = dto.Currency,
                UploadedBy = int.Parse(userId)
            };

            _context.Products.Add(product);
            await _context.SaveChangesAsync();

            return Ok("Product Added Successfully");
        }

        [HttpGet]
        public async Task<IActionResult> GetAllProducts()
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

            var products = await _context.Products
                .Where(p => p.UploadedBy == int.Parse(userId))
                .ToListAsync();

            return Ok(products);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetProductDetails(int id)
        {
            var userId = GetUserId();
            if (userId == null)
            {
                return Unauthorized("Missing or Invalid Token");
            }
            else if (userId == "No token" || userId == "No Claim" || userId == "Error")
            {
                return Unauthorized("Invalid");
            }

            var product = await _context.Products.FirstOrDefaultAsync(p => p.Id == id && p.UploadedBy == int.Parse(userId));

            if (product == null)
            {
                return NotFound("No product found");
            }

            return Ok(product);

        }

        [HttpPatch("{id}")]
        public async Task<IActionResult> UpdateProduct(int id, UpdateProductDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var userId = GetUserId();
            if (userId == null)
            {
                return Unauthorized("Missing or Invalid Token");
            }
            else if (userId == "No token" || userId == "No Claim" || userId == "Error")
            {
                return Unauthorized("Invalid Token");
            }

            var product = await _context.Products.FirstOrDefaultAsync(p => p.Id == id && p.UploadedBy == int.Parse(userId));
            if (product == null)
            {
                return NotFound("No product found");
            }

            if (!string.IsNullOrEmpty(dto.ProductName)) 
            {
                product.Name = dto.ProductName;
            }

            if (!string.IsNullOrEmpty(dto.SellingPrice.ToString())) 
            {
                product.SellingPrice = dto.SellingPrice;
            }

            if (!string.IsNullOrEmpty(dto.Quantity.ToString())) 
            {
                product.Quantity = dto.Quantity;
            }

            if (!string.IsNullOrEmpty(dto.Currency.ToString())) 
            {
                product.Currency = dto.Currency;
            }

            await _context.SaveChangesAsync();

            return Ok("Product Updated Successfully");

        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduct(int id)
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

            var product = await _context.Products.FirstOrDefaultAsync(p => p.Id == id && p.UploadedBy == int.Parse(userId));

            if (product == null)
            {
                return NotFound("No product found");
            }

            _context.Products.Remove(product);
            await _context.SaveChangesAsync();

            return Ok("Account deleted successfully");
        }

        [HttpPost("upload-image/{id}")]
        public async Task<IActionResult> UploadProductImage(int id, IFormFile file)
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

            if (file == null || file.Length == 0)
                return BadRequest("No file uploaded");

            var product = await _context.Products.FirstOrDefaultAsync(p => p.Id == id && p.UploadedBy == int.Parse(userId));
            if (product == null)
            {
                return NotFound("No product found");
            }

            try
            {
                var imageUrl = await _cloudinary.UploadProductImage(file);

                product.PhotoUrl = imageUrl;

                await _context.SaveChangesAsync();

                return Ok(new { imageUrl });
            }
            catch(Exception ex)
            {
                return StatusCode(500, ex.Message);
            }

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
