# eShop Shipping on .NET

A fictional shipping API targeting .NET Core 3.1. Submit a shipment and retrieve
it by ID. Shipments are kept in memory and disappear when the process stops.

**Unsupported legacy test baseline:** .NET Core 3.1 is out of support. This sample
is not a production recommendation.

## Guides

- [Run locally](docs/run-locally.md)
- [Run with Docker](docs/run-with-docker.md)
- [Behavior checks](docs/testing.md)

## API

| Request | Result |
|---------|--------|
| `POST /shipments` | JSON `recipient` (1-100 characters) and `destination` (1-200 characters) produce `201 Created`, a `Location` header, and the shipment with its ID and submission time. Blank or missing fields produce `400 Bad Request` with validation details. |
| `GET /shipments/{id}` | Returns the shipment as JSON with `200 OK`, or `404 Not Found` for an unknown ID. |

With the API running, submit and read a fictional shipment from another terminal:

```powershell
$shipment = Invoke-RestMethod http://localhost:5080/shipments -Method Post -ContentType application/json -Body '{"recipient":"Avery Example","destination":"12 Parcel Road, Sampletown"}'
Invoke-RestMethod "http://localhost:5080/shipments/$($shipment.id)"
```

There is no database, authentication, background processing, or carrier integration.
Use fictional data only.

See [Glossary](GLOSSARY.md) for project terms.
