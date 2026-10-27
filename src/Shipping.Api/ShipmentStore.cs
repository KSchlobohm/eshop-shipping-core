using System;
using System.Collections.Concurrent;
using Shipping.Api.Models;

namespace Shipping.Api
{
    public class ShipmentStore
    {
        private readonly ConcurrentDictionary<Guid, Shipment> _shipments =
            new ConcurrentDictionary<Guid, Shipment>();

        public Shipment Submit(string recipient, string destination)
        {
            var shipment = new Shipment(Guid.NewGuid(), recipient, destination, DateTimeOffset.UtcNow);
            _shipments[shipment.Id] = shipment;
            return shipment;
        }

        public Shipment? Find(Guid id)
        {
            return _shipments.TryGetValue(id, out var shipment) ? shipment : null;
        }
    }
}
