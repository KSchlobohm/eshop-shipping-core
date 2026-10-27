# Run locally

Install .NET Core SDK **3.1.426**, including the ASP.NET Core **3.1.32** runtime.
`global.json` selects the legacy SDK even when newer SDKs are installed.
.NET Core 3.1 is unsupported; this is a legacy test baseline, not a production recommendation.

Run these commands from the repository root:

```powershell
dotnet build .\src\Shipping.Api\Shipping.Api.csproj --configuration Release
dotnet run --project .\src\Shipping.Api\Shipping.Api.csproj --configuration Release --no-build -- --urls http://localhost:5080
```

In another terminal, try the [HTTP example](../README.md#api) or run the
[behavior checks](testing.md).

Stop the API with Ctrl+C.
