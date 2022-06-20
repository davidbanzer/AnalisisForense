
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

function Write-exclamation($text) {
    Write-Host $text -ForegroundColor RED
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

function GetTarjetasRed {
    # Ver adaptadores
    Write-Info "1. c) Tarjetas de Red"
    Write-Before ("*****")
    Get-NetAdapter | Format-Table
    Write-After ("******")
}

function GetNombreEquipo {
    # Ver nombre equipo
    Write-Info "1. d) Nombre del Equipo"
    Write-Before ("*****")
    hostname 
    Write-After ("******")
}

function GetUsuarios {
    # Ver usuarios
    Write-Info "1. d) Usuarios"
    Write-Before ("*****")
    Get-LocalUser | Format-Table
    Write-After ("******")
}

function GetDominio {
    # Ver dominio
    Write-Info "1. e) Dominio"
    Write-Before ("*****")
    Get-WMIObject Win32_ComputerSystem | Select-Object -ExpandProperty Domain
    Write-After ("******")

}

function GetCategoriasAuditoria {
    # Ver categorias de auditoria
    Write-Info "1. e) Categorias de Auditoria"
    Write-Before ("*****")
    auditpol /get /category:* 
    Write-After ("******")
}

function GetSubcategoriasAuditoria {
    # Ver subcategorias de auditoria
    Write-Info "1. e) Subcategorias de Auditoria"
    Write-Before ("*****")
    auditpol /list /subcategory:* 
    Write-After ("******")
}

function GetSistemaArchivos {
    # Ver sistema de archivos
    Write-Info "4. a) Sistema de Archivos"
    Write-Before ("*****")
    Get-Volume
    Write-After ("******")
}


function configuracinEFS {
    # TODO Falta corregir 1.- activacion de encryptacion 2.- asignacion de certificado DRA 
    Set-Location ./certificados_EFS
    cipher /r:EFSRA #Input usado para crear Pass PFX es auditoria
    
    Set-Location ../verificar_certificado_DRA_del_sistema_EFS
    fsutil behavior set disableencryption 0
    
}

function getCertificadoDRASystemEFS {
    Write-Info "4. b) Verificar el sistema de cifrado de archivos y carpetas (EFS)."
    Write-Before ("*****")

    if (-not (test-Path -Path "./certificados_EFS/*")) {
        configuracinEFS
    }

    Set-Location ./verificar_certificado_DRA_del_sistema_EFS

    Write-exclamation("******")
    cipher *
    Write-exclamation("******")

    Set-Location ..
    Write-After ("******")
}

function GetProgramasInstalados {
    # Ver programas instalados
    Write-Info "4. b) Programas Instalados"
    Write-Before ("*****")
    Get-WmiObject -Class Win32_Product | Select-Object -Property Name
    Write-After ("******")
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
getCertificadoDRASystemEFS
GetProgramasInstalados
