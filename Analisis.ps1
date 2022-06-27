
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
    Write-After ("TXT de " + $FileNameActualizacion + " Generado.")
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
    Write-After ("TXT de " + $FileNameRedesUsuarios + " Generado.")
}

function GetTarjetasRed {
    # [X] exportado a TXT
    # Ver adaptadores
    Write-Info "Tarjetas de Red"
    Write-Output 'Tarjetas de Red' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Get-NetAdapter | Format-Table | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '-------------------------------------------------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-After ("TXT de " + $FileNameRedesUsuarios + " Actualizado.")

}

function GetNombreEquipo {
    # [X] exportado a TXT
    # Ver nombre equipo
    Write-Info "Nombre del Equipo"
    Write-Output 'Nombre del Equipo' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    hostname | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '-------------------------------------------------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-After ("TXT de " + $FileNameRedesUsuarios + " Actualizado.")

}

function GetUsuarios {
    # [X] exportado a TXT
    # Ver usuarios
    Write-Info "Usuarios"
    Write-Output 'Usuarios' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Get-LocalUser | Format-Table | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '-------------------------------------------------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-After ("TXT de " + $FileNameRedesUsuarios + " Actualizado.")

}

function GetDominio {
    # [X] exportado a TXT # [ ] No lo genera
    # Ver dominio
    Write-Info "Dominio"
    Write-Output 'Dominio' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Get-WMIObject Win32_ComputerSystem | Select-Object -ExpandProperty Domain | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-Output '-------------------------------------------------------' | Out-File -Append $RedesUsuariosPath/$FileNameRedesUsuarios
    Write-After ("TXT de " + $FileNameRedesUsuarios + " Actualizado.")
}

$AuditoriaAudipolPath = "./Reportes Auditoria/Auditoria con Audipol"
$FileNameAuditoriaAudipol = "Auditoria con Audipol.txt"
function GetCategoriasAuditoria {
    # [X] exportado a TXT # [ ] No lo genera 
    if (-not (test-Path -Path $AuditoriaAudipolPath)) {
        New-Item -Path $AuditoriaAudipolPath -ItemType Directory
    }
    # Ver categorias de auditoria
    Write-Info "Categorias de Auditoria"
    Write-Output 'Categorias de Auditoria' | Out-File -FilePath $AuditoriaAudipolPath/$FileNameAuditoriaAudipol
    Write-Output '------------' | Out-File -Append $AuditoriaAudipolPath/$FileNameAuditoriaAudipol
    auditpol /get /category:* | Out-File -Append $AuditoriaAudipolPath/$FileNameAuditoriaAudipol
    Write-Output '-------------------------------------------------------' | Out-File -Append $AuditoriaAudipolPath/$FileNameAuditoriaAudipol
    Write-After ("TXT de " + $FileNameAuditoriaAudipol + " Generado.")
}

function GetSubcategoriasAuditoria {
    # [X] exportado a TXT # [ ] No lo genera 
    # Ver subcategorias de auditoria
    Write-Info "Subcategorias de Auditoria"
    Write-Output 'Subcategorias de Auditoria' | Out-File -Append $AuditoriaAudipolPath/$FileNameAuditoriaAudipol
    Write-Output '------------' | Out-File -Append $AuditoriaAudipolPath/$FileNameAuditoriaAudipol
    auditpol /list /subcategory:* | Out-File -Append $AuditoriaAudipolPath/$FileNameAuditoriaAudipol
    Write-Output '-------------------------------------------------------' | Out-File -Append $AuditoriaAudipolPath/$FileNameAuditoriaAudipol
    Write-After ("TXT de " + $FileNameAuditoriaAudipol + " Actualizado.")
}

$AuditoriaSistemaArchivosPath = "./Reportes Auditoria/Auditoria Sistema de Archivos"
$FileNameSA = "Auditoria Sistema de Archivos.txt"
function GetSistemaArchivos {
    # [X] exportado a TXT # [ ] No lo genera  
    # Ver sistema de archivos
    if (-not (test-Path -Path $AuditoriaSistemaArchivosPath)) {
        New-Item -Path $AuditoriaSistemaArchivosPath -ItemType Directory
    }
    Write-Info "Sistema de Archivos"
    Write-Output 'Sistema de Archivo' | Out-File -FilePath $AuditoriaSistemaArchivosPath/$FileNameSA
    Write-Output '------------' | Out-File -Append $AuditoriaSistemaArchivosPath/$FileNameSA
    Get-Volume | Format-Table | Out-File -Append $AuditoriaSistemaArchivosPath/$FileNameSA
    Write-Output '-------------------------------------------------------' | Out-File -Append $AuditoriaSistemaArchivosPath/$FileNameSA
    Write-After ("TXT de " + $FileNameSA + " Generado.")
}


function configuracinEFS {
    # TODO Falta corregir 1.- activacion de encryptacion 2.- asignacion de certificado DRA 
    Set-Location ./certificados_EFS
    cipher /r:EFSRA #Input usado para crear Pass PFX es auditoria
    
    Set-Location ../verificar_certificado_DRA_del_sistema_EFS
    fsutil behavior set disableencryption 0
    
}

function getCertificadoDRASystemEFS {
    # [X] exportado a TXT # [ ] No lo genera
    Write-Info "Verificar el sistema de cifrado de archivos y carpetas (EFS)."
    Write-Output 'Verificar el sistema de cifrado de archivos y carpetas (EFS).' | Out-File -FilePath $AuditoriaSistemaArchivosPath/$FileNameSA
    Write-Output '------------' | Out-File -Append $AuditoriaSistemaArchivosPath/$FileNameSA

    if (-not (test-Path -Path "./certificados_EFS/*")) {
        configuracinEFS
    }

    Set-Location ./verificar_certificado_DRA_del_sistema_EFS

    cipher * | Out-File -Append $AuditoriaSistemaArchivosPath/$FileNameSA
    Write-After ("TXT de " + $FileNameSA + " Actualizado.")

    Set-Location ..
}

function GetProgramasInstalados {
    # [X] exportado a TXT
    # Ver programas instalados
    Write-Info "Programas Instalados"
    Write-Output 'Programas Instalados' | Out-File -Append $AuditoriaSistemaArchivosPath/$FileNameSA
    Write-Output '------------' | Out-File -Append $AuditoriaSistemaArchivosPath/$FileNameSA
    Get-WmiObject -Class Win32_Product | Out-File -Append $AuditoriaSistemaArchivosPath/$FileNameSA
    Write-After ("TXT de " + $FileNameSA + " Actualizado.")
}

$AuditoriaSO = "./Reportes Auditoria/Auditoria Sistema Operativo"
$FileNameSO = "Auditoria Sistema Operativo.txt"
function GetSistemaOperativo {
    # [X] exportado a TXT
    if (-not (test-Path -Path $AuditoriaSO )) {
        New-Item -Path $AuditoriaSO  -ItemType Directory
    }
    # Ver sistema operativo
    Write-Info "Nombre del Sistema Operativo"
    Write-Output 'Nombre del Sistema Operativo' | Out-File -FilePath $AuditoriaSO/$FileNameSO
    Write-Output '------------' | Out-File -Append $AuditoriaSO/$FileNameSO
    (Get-CimInstance -ClassName CIM_OperatingSystem).Caption | Out-File -Append $AuditoriaSO/$FileNameSO
    Write-After ("TXT de " + $FileNameSA + " Generado.")
}

function GetVersionSistemaOperativo {
    # Ver version sistema operativo
    Write-Info "Version Sistema Operativo"
    Write-Output 'Version Sistema Operativo' | Out-File -Append $AuditoriaSO/$FileNameSO
    Write-Output '------------' | Out-File -Append $AuditoriaSO/$FileNameSO
    (Get-CimInstance -ClassName CIM_OperatingSystem).Version | Out-File -Append $AuditoriaSO/$FileNameSO
    Write-After ("TXT de " + $FileNameSA + " Actualizado.")
}

function GetUltimoArranque {
    # Ver ultimo arranque
    Write-Info "Ultimo Arranque"
    Write-Output 'Ultimo Arranque' | Out-File -Append $AuditoriaSO/$FileNameSO
    Write-Output '------------' | Out-File -Append $AuditoriaSO/$FileNameSO
    (Get-CimInstance -ClassName CIM_OperatingSystem).LastBootUpTime | Out-File -Append $AuditoriaSO/$FileNameSO
    Write-After ("TXT de " + $FileNameSA + " Actualizado.")
}

function GetLogSistema {
    # Ver los últimos 20 logs del sistema
    Write-Info "Ultimos 20 Logs del Sistema"
    Write-Output 'Ultimos 20 Logs del Sistema' | Out-File -Append $AuditoriaSO/$FileNameSO
    Write-Output '------------' | Out-File -Append $AuditoriaSO/$FileNameSO
    Get-EventLog -LogName System -Newest 20 | Out-File -Append $AuditoriaSO/$FileNameSO
    Write-After ("TXT de " + $FileNameSA + " Actualizado.")
}

function GetLogError {
    # Ver los últimos 20 logs de error
    Write-Info "Ultimos 20 Logs de Error."
    Write-Output 'Ultimos 20 Logs de Error' | Out-File -Append $AuditoriaSO/$FileNameSO
    Write-Output '------------' | Out-File -Append $AuditoriaSO/$FileNameSO
    Get-EventLog -LogName System -EntryType Error -Newest 20 | Out-File -Append $AuditoriaSO/$FileNameSO
    Write-After ("TXT de " + $FileNameSA + " Actualizado.")
}

$RCPPath = "./Reportes Auditoria/Auditoria recursos Compartidos & Protocolos"
$FileNameRCP = "Auditoria recursos Compartidos & Protocolos.txt"
function GetRecursosCompartidos {
    # [X] exportado a TXT
    if (-not (test-Path -Path $RCPPath )) {
        New-Item -Path $RCPPath  -ItemType Directory
    }
    # Ver los recursos compartidos
    Write-Info "Recursos Compartidos"
    Write-Output 'Recursos Compartidos' | Out-File -FilePath $RCPPath/$FileNameRCP
    Write-Output '------------' | Out-File -Append $RCPPath/$FileNameRCP
    Get-SmbShare | Out-File -Append $RCPPath/$FileNameRCP
    Write-After ("TXT de " + $FileNameRCP + " Generado.")
}

function GetSMB1 {
    # [X] exportado a TXT
    # Comprobar si SMB1 está activo
    Write-Info "SMB1"
    Write-Output 'SMB1' | Out-File -FilePath $RCPPath/$FileNameRCP
    Write-Output '------------' | Out-File -Append $RCPPath/$FileNameRCP
    Get-WindowsOptionalFeature –Online –FeatureName SMB1Protocol
    Write-After ("TXT de " + $FileNameRCP + " Actualizado.")
}

function GetUnidadesDisco {
    # Ver las unidades de disco
    Write-Info "Unidades de Disco"
    Write-Before ("*****")
    Get-PSDrive -PSProvider FileSystem
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

function GetServicios {
    Write-Info "Servicios del Sistema"
    Write-Before ("*****")
    Get-Service
    Write-After ("*****")
}

function GetServiciosCorriendo {
    Write-Info "Servicios Corriendo del Sistema"
    Write-Before ("*****")
    Get-Service | Where-Object { $_.Status -eq "Running" } 
    Write-After ("*****")
}

function GetServiciosDetenidos {
    Write-Info "Servicios Detenidos del Sistema"
    Write-Before ("*****")
    Get-Service | Where-Object { $_.Status -eq "Stopped" } 
    Write-After ("*****")
}

function GetSNMP {
    Write-Info "Estado del servicio SNMP"
    Write-Before ("*****")
    Get-WindowsCapability -Online -Name “SNMP*”
    Write-After ("*****")
}

function GetCDROM {
    Write-Info "Comprobar unidad CD/DVD"
    Write-Before ("*****")
    (Get-WMIObject -Class Win32_CDROMDrive -Property *).MediaLoaded
    Write-After ("*****")
}

function GetProcesos {
    Write-Info "Procesos"
    Write-Before ("*****")
    Get-Process
    Write-After ("*****")
}

function Get5Procesos {
    Write-Info "5 Procesos que utilizan más memoria"
    Write-Before ("*****")
    ps | sort –p ws | select –last 5
    Write-After ("*****")
}

function GetUsuariosAD {
    Write-Info "Usuarios creados dentro de Active Directory"
    Write-Before ("*****")
    Get-ADUser -Filter * -Properties whencreated
    Write-After ("*****")
}

function GetUsuariosHabilitados {
    Write-Info "Usuarios de Active Directory que se encuentran habilitados"
    Write-Before ("*****")
    Get-ADUser -Filter * | Ft Name, Enabled
    Write-After ("*****")
}

function GetUsuariosDeshabilitados {
    Write-Info "Usuarios de Active Directory que se encuentran deshabilitados"
    Write-Before ("*****")
    Search-ADAccount -AccountDisabled | select name
    Write-After ("*****")
}

function GetUsuariosContras {
    Write-Info "Usuarios de Active Directory cuya contraseña no expira nunca"
    Write-Before ("*****")
    Get-ADUser -Filter * -Properties Name, PasswordNeverExpires | where { $_.passwordNeverExpires -eq "true" } | Select-Object DistinguishedName, Name, Enabled
    Write-After ("*****")
}

function GetUltimaConexionUsuario {
    Write-Info "Última conexión al servidor de un usuario específico"
    Write-Before ("*****")
    Get-ADUser -Identity “nombredeusuario” -Properties “LastLogonDate”
    Write-After ("*****")
}

function GetEquiposConectadosDominio {
    Write-Info "Equipos conectados al dominio"
    Write-Before ("*****")
    Get-ADComputer -Filter *
    Write-After ("*****")
}

function GetContadorEquiposDominio {
    Write-Info "Contador de equipos conectados al dominio"
    Write-Before ("*****")
    Get-ADComputer -Filter * | measure
    Write-After ("*****")
}

function GetSOEquiposConectadosDominio {
    Write-Info "Sistemas Operativos de los equipos conectados al dominio"
    Write-Before ("*****")
    Get-ADComputer -Filter "name -like '*'" -Properties operatingSystem | group -Property operatingSystem | Select Name, Count
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
GetServicios
GetServiciosCorriendo
GetServiciosDetenidos
GetLogSistema
GetLogError
GetUnidadesDisco
GetRecursosCompartidos
GetSMB1
GetUSBConectados
GetSNMP
GetCDROM
GetProcesos
Get5Procesos

#Active Directory
GetDominio
GetADDController
GetCategoriasAuditoria
GetSubcategoriasAuditoria
GetPoliticaContras
GetUsuariosAD
GetUsuariosHabilitados
GetUsuariosDeshabilitados
GetUsuariosContras
GetUltimaConexionUsuario
GetEquiposConectadosDominio
GetContadorEquiposDominio
GetSOEquiposConectadosDominio