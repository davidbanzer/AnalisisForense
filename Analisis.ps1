
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
    if (-not (test-Path -Path './Reportes Auditoria/Auditoria Date & Days')) {
        New-Item -Path './Reportes Auditoria/Auditoria Date & Days' -ItemType Directory
    }
    
    Write-Info "Zona Horaria"
    Write-Before ("*****")
    Get-TimeZone | Out-File -FilePath './Reportes Auditoria/Auditoria Date & Days/Config DATE & DAYS.txt'
    Write-After ("*****")
}

function GetFechaHora {
    # Ver Fecha y Hora
    Write-Info "Fecha y Hora"
    Write-Before ("*****")

    $datetimeToString = (Get-Date -format "yyyy-MM-dd ss:mm:HH").ToString()
    $datetimeToString | Out-File -Append './Reportes Auditoria/Auditoria Date & Days/Auditoria Date & Days.txt'
    Write-After ("*****")
}

function GetActualizaciones {
    if (-not (test-Path -Path './Reportes Auditoria/Auditoria Updates')) {
        New-Item -Path './Reportes Auditoria/Auditoria Updates' -ItemType Directory
    }
    # Ver actualizaciones
    Write-Info "Actualizaciones"
    Write-Before ("*****")
    wmic qfe list | Out-File -FilePath './Reportes Auditoria/Auditoria Updates/Auditoria Updates.txt'
    Write-After ("******")
}

function GetDireccionIP {
    if (-not (test-Path -Path './Reportes Auditoria/Auditoria Redes & User')) {
        New-Item -Path './Reportes Auditoria/Auditoria Redes & User' -ItemType Directory
    }
    # Ver direccion
    Write-Info "Direcciones IP"
    Write-Before ("*****")
    Get-NetIPAddress | Format-Table | Out-File -FilePath './Reportes Auditoria/Auditoria Redes & User/Auditoria Redes & User.txt'
    Write-After ("*****")
}

function GetTarjetasRed {
    # Ver adaptadores
    Write-Info "Tarjetas de Red"
    Write-Before ("*****")
    Get-NetAdapter | Format-Table | Out-File -Append './Reportes Auditoria/Auditoria Redes & User/Auditoria Redes & User.txt'
    Write-After ("*****")
}

function GetIPv6 {
    Write-Info "Verificar si el protocolo IPv6 está habilitado"
    Write-Before ("*****")
    [System.Net.Sockets.Socket]::OSSupportsIPv6
    Write-After ("*****")
}

function GetNombreEquipo {
    # Ver nombre equipo
    Write-Info "Nombre del Equipo"
    Write-Before ("*****")
    hostname | Out-File -Append './Reportes Auditoria/Auditoria Redes & User/Auditoria Redes & User.txt'
    Write-After ("******")
}

function GetUsuarios {
    # Ver usuarios
    Write-Info "Usuarios"
    Write-Before ("*****")
    Get-LocalUser | Format-Table | Out-File -Append './Reportes Auditoria/Auditoria Redes & User/Auditoria Redes & User.txt'
    Write-After ("*****")
}

function GetDominio {
    # Ver dominio
    Write-Info "Dominio"
    Write-Before ("*****")
    Get-WMIObject Win32_ComputerSystem | Select-Object -ExpandProperty Domain | Out-File -Append './Reportes Auditoria/Auditoria Redes & User/Auditoria Redes & User.txt'
    Write-After ("*****")

}

function GetCategoriasAuditoria {
    # Ver categorias de auditoria
    Write-Info "Categorias de Auditoria"
    Write-Before ("*****")
    auditpol /get /category:* 
    Write-After ("******")
}

function GetSubcategoriasAuditoria {
    # Ver subcategorias de auditoria
    Write-Info "Subcategorias de Auditoria"
    Write-Before ("*****")
    auditpol /list /subcategory:* 
    Write-After ("******")
}

function GetSistemaArchivos {
    # Ver sistema de archivos
    Write-Info "Sistema de Archivos"
    Write-Before ("*****")
    Get-Volume | Format-Table
    Write-After ("*****")
}


function configuracionEFS {
    # TODO Falta corregir 1.- activacion de encryptacion 2.- asignacion de certificado DRA 
    Set-Location ./certificados_EFS
    cipher /r:EFSRA #Input usado para crear Pass PFX es auditoria
    
    Set-Location ../verificar_certificado_DRA_del_sistema_EFS
    fsutil behavior set disableencryption 0
    
}

function getCertificadoDRASystemEFS {
    Write-Info "Verificar el sistema de cifrado de archivos y carpetas (EFS)."
    Write-Before ("*****")

    if (-not (test-Path -Path "./certificados_EFS/*")) {
        configuracionEFS
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
    Write-Info "Programas Instalados"
    Write-Before ("*****")
    Get-WmiObject -Class Win32_Product
     
    Write-After ("*****")
}

function GetSistemaOperativo {
    # Ver sistema operativo
    Write-Info "Nombre del Sistema Operativo"
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
    # Ver los últimos 20 logs del sistema
    Write-Info "Ultimos 20 Logs del Sistema"
    Write-Before ("*****")
    Get-EventLog -LogName System -Newest 20
    Write-After ("*****")
}

function GetLogError {
    # Ver los últimos 20 logs de error
    Write-Info "Ultimos 20 Logs de Error"
    Write-Before ("*****")
    Get-EventLog -LogName System -EntryType Error -Newest 20
    Write-After ("*****")
}

GetZonaHoraria
GetFechaHora
GetActualizaciones
GetDireccionIP
GetTarjetasRed
GetIPv6
GetNombreEquipo
GetUsuarios
GetDominio
GetCategoriasAuditoria
GetSubcategoriasAuditoria
GetSistemaArchivos
#getCertificadoDRASystemEFS
GetProgramasInstalados
GetSistemaOperativo
GetVersionSistemaOperativo
GetUltimoArranque
GetLogSistema
GetLogError