FROM mcr.microsoft.com/dotnet/sdk:3.1.426 AS build
WORKDIR /src
COPY global.json .
COPY src/Shipping.Api/Shipping.Api.csproj src/Shipping.Api/
RUN dotnet restore src/Shipping.Api/Shipping.Api.csproj
COPY src/Shipping.Api/ src/Shipping.Api/
RUN dotnet publish src/Shipping.Api/Shipping.Api.csproj --configuration Release --no-restore --output /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:3.1.32
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Shipping.Api.dll"]
