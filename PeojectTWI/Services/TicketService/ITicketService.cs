using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PeojectTWI.Models;
using System.Threading.Tasks;

namespace PeojectTWI.Services.TicketService
{
    interface ITicketService
    {
        int AddTicket(string SerialNumber, string TicketRemark, int User);

        List<Ticket> GetTicketDetailsToassign(int ticketId);

        List<user> GetTicketHandlers();
        int AssignTicketToHandler(int ticketID, int assignToUsrer, int LoggedUserID);
        List<Ticket> LogadPendingTickets(int LoggedUser);

        List<Ticket> LoadTicketdetailsToManage(int TicketID);
    }
}
