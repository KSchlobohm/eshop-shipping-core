using System;
using Microsoft.AspNetCore.Mvc;
using Shipping.Api.Models;

namespace Shipping.Api.Controllers
{
    [ApiController]
    [Route("shipments")]
    public class ShipmentsController : ControllerBase
    {
        private readonly ShipmentStore _shipments;

        public ShipmentsController(ShipmentStore shipments)
        {
            _shipments = shipments;
        }

        [HttpPost]
        public ActionResult<Shipment> Submit(CreateShipmentRequest request)
        {
            var shipment = _shipments.Submit(request.Recipient, request.Destination);
            return CreatedAtAction(nameof(Get), new { id = shipment.Id }, shipment);
        }

        [HttpGet("{id:guid}")]
        public ActionResult<Shipment> Get(Guid id)
        {
            var shipment = _shipments.Find(id);
            if (shipment == null)
            {
                return NotFound();
            }

            return shipment;
        }
    }
}
