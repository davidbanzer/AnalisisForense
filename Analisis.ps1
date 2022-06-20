
$fc = $host.UI.RawUI.ForegroundColor
$host.UI.RawUI.ForegroundColor = "white"

function Write-Info($text) {
    Write-Host $text -ForegroundColor Yellow
}

function Write-Before($text) {
    Write-Host $text -ForegroundColor Cyan
}

function Write-After($text) {
    Write-Host $text -ForegroundColor Green
}

Write-Info "Analisis Forense para Auditoria de Sistemas"
Write-Info "Script escrito y testeado por el grupo 1"

function GetZonaHoraria
{
    #1 a) Ver zona horaria
    Write-Info "1. a) Zona Horaria"
	Write-Before ("*****")
    Get-TimeZone
    Write-After ("******")
}

function GetActualizaciones
{
    #2 b) Ver actualizaciones
    Write-Info "1. b) Actualizaciones"
    Write-Before ("*****")
    get-date
    Write-After ("******")
}

GetZonaHoraria
GetActualizaciones