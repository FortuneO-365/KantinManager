using Microsoft.AspNetCore.Mvc;

namespace KantinManager.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HomeController : Controller
    {
        [HttpGet("")]
        public String Index()
        {
            var response = "Welcome to Kantin Manager Api";
            return response;
        }
    }
}
