#Requires -Version 7.0
param(
    [string] $BaseUrl = 'http://localhost:5080'
)

$ErrorActionPreference = 'Stop'
$base = $BaseUrl.TrimEnd('/')

function Assert-True([bool] $Condition, [string] $Message) {
    if (-not $Condition) {
        throw "FAIL: $Message"
    }
}

$request = @{
    recipient = 'Avery Example'
    destination = '12 Parcel Road, Sampletown'
} | ConvertTo-Json

$created = Invoke-WebRequest -Uri "$base/shipments" -Method Post `
    -ContentType 'application/json' -Body $request -SkipHttpErrorCheck -TimeoutSec 10
Assert-True ($created.StatusCode -eq 201) 'Submission must return 201.'
$shipment = $created.Content | ConvertFrom-Json
Assert-True ([Guid]::Parse($shipment.id) -ne [Guid]::Empty) 'Shipment must have an ID.'
Assert-True ($shipment.recipient -ceq 'Avery Example') 'Recipient must be preserved.'
Assert-True ($shipment.destination -ceq '12 Parcel Road, Sampletown') 'Destination must be preserved.'
Assert-True ([DateTimeOffset] $shipment.submittedAt -gt [DateTimeOffset]::MinValue) `
    'Shipment must have a submission time.'
$location = [string] $created.Headers.Location
Assert-True ($location -eq "$base/shipments/$($shipment.id)") 'Location must identify the shipment.'
Write-Output 'PASS: Submit a shipment (201 and Location).'

$read = Invoke-WebRequest -Uri $location -SkipHttpErrorCheck -TimeoutSec 10
Assert-True ($read.StatusCode -eq 200) 'Read must return 200.'
Assert-True ($read.Content -ceq $created.Content) 'Read must return the submitted shipment.'
Write-Output 'PASS: Read the submitted shipment (200 and matching data).'

$invalid = Invoke-WebRequest -Uri "$base/shipments" -Method Post `
    -ContentType 'application/json' -Body '{"recipient":"Avery Example"}' `
    -SkipHttpErrorCheck -TimeoutSec 10
Assert-True ($invalid.StatusCode -eq 400) 'Missing destination must return 400.'
# Invoke-WebRequest can expose application/problem+json content as bytes.
$problem = [System.Text.Encoding]::UTF8.GetString($invalid.RawContentStream.ToArray()) | ConvertFrom-Json
Assert-True ($null -ne $problem.errors.Destination) 'Validation must identify the missing destination.'
Write-Output 'PASS: Reject a missing destination (400 and validation detail).'

$blank = Invoke-WebRequest -Uri "$base/shipments" -Method Post `
    -ContentType 'application/json' -Body '{"recipient":" ","destination":"Sampletown"}' `
    -SkipHttpErrorCheck -TimeoutSec 10
Assert-True ($blank.StatusCode -eq 400) 'Blank recipient must return 400.'
Write-Output 'PASS: Reject a blank recipient (400).'

$missingId = [Guid]::NewGuid()
$missing = Invoke-WebRequest -Uri "$base/shipments/$missingId" -SkipHttpErrorCheck -TimeoutSec 10
Assert-True ($missing.StatusCode -eq 404) 'Unknown shipment must return 404.'
Write-Output 'PASS: Report an unknown shipment (404).'

$document = Invoke-WebRequest -Uri "$base/swagger/v1/swagger.json" `
    -SkipHttpErrorCheck -TimeoutSec 10
Assert-True ($document.StatusCode -eq 200) 'OpenAPI document must return 200.'
$openApi = $document.Content | ConvertFrom-Json
Assert-True ($openApi.openapi -like '3.*') 'Document must use OpenAPI 3.'
Assert-True ($null -ne $openApi.paths.'/shipments'.post) 'Document must describe shipment submission.'
Assert-True ($null -ne $openApi.paths.'/shipments/{id}'.get) 'Document must describe shipment retrieval.'
Write-Output 'PASS: Generate the OpenAPI document (200 and shipment operations).'
