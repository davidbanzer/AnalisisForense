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


# Rutas Carpetas

$ServidorLocalPath = "./Reportes Auditoria/1) Servidor Local"
$SistemaOperativoPath = "./Reportes Auditoria/2) Sistema Operativo"
$ActiveDirectoryPath = "./Reportes Auditoria/3) Active Directory"
$Raiz = "./Reportes Auditoria"

if (-not (test-Path -Path $ServidorLocalPath)) {
    New-Item -Path $ServidorLocalPath -ItemType Directory
}
if (-not (test-Path -Path $SistemaOperativoPath)) {
    New-Item -Path $SistemaOperativoPath -ItemType Directory
}
if (-not (test-Path -Path $ActiveDirectoryPath)) {
    New-Item -Path $ActiveDirectoryPath -ItemType Directory
}


$FileNameFecha = "Fecha, Hora y Zona Horaria.txt"
function GetZonaHoraria {
    
    # Ver zona horaria

    Write-Info "1. Zona Horaria"
    Write-Output '1. Zona Horaria' | Out-File -FilePath $ServidorLocalPath/$FileNameFecha
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameFecha
    Get-TimeZone | Out-File -Append $ServidorLocalPath/$FileNameFecha
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameFecha
    Write-After ("TXT " + $FileNameFecha + " Generado.")
}

function GetFechaHora {
    
    # Ver Fecha y Hora
    
    Write-Info "2. Fecha y Hora"
    Write-Output '2. Fecha y Hora' | Out-File -Append $ServidorLocalPath/$FileNameFecha
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameFecha
    $datetimeToString = (Get-Date -format "yyyy-MM-dd ss:mm:HH").ToString()
    $datetimeToString | Out-File -Append $ServidorLocalPath/$FileNameFecha
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameFecha

    Write-After ("TXT de " + $FileNameFecha + " Actualizado.")
}


$FileNameActualizaciones = "Actualizaciones.txt"
function GetActualizaciones {
    
    # Ver actualizaciones
    
    Write-Info "3. Actualizaciones"
    Write-Output '3. Actualizaciones' | Out-File -FilePath $ServidorLocalPath/$FileNameActualizaciones
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameActualizaciones
    wmic qfe list | Out-File -Append $ServidorLocalPath/$FileNameActualizaciones
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameActualizaciones
    Write-After ("TXT de " + $FileNameActualizaciones + " Generado.")
}


$FileNameRed = "Red.txt"
function GetDireccionIP {
    
    # Ver direccion
    Write-Info "4. Direcciones IP"
    Write-Output '4. Direcciones IP' | Out-File -FilePath $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Get-NetIPAddress | Format-Table | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-After ("TXT de " + $FileNameRed + " Generado.")
}

function GetTarjetasRed {
    
    # Ver adaptadores
    Write-Info "5. Tarjetas de Red"
    Write-Output '5. Tarjetas de Red' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Get-NetAdapter | Format-Table | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-After ("TXT de " + $FileNameRed + " Actualizado.")

}

function GetIPv6 {
    
    # Verificar si está habilitado IPv6
    Write-Info "6. Verificar IPv6"
    Write-Output '6. Verificar IPv6' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    [System.Net.Sockets.Socket]::OSSupportsIPv6 | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-After ("TXT de " + $FileNameRed + " Actualizado.")
}

function GetSNMP {
    
    # Ver protocolo SNMP
    Write-Info "24. Protocolo SNMP"
    Write-Output '24. Protocolo SNMP' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Get-WindowsCapability -Online -Name “SNMP*” | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-After ("TXT de " + $FileNameRed + " Actualizado.")
}

$FileNameEquipo = "Informacion Equipo.txt"
function GetNombreEquipo {
    
    # Ver nombre equipo
    Write-Info "7. Nombre del Equipo"
    Write-Output '7. Nombre del Equipo' | Out-File -FilePath $ServidorLocalPath/$FileNameEquipo
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    hostname | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Write-After ("TXT de " + $FileNameEquipo + " Actualizado.")

}

function GetUsuarios {
    
    # Ver usuarios
    Write-Info "8. Usuarios"
    Write-Output '8. Usuarios' | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Get-LocalUser | Format-Table | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Write-After ("TXT de " + $FileNameEquipo + " Actualizado.")

}
$FileNameSO = "Sistema Operativo.txt"
function GetSistemaOperativo {
    
    # Ver sistema operativo
    Write-Info "9. Nombre del Sistema Operativo"
    Write-Output '9. Nombre del Sistema Operativo' | Out-File -FilePath $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    (Get-CimInstance -ClassName CIM_OperatingSystem).Caption | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-After ("TXT de " + $FileNameSA + " Generado.")
}

function GetVersionSistemaOperativo {
    # Ver version sistema operativo
    Write-Info "10. Version Sistema Operativo"
    Write-Output '10. Version Sistema Operativo' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    (Get-CimInstance -ClassName CIM_OperatingSystem).Version | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-After ("TXT de " + $FileNameSA + " Actualizado.")
}

function GetUltimoArranque {
    # Ver ultimo arranque
    Write-Info "11. Ultimo Arranque"
    Write-Output '11. Ultimo Arranque' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    (Get-CimInstance -ClassName CIM_OperatingSystem).LastBootUpTime | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-After ("TXT de " + $FileNameSA + " Actualizado.")
}
$FileNameSA = "Sistema de Archivos.txt"
function GetSistemaArchivos {
    # [ ] No lo genera  
    # Ver sistema de archivos

    Write-Info "12. Sistema de Archivos"
    Write-Output '12. Sistema de Archivo' | Out-File -FilePath $SistemaOperativoPath/$FileNameSA
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSA
    Get-Volume | Format-Table | Out-File -Append $SistemaOperativoPath/$FileNameSA
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSA
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
    # [ ] No lo genera
    Write-Info "13. Verificar el sistema de cifrado de archivos y carpetas (EFS)."
    Write-Output '13. Verificar el sistema de cifrado de archivos y carpetas (EFS).' | Out-File -FilePath $SistemaOperativoPath/$FileNameSA
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSA

    if (-not (test-Path -Path "./certificados_EFS/*")) {
        configuracinEFS
    }

    Set-Location ./verificar_certificado_DRA_del_sistema_EFS

    cipher * | Out-File -Append $SistemaOperativoPath/$FileNameSA
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSA
    Write-After ("TXT de " + $FileNameSA + " Actualizado.")

    Set-Location ..
}

$FileNameProgramas = "Programas.txt"
function GetProgramasInstalados {
    
    # Ver programas instalados

    Write-Info "14. Programas Instalados"
    Write-Output '14. Programas Instalados' | Out-File -FilePath $SistemaOperativoPath/$FileNameProgramas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Get-WmiObject -Class Win32_Product | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Write-After ("TXT de " + $FileNameProgramas + " Actualizado.")
}

function GetProgramasInicio {
    
    # Ver programas que se ejecutan al iniciar Windows

    Write-Info ". Programas que se Ejecutan al Iniciar Windows"
    Write-Output '. Programas que se Ejecutan al Iniciar Windows' | Out-File -FilePath $SistemaOperativoPath/$FileNameProgramas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    wmic startup | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Write-After ("TXT de " + $FileNameProgramas + " Actualizado.")
}


$FileNameServicios = "Servicios.txt"
function GetServicios {
    
    # Ver servicios
    Write-Info "15. Servicios"
    Write-Output '15 Servicios' | Out-File -FilePath $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-After ("TXT de " + $FileNameServicios + " Actualizado.")
}

function GetServiciosCorriendo {
    
    # Ver servicios corriendo
    Write-Info "16. Servicios Corriendo del Sistema"
    Write-Output '16 Servicios Corriendo del Sistema' | Out-File -FilePath $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Get-Service | Where-Object { $_.Status -eq "Running" }  | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-After ("TXT de " + $FileNameServicios + " Actualizado.")
}

function GetServiciosDetenidos {
    
    # Ver servicios detenidos
    Write-Info "17. Servicios Detenidos del Sistema"
    Write-Output '17 Servicios Detenidos del Sistema' | Out-File -FilePath $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Get-Service | Where-Object { $_.Status -eq "Stopped" }  | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-After ("TXT de " + $FileNameServicios + " Actualizado.")
}


$FileNameLog = "Logs.txt"
function GetLogsAdvertencias {
    
    # Ver logs de advertencia
    Write-Info "18. Logs de Warning"
    Write-Output '18. Logs de Warning' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-EventLog -LogName System -EntryType Warning | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("TXT de " + $FileNameLog + " Actualizado.")
}

function GetLogsErrores {
    
    # Ver los logs de errores
    Write-Info "19. Logs de Error"
    Write-Output '19. Logs de Error' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-EventLog -LogName System -EntryType Error | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("TXT de " + $FileNameLog + " Actualizado.")
}

function GetLogsActualizaciones {
    
    # Ver logs de Windows Update
    Write-Info ". Logs de Actualizaciones"
    Write-Output '. Logs de Actualizaciones' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-WinEvent -ProviderName  Microsoft-Windows-WindowsUpdateClient | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("TXT de " + $FileNameLog + " Actualizado.")
}

function GetLogsAplicaciones {
    
    # Ver logs de aplicaciones
    Write-Info ". Logs de Aplicaciones"
    Write-Output '. Logs de Aplicaciones' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-Eventlog -Logname application | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("TXT de " + $FileNameLog + " Actualizado.")
}

function GetLogsSeguridad {
    
    # Ver logs de seguridad
    Write-Info ". Logs de Seguridad"
    Write-Output '. Logs de Seguridad' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-Eventlog security | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("TXT de " + $FileNameLog + " Actualizado.")
}

function GetLogsProgramasDesinstalados {
    
    # Ver logs de programas desinstalados

    Write-Info ". Logs de Programas Desinstalados"
    Write-Output '. Logs de Programas Desinstalados' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-EventLog -LogName Application -Source MSIInstaller | Where-Object { $_.EventID -eq '1034' } | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("TXT de " + $FileNameLog + " Actualizado.")

    
}

$FileNameUnidadesDisco = "Unidades de Disco.txt"
function GetUnidadesDisco {
    
    # Ver las unidades de disco

    Write-Info "20. Unidades de Disco"
    Write-Output '20. Unidades de Disco' | Out-File -FilePath $SistemaOperativoPath/$FileNameUnidadesDisco
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameUnidadesDisco
    Get-PSDrive -PSProvider FileSystem | Out-File -Append $SistemaOperativoPath/$FileNameUnidadesDisco
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameUnidadesDisco
    Write-After ("TXT de " + $FileNameUnidadesDisco + " Actualizado.")
}


$FileNameRecursosCompartidos = "Recursos Compartidos.txt"
function GetRecursosCompartidos {
    
    # Ver los recursos compartidos
    Write-Info "21. Recursos Compartidos"
    Write-Output '21. Recursos Compartidos' | Out-File -FilePath $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Get-SmbShare | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-After ("TXT de " + $FileNameRecursosCompartidos + " Generado.")
}

function GetSMB1 {
    
    # Comprobar si SMB1 está activo
    Write-Info "22. SMB1"
    Write-Output '22. SMB1' | Out-File -FilePath $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-After ("TXT de " + $FileNameRecursosCompartidos + " Actualizado.")
}

$FileNameUSB = "USB Conectados.txt"
function GetUSBConectados {
    
    # Comprobar los USB conectados
    Write-Info "23. USB Conectados"
    Write-Output '23. USB Conectados' | Out-File -FilePath $SistemaOperativoPath/$FileNameUSB
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameUSB
    Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | Out-File -Append $SistemaOperativoPath/$FileNameUSB
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameUSB
    Write-After ("TXT de " + $FileNameUSB + " Actualizado.")
}

$FileNameCDROM = "Unidad CD-DVD.txt"
function GetCDROM {
    
    # Comprobar unidad CD/DVD
    Write-Info "25. Comprobar Unidad CD/DVD"
    Write-Output '25. Comprobar Unidad CD/DVD' | Out-File -FilePath $SistemaOperativoPath/$FileNameCDROM
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameCDROM
    (Get-WMIObject -Class Win32_CDROMDrive -Property *).MediaLoaded | Out-File -Append $SistemaOperativoPath/$FileNameCDROM
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameCDROM
    Write-After ("TXT de " + $FileNameCDROM + " Actualizado.")
}

$FileNameProcesos = "Procesos.txt"
function GetProcesos {
    
    # Lista de procesos
    Write-Info "26. Lista de Procesos"
    Write-Output '26. Lista de Procesos' | Out-File -FilePath $SistemaOperativoPath/$FileNameProcesos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Get-Process  | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Write-After ("TXT de " + $FileNameProcesos + " Actualizado.")
}   

function Get5Procesos {
    
    # Lista de 5 procesos que ocupan más memoria
    Write-Info "27. 5 Procesos que Ocupan mas Memoria"
    Write-Output '27. 5 Procesos que Ocupan mas Memoria' | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    ps | sort -p ws | select -last 5  | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Write-After ("TXT de " + $FileNameProcesos + " Actualizado.")
}

$FileNameTareas = "Tareas Programadas.txt"
function GetTareasProgramadas {
    
    # Ver tareas programadas
    Write-Info "28. Tareas Programadas"
    Write-Output '28. Tareas Programadas' | Out-File -FilePath $SistemaOperativoPath/$FileNameTareas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameTareas
    Get-ScheduledTask  | Out-File -Append $SistemaOperativoPath/$FileNameTareas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameTareas
    Write-After ("TXT de " + $FileNameTareas + " Actualizado.")
}

$FileNamePuertos = "Puertos.txt"

function GetPuertos {
    
    # Ver puertos del sistema
    Write-Info ". Puertos del Sistema"
    Write-Output '. Puertos del Sistema' | Out-File -FilePath $SistemaOperativoPath/$FileNamePuertos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNamePuertos
    Get-NetTCPConnection -State Listen  | Out-File -Append $SistemaOperativoPath/$FileNamePuertos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNamePuertos
    Write-After ("TXT de " + $FileNamePuertos + " Actualizado.")

}

$FileNameDominioAD = "Informacion Dominio y AD.txt"
function GetDominio {
     
    # Ver dominio
    Write-Info "29. Dominio"
    Write-Output '29. Dominio' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Get-WMIObject Win32_ComputerSystem | Select-Object -ExpandProperty Domain | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-After ("TXT de " + $FileNameDominioAD + " Actualizado.")
}


function GetADDController {
     
    # Ver Controlador de dominio AD
    Write-Info "30. Controlador de Dominio AD"
    Write-Output '30. Controlador de Dominio AD' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Get-AdDomainController | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-After ("TXT de " + $FileNameDominioAD + " Actualizado.")
}

$FileNameAuditoriaAudipol = "Audipol.txt"
function GetCategoriasAuditoria {
     
    # Ver categorias de auditoria
    Write-Info "31. Categorias de Auditoria"
    Write-Output '31. Categorias de Auditoria' | Out-File -FilePath $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    auditpol /get /category:* | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-After ("TXT de " + $FileNameAuditoriaAudipol + " Generado.")
}

function GetSubcategoriasAuditoria {
     
    # Ver subcategorias de auditoria
    Write-Info "32. Subcategorias de Auditoria"
    Write-Output '32. Subcategorias de Auditoria' | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    auditpol /list /subcategory:* | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-After ("TXT de " + $FileNameAuditoriaAudipol + " Actualizado.")
}

$FileNamePoliticaContra = "Politica de Contras.txt"
function GetPoliticaContras {
     
    # Ver la política de contraseñas
    Write-Info "33. Politica de Contras"
    Write-Output '33. Politica de Contras' | Out-File -Append $ActiveDirectoryPath/$FileNamePoliticaContra
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNamePoliticaContra
    Get-ADDefaultDomainPasswordPolicy | Out-File -Append $ActiveDirectoryPath/$FileNamePoliticaContra
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNamePoliticaContra
    Write-After ("TXT de " + $FileNamePoliticaContra + " Actualizado.")
}

$FileNameUsuariosAD = "Usuarios.txt"
function GetUsuariosAD {
     
    # Ver la lista de usuarios de AD
    Write-Info "34. Usuarios de AD"
    Write-Output '34. Usuarios de AD' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Get-ADUser -Filter * -Properties whencreated | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-After ("TXT de " + $FileNameUsuariosAD + " Actualizado.")

}

function GetUsuariosHabilitados {
     
    # Ver la lista de usuarios de AD habilitados
    Write-Info "35. Usuarios de AD Habilitados"
    Write-Output '35. Usuarios de AD Habilitados' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Get-ADUser -Filter * | Ft Name, Enabled | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-After ("TXT de " + $FileNameUsuariosAD + " Actualizado.")
}

function GetUsuariosDeshabilitados {
     
    # Ver la lista de usuarios de AD deshabilitados
    Write-Info "36. Usuarios de AD Deshabilitados"
    Write-Output '36. Usuarios de AD Deshabilitados' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Search-ADAccount -AccountDisabled | select name | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-After ("TXT de " + $FileNameUsuariosAD + " Actualizado.")
}

function GetUsuariosContras {
     
    # Ver la lista de usuarios de AD cuya contraseña no expira

    Write-Info "37. Usuarios de AD Cuya Contra no Expira"
    Write-Output '37. Usuarios de AD Cuya Contra no Expira' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Get-ADUser -Filter * -Properties Name, PasswordNeverExpires | where { $_.passwordNeverExpires -eq "true" } | Select-Object DistinguishedName, Name, Enabled | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-After ("TXT de " + $FileNameUsuariosAD + " Actualizado.")
}

function GetUltimaConexionUsuario($User) {
     
    # última conexión de un usuario en específico
    Write-Info "38. Ultima conexion del Usuario de AD"
    Write-Output '38. Ultima conexion del Usuario de AD' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Get-ADUser -Identity $User -Properties "LastLogonDate" | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-After ("TXT de " + $FileNameUsuariosAD + " Actualizado.")
}

$FileNameEquiposAD = "Equipos Conectados al Dominio.txt"
function GetEquiposConectadosDominio {
     
    # Ver equipos conectados al dominio
    Write-Info "39. Equipos Conectados al Dominio"
    Write-Output "39. Equipos Conectados al Dominio" | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Get-ADComputer -Filter * | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-After ("TXT de " + $FileNameEquiposAD + " Actualizado.")
}

function GetContadorEquiposDominio {
     
    # Ver cantidad de equipos conectados al dominio
    Write-Info "40. Cantidad de Equipos Conectados"
    Write-Output "40. Cantidad de Equipos Conectados" | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Get-ADComputer -Filter * | measure | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-After ("TXT de " + $FileNameEquiposAD + " Actualizado.")
}

function GetSOEquiposConectadosDominio {
     
    # Ver sistemas operativos de equipos conectados al dominio

    Write-Info "41. Sistemas Operativos de los Equipos Conectados"
    Write-Output "41. Sistemas Operativos de los Equipos Conectados" | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Get-ADComputer -Filter "name -like '*'" -Properties operatingSystem | group -Property operatingSystem | Select Name, Count | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-After ("TXT de " + $FileNameEquiposAD + " Actualizado.")
}

function getPermisosUsuarioAd {
    #[ ] falta ver que que numero es 
    Write-Info "41. Permisos de usuario de Active Directory"
    Write-Output "41. Permisos de usuario de Active Directory" | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Get-ADUser -Filter * | % { (Get-ACL "AD:$($_.distinguishedname)").access } | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-After ("TXT de " + $FileNameEquiposAD + " Actualizado.")
}

$DominioDNSAD = "auditoria.com"
function getGpo {
    #[ ] falta ver que que numero es 
    Write-Info "41. Traer las GPO de Active Directory"
    Write-Output "41. Traer las GPO de Active Directory" | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Get-GPO -All -Domain $DominioDNSAD | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-After ("TXT de " + $FileNameEquiposAD + " Actualizado.")
    
}

function ReporteBateria {
    Write-Info "Reporte de Bateria"
    powercfg /energy /output "./Reportes Auditoria/1) Servidor Local/Reporte Bateria.html" /duration 10     
}

function getComputerStatus {
    #[ ] falta ver que que numero es 
    Write-Info "41. Traer las GPO de Active Directory"
    Write-Output "41. Traer las GPO de Active Directory" | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Get-MpComputerStatus | <# [ ] cambiar ruta a SO #> Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-After ("TXT de " + $FileNameEquiposAD + " Actualizado.")
}

#Configuración del Servidor
GetZonaHoraria
GetFechaHora
GetActualizaciones
GetDireccionIP
GetTarjetasRed
GetIPv6
GetSNMP
GetNombreEquipo
GetUsuarios


#Sistema Operativo
GetSistemaOperativo
GetVersionSistemaOperativo
GetUltimoArranque
GetSistemaArchivos
GetProgramasInstalados
GetProgramasInicio
#getCertificadoDRASystemEFS
GetServicios
GetServiciosCorriendo
GetServiciosDetenidos
GetLogsAdvertencias
GetLogsErrores
GetLogsActualizaciones 
GetLogsAplicaciones 
GetLogsSeguridad
GetLogsProgramasDesinstalados 
GetUnidadesDisco
GetRecursosCompartidos
GetSMB1
GetUSBConectados
GetCDROM
GetProcesos
Get5Procesos
GetTareasProgramadas
GetPuertos
getComputerStatus

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
#Especificar usuario como parámetro
GetUltimaConexionUsuario Administrador
GetEquiposConectadosDominio
GetContadorEquiposDominio
GetSOEquiposConectadosDominio
getPermisosUsuarioAd
getGpo


ReporteBateria