namespace KantinManager.API.DTOs.BrevoDtos
{
    public class BrevoDto
    {
        public string Email { get; set; }
        public string Name { get; set; }
    }

    public class BrevoSendEmailRequest
    {
        public BrevoDto Sender { get; set; }
        public List<BrevoDto> To { get; set; }
        public string Subject { get; set; }
        public string HtmlContent { get; set; }
    }
}
