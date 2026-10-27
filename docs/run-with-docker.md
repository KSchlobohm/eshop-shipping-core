# Run with Docker

Requires Docker with a running Linux-container engine. A Docker client alone
is not sufficient. The image uses the legacy .NET SDK and ASP.NET Core runtime.
.NET Core 3.1 is unsupported; this is a legacy test baseline, not a production recommendation.

Stop any native instance using port 5080 first. Run these commands from the
repository root:

```powershell
docker build --tag eshop-shipping-core:local .
docker run --rm --name eshop-shipping-core-local --publish 127.0.0.1:5080:8080 eshop-shipping-core:local
```

In another terminal, try the [HTTP example](../README.md#api) or run the
[behavior checks](testing.md).

Stop the container from another terminal with `docker stop eshop-shipping-core-local`.
