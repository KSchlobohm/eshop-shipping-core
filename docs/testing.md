# Behavior checks

Start the API [locally](run-locally.md) or [with Docker](run-with-docker.md).
In another terminal, use **PowerShell 7 or later** from the repository root:

```powershell
pwsh -File .\tests\Smoke.Tests.ps1
```

The script checks submission, retrieval, invalid requests, and an unknown ID.
It also checks that `/swagger/v1/swagger.json` returns an OpenAPI 3 document
describing the shipment operations. NSwag generates the document from the API,
which uses Newtonsoft.Json for JSON serialization.
It exits with an error on failure. Use `-BaseUrl http://localhost:5090` to check
an instance on another port.
