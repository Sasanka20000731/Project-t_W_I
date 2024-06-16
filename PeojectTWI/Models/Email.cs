using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Globalization;

namespace PeojectTWI.Models
{
    public class Email
    {
        public void SendEmail(string to, string fromAddress, string password, string subject, string body)
        {
            // Create a new instance of the SmtpClient class
            //SmtpClient client = new SmtpClient("smtp.gmail.com", 587); // Use the appropriate SMTP server and port
           // SmtpClient client = new SmtpClient("smtp.gmail.com", 465);
            SmtpClient client = new SmtpClient("smtp.gmail.com", 587); // Example for Gmail

            // Enable SSL
            client.EnableSsl = true;
          
            // Set the credentials
            client.Credentials = new NetworkCredential(fromAddress, password);

            // Create a new MailMessage object
            MailMessage mailMessage = new MailMessage();
            mailMessage.From = new MailAddress(fromAddress);
            mailMessage.To.Add(to);
            mailMessage.Subject = subject;
            mailMessage.Body = body;

            // Send the email
            //client.Send(mailMessage);
            try
            {
                // Send the email
                client.Send(mailMessage);
            }
            catch (SmtpException smtpEx)
            {
                // Handle SMTP exceptions
                Console.WriteLine($"SMTP Exception: {smtpEx.Message}");
                if (smtpEx.InnerException != null)
                {
                    Console.WriteLine($"Inner Exception: {smtpEx.InnerException.Message}");
                }
                throw;
            }
            catch (Exception ex)
            {
                // Handle other potential exceptions
                Console.WriteLine($"General Exception: {ex.Message}");
                if (ex.InnerException != null)
                {
                    Console.WriteLine($"Inner Exception: {ex.InnerException.Message}");
                }
                throw;
            }
        }

        public bool IsValidEmail(string emailAddress)
        {
            if (string.IsNullOrWhiteSpace(emailAddress))
                return false;

            try
            {
                // Normalize the domain
                emailAddress = Regex.Replace(emailAddress, @"(@)(.+)$", DomainMapper, RegexOptions.None, TimeSpan.FromMilliseconds(200));

                // Examines the domain part of the email and normalizes it.
                string DomainMapper(Match match)
                {
                    // Use IdnMapping class to convert Unicode domain names.
                    var idn = new IdnMapping();

                    // Pull out and process domain name (throws ArgumentException on invalid)
                    string domainName = idn.GetAscii(match.Groups[2].Value);

                    return match.Groups[1].Value + domainName;
                }
            }
            catch (RegexMatchTimeoutException e)
            {
                return false;
            }
            catch (ArgumentException e)
            {
                return false;
            }

            try
            {
                return Regex.IsMatch(emailAddress,
                    @"^[^@\s]+@[^@\s]+\.[^@\s]+$",
                    RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(250));
            }
            catch (RegexMatchTimeoutException)
            {
                return false;
            }
        }
    }
}