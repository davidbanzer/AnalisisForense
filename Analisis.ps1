
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

$FechaPath = "./Reportes Auditoria/Auditoria Fechas"
$FileNameFecha = "Auditoria Fechas.txt"
function GetZonaHoraria {
    # [X] exportado a TXT
    # Ver zona horaria
    if (-not (test-Path -Path $FechaPath)) {
        New-Item -Path $FechaPath -ItemType Directory
    }
    Write-Info "Zona Horaria"
    Write-Output 'Zona Horaria' | Out-File -FilePath $FechaPath/$FileNameFecha
    Write-Output '------------' | Out-File -Append $FechaPath/$FileNameFecha
    Get-TimeZone | Out-File -Append $FechaPath/$FileNameFecha
    Write-Output '-------------------------------------------------------' | Out-File -Append $FechaPath/$FileNameFecha
    Write-After ("TXT " + $FileNameFecha + " Generado.")
}

function GetFechaHora {
    # [X] exportado a TXT
    # Ver Fecha y Hora
    Write-Info "Fecha y Hora"

    Write-Output 'Fecha y Hora' | Out-File -Append $FechaPath/$FileNameFecha
    Write-Output '------------' | Out-File -Append $FechaPath/$FileNameFecha
    $datetimeToString = (Get-Date -format "yyyy-MM-dd ss:mm:HH").ToString()
    $datetimeToString | Out-File -Append $FechaPath/$FileNameFecha
    Write-Output '-------------------------------------------------------' | Out-File -Append $FechaPath/$FileNameFecha

    Write-After ("TXT de " + $FileNameFecha + " Actualizado.")
}

$ActualizacionesPath = "./Reportes Auditoria/Auditoria Actualizaciones"
$FileNameActualizacion = "Auditoria Fechas.txt"
function GetActualizaciones {
    # [X] exportado a TXT
    if (-not (test-Path -Path $ActualizacionesPath)) {
        New-Item -Path $ActualizacionesPath -ItemType Directory
    }
    # Ver actualizaciones
    Write-Info "Actualizaciones"
    Write-Output 'Actualizaciones' | Out-File -FilePath $ActualizacionesPath/$FileNameActualizacion
    Write-Output '------------' | Out-File -Append $ActualizacionesPath/$FileNameActualizacion
    wmic qfe list | Out-File -Append $ActualizacionesPath/$FileNameActualizacion
    Write-After ("TXT de " + $FileNameActualizacion + "  Generado.")
}

$RedesUsuariosPath = "./Reportes Auditoria/Auditoria Redes & Usuarios" 
$FileNameRedesUsuarios = "Auditoria Redes & Usuarios.txt"
function GetDireccionIP {
    # [X] exportado a TXT
    if (-not (test-Path -Path $RedesUsuariosPath)) {
        New-Item -Path $RedesUsuariosPath -ItemType Directory
    }
    # Ver direccion
    Write-Info "Direcciones IP"
    Write-Output 'Direcciones IP' | Out-File -FilePath $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Get-NetIPAddress | Format-Table | Out-File -FilePath $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '-------------------------------------------------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-After ("TXT de " + $FileNameRedesUsuarios + "  Generado.")
}

function GetTarjetasRed {
    # [X] exportado a TXT
    # Ver adaptadores
    Write-Info "Tarjetas de Red"
    Write-Output 'Tarjetas de Red' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Get-NetAdapter | Format-Table | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '-------------------------------------------------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-After ("TXT de " + $FileNameRedesUsuarios + "  Actualizado.")

}

function GetNombreEquipo {
    # [X] exportado a TXT
    # Ver nombre equipo
    Write-Info "Nombre del Equipo"
    Write-Output 'Nombre del Equipo' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    hostname | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '-------------------------------------------------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-After ("TXT de " + $FileNameRedesUsuarios + "  Actualizado.")

}

function GetUsuarios {
    # [X] exportado a TXT
    # Ver usuarios
    Write-Info "Usuarios"
    Write-Output 'Usuarios' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Get-LocalUser | Format-Table | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '-------------------------------------------------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-After ("TXT de " + $FileNameRedesUsuarios + "  Actualizado.")

}

function GetDominio {
    # [X] exportado a TXT
    # Ver dominio
    Write-Info "Dominio"
    Write-Output 'Dominio' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Get-WMIObject Win32_ComputerSystem | Select-Object -ExpandProperty Domain | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '-------------------------------------------------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-After ("TXT de " + $FileNameRedesUsuarios + "  Actualizado.")
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


function configuracinEFS {
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

function GetUnidadesDisco {
    # Ver las unidades de disco
    Write-Info "Unidades de Disco"
    Write-Before ("*****")
    Get-PSDrive -PSProvider FileSystem
    Write-After ("*****")
}

function GetRecursosCompartidos {
    # Ver los recursos compartidos
    Write-Info "Recursos Compartidos"
    Write-Before ("*****")
    Get-SmbShare
    Write-After ("*****")
}

function GetSMB1 {
    # Comprobar si SMB1 está activo
    Write-Info "SMB1"
    Write-Before ("*****")
    Get-WindowsOptionalFeature –Online –FeatureName SMB1Protocol
    Write-After ("*****")
}

function GetUSBConectados {
    # Comprobar los USB conectados
    Write-Info "USB conectados"
    Write-Before ("*****")
    Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' }
    Write-After ("*****")
}

function GetPoliticaContras {
    # Comprobar la política de contraseñas
    Write-Info "Política de Contraseñas"
    Write-Before ("*****")
    Get-ADDefaultDomainPasswordPolicy
    Write-After ("*****")
}



#Configuración del Servidor
GetZonaHoraria
GetFechaHora
GetActualizaciones
GetDireccionIP
GetTarjetasRed
GetNombreEquipo
GetUsuarios


#Sistema Operativo
GetSistemaOperativo
GetVersionSistemaOperativo
GetUltimoArranque
GetSistemaArchivos
GetProgramasInstalados
#getCertificadoDRASystemEFS
#servicios
GetLogSistema
GetLogError
GetUnidadesDisco
GetRecursosCompartidos
GetSMB1
GetUSBConectados


#Active Directory
GetDominio
GetADDController
GetCategoriasAuditoria
GetSubcategoriasAuditoria
GetPoliticaContras










