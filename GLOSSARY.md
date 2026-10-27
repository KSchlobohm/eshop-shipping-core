# Glossary

| Term | Meaning |
|------|---------|
| Shipping API | The ASP.NET Core Web API for submitting and reading fictional eShop shipments. |
| Shipment | An in-memory submission containing an ID, recipient, destination, and submission time; it does not dispatch a parcel. |
| Legacy test baseline | The unsupported .NET Core 3.1 starting application, used for testing rather than production. |
| .NET upgrade | Moving the sample from .NET Core 3.1 to a newer .NET runtime. |
| Container validation | Checking that the application builds and runs in a container. |
| Dockerfile | A file describing how to build the application's container image. |
| Behavior checks | Automated HTTP requests checking the same shipment workflow against a native process or container. |
