using Azure.Core;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System.Net;
using System.Net.Mail;
using System.Numerics;
using static System.Net.Mime.MediaTypeNames;

public class EmailService
{
    private readonly IConfiguration _config;

    public EmailService(IConfiguration config)
    {
        _config = config;
    }

    public async Task SendVerificationEmail(string to, string code)
    {
        var host = _config["Brevo:SmtpHost"];
        var port = int.Parse(_config["Brevo:Port"]!);
        var username = _config["Brevo:Username"];      // Your Brevo login email
        var password = _config["Brevo:Password"];      // Your SMTP KEY
        var fromEmail = _config["Brevo:FromEmail"];

        var message = new MailMessage();
        message.From = new MailAddress(fromEmail!);
        message.To.Add(to);
        message.Subject = "Your Verification Code";
        message.Body = @$"<!DOCTYPE html>
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
        message.IsBodyHtml = true;

        using var client = new SmtpClient(host, port);
        client.Credentials = new NetworkCredential(username, password);
        client.EnableSsl = true;
        client.UseDefaultCredentials = false;   // IMPORTANT

        await client.SendMailAsync(message);
    }

    public async Task SendResetPasswordEmail(string to, string code)
    {
        var host = _config["Brevo:SmtpHost"];
        var port = int.Parse(_config["Brevo:Port"]!);
        var username = _config["Brevo:Username"];      // Your Brevo login email
        var password = _config["Brevo:Password"];      // Your SMTP KEY
        var fromEmail = _config["Brevo:FromEmail"];

        var message = new MailMessage();
        message.From = new MailAddress(fromEmail!);
        message.To.Add(to);
        message.Subject = "Your Reset Password Code";
        message.Body = @$"<!DOCTYPE html>
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
        message.IsBodyHtml = true;

        using var client = new SmtpClient(host, port);
        client.Credentials = new NetworkCredential(username, password);
        client.EnableSsl = true;
        client.UseDefaultCredentials = false;   // IMPORTANT

        await client.SendMailAsync(message);
    }
}
