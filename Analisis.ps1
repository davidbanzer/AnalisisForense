
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
    Write-Info "Zona Horaria"
    Write-Before ("*****")
    Get-TimeZone
    Write-After ("*****")
}

function GetFechaHora {
    # Ver Fecha y Hora
    Write-Info "Fecha y Hora"
    Write-Before ("*****")
    get-date
    Write-After ("*****")
}

function GetActualizaciones {
    # Ver actualizaciones
    Write-Info "Actualizaciones"
    Write-Before ("*****")
    wmic qfe list
    Write-After ("*****")
}

function GetDireccionIP {
    # Ver direccion
    Write-Info "Direcciones IP"
    Write-Before ("*****")
    Get-NetIPAddress | Format-Table
    Write-After ("*****")
}

function GetTarjetasRed {
    # Ver adaptadores
    Write-Info "Tarjetas de Red"
    Write-Before ("*****")
    Get-NetAdapter | Format-Table
    Write-After ("*****")
}

function GetNombreEquipo {
    # Ver nombre equipo
    Write-Info "Nombre del Equipo"
    Write-Before ("*****")
    hostname
    Write-After ("*****")
}

function GetUsuarios {
    # Ver usuarios
    Write-Info "Usuarios"
    Write-Before ("*****")
    Get-LocalUser | Format-Table
    Write-After ("*****")
}

function GetDominio {
    # Ver dominio
    Write-Info "Dominio"
    Write-Before ("*****")
    Get-WMIObject Win32_ComputerSystem | Select-Object -ExpandProperty Domain
    Write-After ("*****")

}

function GetCategoriasAuditoria {
    # Ver categorias de auditoria
    Write-Info "Categorias de Auditoria"
    Write-Before ("*****")
    auditpol /get /category:*
    Write-After ("*****")
}

function GetSubcategoriasAuditoria {
    # Ver subcategorias de auditoria
    Write-Info "Subcategorias de Auditoria"
    Write-Before ("*****")
    auditpol /list /subcategory:*
    Write-After ("*****")
}

function GetSistemaArchivos {
    # Ver sistema de archivos
    Write-Info "Sistema de Archivos"
    Write-Before ("*****")
    Get-Volume | Format-Table
    Write-After ("*****")
}

function GetProgramasInstalados {
    # Ver programas instalados
    Write-Info "Programas Instalados"
    Write-Before ("*****")
    Get-WmiObject -Class Win32_Product | Select-Object -Property Name 
    Write-After ("*****")
}

function GetSistemaOperativo {
    # Ver sistema operativo
    Write-Info " Operativo"
    Write-Before ("*****")
    (Get-CimInstance -ClassName CIM_OperatingSystem).Caption
    Write-After ("*****")
}

function GetVersionSistemaOperativo {
    # Ver version sistema operativo
    Write-Info "Version Sistema Operativo"
    Write-Before ("*****")
    (Get-CimInstance -ClassName CIM_OperatingSystem).Version
    Write-After ("*****")
}

function GetUltimoArranque {
    # Ver ultimo arranque
    Write-Info "Ultimo Arranque"
    Write-Before ("*****")
    (Get-CimInstance -ClassName CIM_OperatingSystem).LastBootUpTime
    Write-After ("*****")
}

function GetLogSistema {
    # Ver los últimos 50 logs del sistema
    Write-Info "Ultimos 50 Logs del Sistema"
    Write-Before ("*****")
    Get-EventLog -LogName System -Newest 50
    Write-After ("*****")
}

GetZonaHoraria
GetFechaHora
GetActualizaciones
GetDireccionIP
GetTarjetasRed
GetNombreEquipo
GetUsuarios
GetDominio
GetCategoriasAuditoria
GetSubcategoriasAuditoria
GetSistemaArchivos
GetProgramasInstalados
GetSistemaOperativo
GetVersionSistemaOperativo
GetUltimoArranque
GetLogSistema