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

        List<Ticket> GetTicketDetailsToassign(int ticketId);

        List<user> GetTicketHandlers();

    }
}
