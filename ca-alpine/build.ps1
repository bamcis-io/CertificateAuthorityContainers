Param(
	[Parameter(Position = 0, ValueFromPipeline = $true)]
	[ValidateNotNullOrEmpty()]
	[System.String]$CAConfigurationFile,

	[Parameter()]
	[System.String]$Country = "",

	[Parameter()]
	[System.String]$Location = "",

	[Parameter()]
	[System.String]$State = "",

	[Parameter()]
	[System.String]$OU = "",

	[Parameter()]
	[System.String]$Organization = "",

	[Parameter()]
	[System.String]$CN = "",

	[Parameter()]
	[ValidateNotNullOrEmpty()]
	[System.String]$Version = "1.0.0"
)

$Conf = @()

if (-not [System.String]::IsNullOrEmpty($CAConfigurationFile))
{
	$Conf += "CA_REQUEST_FILE=$CAConfigurationFile"
}

if (-not [System.String]::IsNullOrEmpty($Country))
{
	$Conf += "C=$Country"
}

if (-not [System.String]::IsNullOrEmpty($Location))
{
	$Conf += "L=$Location"
}

if (-not [System.String]::IsNullOrEmpty($State))
{
	$Conf += "ST=$State"
}

if (-not [System.String]::IsNullOrEmpty($Organization))
{
	$Conf += "O=$Organization"
}

if (-not [System.String]::IsNullOrEmpty($OU))
{
	$Conf += "OU=$OU"
}

if (-not [System.String]::IsNullOrEmpty($CN))
{
	$Conf += "CN=$CN"
}

$Args = @("build", "../ca-alpine", "-t", "bamcis/ca-alpine:$Version", "-t", "bamcis/ca-alpine:latest")

foreach ($Item in $Conf)
{
	$Args += "--build-arg"
	$Args += "`"$Item`""
}

Start-Process -FilePath "docker" -ArgumentList $Args -NoNewWindow