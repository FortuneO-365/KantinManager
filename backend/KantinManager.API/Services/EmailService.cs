using Azure.Core;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System.Net;
using System.Net.Mail;
using System.Numerics;
using System.Text;
using static System.Net.Mime.MediaTypeNames;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text.Json;

public class EmailService
{
    private readonly HttpClient _http;
    private readonly IConfiguration _config;

    public EmailService(HttpClient http, IConfiguration config)
    {
        _http = http;
        _config = config;
    }

    public async Task SendVerificationEmail(string to, string code)
    {
        var apiKey = _config["Brevo:Api_Key"];
        var fromEmail = _config["Brevo:FromEmail"];
        var fromName = "KantinFlow";

        var payload = new
        {
            sender = new
            {
                email = fromEmail,
                name = fromName
            },
            to = new[]
            {
                new { email = to }
            },
            subject = "Your Verification Code",
            htmlContent = GetVerificationTemplate(code)
        };

        var request = new HttpRequestMessage(
            HttpMethod.Post,
            "https://api.brevo.com/v3/smtp/email"
        );

        request.Headers.Add("api-key", apiKey);
        request.Content = new StringContent(
            JsonSerializer.Serialize(payload),
            Encoding.UTF8,
            "application/json"
        );

        var response = await _http.SendAsync(request);

        if (!response.IsSuccessStatusCode)
        {
            var error = await response.Content.ReadAsStringAsync();
            throw new Exception($"Brevo API error: {error}");
        }
    }

    public async Task SendResetPasswordEmail(string to, string code)
    {
        var apiKey = _config["Brevo:Api_Key"];
        var fromEmail = _config["Brevo:FromEmail"];
        var fromName = "KantinFlow";

        var payload = new
        {
            sender = new
            {
                email = fromEmail,
                name = fromName
            },
            to = new[]
            {
                new { email = to }
            },
            subject = "Reset Password Code",
            htmlContent = GetResetPasswordTemplate(code)
        };

        var request = new HttpRequestMessage(
            HttpMethod.Post,
            "https://api.brevo.com/v3/smtp/email"
        );

        request.Headers.Add("api-key", apiKey);
        request.Content = new StringContent(
            JsonSerializer.Serialize(payload),
            Encoding.UTF8,
            "application/json"
        );

        var response = await _http.SendAsync(request);

        if (!response.IsSuccessStatusCode)
        {
            var error = await response.Content.ReadAsStringAsync();
            throw new Exception($"Brevo API error: {error}");
        }
    }

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
      </body>
      
</html>";
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
          </body>
    </html>";
    }
}

