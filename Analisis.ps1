
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

function GetZonaHoraria {
    # Ver zona horaria
    Write-Info "1. a) Zona Horaria"
    Write-Before ("*****")
    Get-TimeZone
    Write-After ("******")
}

function GetFechaHora {
    # Ver Fecha y Hora
    Write-Info "1. a) Fecha y Hora"
    Write-Before ("*****")
    get-date
    Write-After ("******")
}

function GetActualizaciones {
    # Ver actualizaciones
    Write-Info "1. b) Actualizaciones"
    Write-Before ("*****")
    wmic qfe list
    Write-After ("******")
}

function GetDireccionIP {
    # Ver direccion
    Write-Info "1. c) Direcciones IP"
    Write-Before ("*****")
    Get-NetIPAddress | Format-Table
    Write-After ("******")
}

GetZonaHoraria
GetFechaHora
GetActualizaciones
GetDireccionIP