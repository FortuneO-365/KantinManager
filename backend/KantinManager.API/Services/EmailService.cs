using Azure.Core;
using KantinManager.API.DTOs.BrevoDtos;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System.Net;
using System.Net.Mail;
using System.Numerics;
using System.Text;
using System.Text.Json;
using static System.Net.Mime.MediaTypeNames;

public class EmailService
{
    private readonly HttpClient _http;
    private readonly IConfiguration _config;
    private readonly string _apiKey;
    private readonly string _fromEmail;
    private const string FromName = "KantinFlow";
    private const string BrevoApiUrl = "https://api.brevo.com/v3/smtp/email";

    public EmailService(HttpClient http, IConfiguration config)
    {
        _http = http;
        _config = config;

        // 🚨 CRITICAL FIX: Load config values in the constructor
        // and throw immediately if they are missing. This makes configuration
        // errors happen at startup, not runtime.
        _apiKey = _config["Brevo_Api_Key"]
                  ?? throw new ArgumentNullException("Brevo:Api_Key is missing in configuration.");

        _fromEmail = _config["Brevo_FromEmail"]
                     ?? throw new ArgumentNullException("Brevo:FromEmail is missing in configuration.");

        // Ensure the API key header is set globally if HttpClient is scoped/singleton
        // However, setting it per-request is safer for demonstration.
    }

    // New internal method to handle the API call and error logic
    private async Task SendBrevoEmail(string toEmail, string toName, string subject, string htmlBody)
    {
        // 1. Construct the payload using DTOs
        var payload = new BrevoSendEmailRequest
        {
            Sender = new BrevoDto { Email = _fromEmail, Name = FromName },
            To = new List<BrevoDto> { new BrevoDto { Email = toEmail, Name = toName } },
            Subject = subject,
            HtmlContent = htmlBody
        };

        // 2. Prepare the request
        var request = new HttpRequestMessage(HttpMethod.Post, BrevoApiUrl);

        // 🚨 CRITICAL FIX: Use the stored API key
        request.Headers.Add("api-key", _apiKey);

        request.Content = new StringContent(
            JsonSerializer.Serialize(payload),
            Encoding.UTF8,
            "application/json"
        );

        // 3. Send the request
        var response = await _http.SendAsync(request);

        // 4. Handle non-success responses
        if (!response.IsSuccessStatusCode)
        {
            var error = await response.Content.ReadAsStringAsync();
            // This now throws an exception with the explicit Brevo error body
            // e.g., "Brevo API error: { "code": "bad_request", "message": "Input must be a valid JSON object" }"
            throw new Exception($"Brevo API error: {response.StatusCode}. Details: {error}");
        }
    }

    public async Task SendVerificationEmail(string toEmail,string toName, string code)
    {
        var htmlContent = GetVerificationTemplate(code);
        await SendBrevoEmail(toEmail, toName, "Your Verification Code", htmlContent);
    }

    public async Task SendResetPasswordEmail(string toEmail, string toName, string code)
    {
        var htmlContent = GetResetPasswordTemplate(code);
        await SendBrevoEmail(toEmail, toName, "Reset Password Code", htmlContent);
    }

    // (Keep GetVerificationTemplate and GetResetPasswordTemplate methods as they were)
    // ...
    private string GetVerificationTemplate(string code)
    {
        return @$"<!DOCTYPE html>
            <html>
        <head>
            <style>
                *{{
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    font-family: Arial, Helvetica, sans-serif;
                }}
                html{{
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }}
                body{{
                    box-shadow: 0px 0px 3px gray ;
                    width: 80dvh;
                    max-width: 500px;
                    height: fit-content;
                    color: #333
                }}
                table{{
                    border-collapse: collapse;
                    margin: 10px 20px;
                }}
                th{{
                    text-align: left;
                    padding-bottom: 30px;
                }}
                h1{{
                    margin-bottom: 10px;
                }}
                p{{
                    padding-bottom: 10px;
                }}
                h2{{
                    padding: 30px 0;
                    letter-spacing: 3px; 
                    font-size: 28px; 
                    margin: 10px 0;
                }}
                td:last-child{{
                    padding-top: 30px;
                }}
            </style>
        </head>
        <body>
            <table cellpadding=""0"" cellspacing=""0"">
              <tr>
                <th>
                  <h1>KantinFlow</h1>
                </th>
              </tr>
      
              <tr>
                <td>
                  <p>
                    Thank you for signing up with KantinFlow. Your account has been successfully created.  
                    To complete your registration, please use the verification code below:
                  </p>
                  <p><strong>Your verification code:</strong></p>
                </td>
              </tr>
      
              <tr>
                <td>
                  <h2>
                    {code}
                  </h2>
                </td>
              </tr>
      
              <tr>
                <td>
                  <p>
                    If you did not initiate this request, please ignore this message.
                  </p>
                  <p>
                    Best Regards,<br>
                    <strong>KantinFlow Team</strong>
                  </p>
                </td>
              </tr>
            </table>
          </body>";
    }

    private string GetResetPasswordTemplate(string code)
    {
        return @$"<!DOCTYPE html>
            <html>
        <head>
            <style>
                *{{
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    font-family: Arial, Helvetica, sans-serif;
                }}
                html{{
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }}
                body{{
                    box-shadow: 0px 0px 3px gray ;
                    width: 80dvh;
                    max-width: 500px;
                    height: fit-content;
                    color: #333
                }}
                table{{
                    border-collapse: collapse;
                    margin: 10px 20px;
                }}
                th{{
                    text-align: left;
                    padding-bottom: 30px;
                }}
                h1{{
                    margin-bottom: 10px;
                }}
                p{{
                    padding-bottom: 10px;
                }}
                h2{{
                    padding: 30px 0;
                    letter-spacing: 3px; 
                    font-size: 28px; 
                    margin: 10px 0;
                }}
                td:last-child{{
                    padding-top: 30px;
                }}
            </style>
        </head>
        <body>
            <table cellpadding=""0"" cellspacing=""0"">
                <tr>
                    <th>
                    <h1> KantinFlow </h1>
                    </th>
                </tr>
                <tr>          
                    <td>
                    <p>
                        You have initiated the process to reset your password.  
                        To complete your password reset, please use the reset password code below:
                      </p>
                      <p><strong> Your reset password code:</strong></p>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <h2>
                        {code}
                      </h2>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <p>
                        If you did not initiate this request, please ignore this message.
                      </p>
                      <p>
                        Best Regards,<br>
                        <strong> KantinFlow Team </strong>
                      </p>
                    </td>
                  </tr>
                </table>
              </body>";
    }
}