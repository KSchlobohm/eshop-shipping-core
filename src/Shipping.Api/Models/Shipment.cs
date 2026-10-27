using System;

namespace Shipping.Api.Models
{
    public class Shipment
    {
        public Shipment(Guid id, string recipient, string destination, DateTimeOffset submittedAt)
        {
            Id = id;
            Recipient = recipient;
            Destination = destination;
            SubmittedAt = submittedAt;
        }

        public Guid Id { get; }
        public string Recipient { get; }
        public string Destination { get; }
        public DateTimeOffset SubmittedAt { get; }
    }
}
