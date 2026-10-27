using System.ComponentModel.DataAnnotations;

namespace Shipping.Api.Models
{
    public class CreateShipmentRequest
    {
        [Required]
        [StringLength(100)]
        public string Recipient { get; set; } = string.Empty;

        [Required]
        [StringLength(200)]
        public string Destination { get; set; } = string.Empty;
    }
}
