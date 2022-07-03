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
    Write-After ("Exportado a " + $FileNameFecha )
}

function GetFechaHora {
    
    # Ver Fecha y Hora
    
    Write-Info "2. Fecha y Hora"
    Write-Output '2. Fecha y Hora' | Out-File -Append $ServidorLocalPath/$FileNameFecha
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameFecha
    $datetimeToString = (Get-Date -format "yyyy-MM-dd ss:mm:HH").ToString()
    $datetimeToString | Out-File -Append $ServidorLocalPath/$FileNameFecha
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameFecha

    Write-After ("Exportado a " + $FileNameFecha )
}


$FileNameActualizaciones = "Actualizaciones.txt"
function GetActualizaciones {
    
    # Ver actualizaciones
    
    Write-Info "3. Actualizaciones"
    Write-Output '3. Actualizaciones' | Out-File -FilePath $ServidorLocalPath/$FileNameActualizaciones
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameActualizaciones
    wmic qfe list | Out-File -Append $ServidorLocalPath/$FileNameActualizaciones
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameActualizaciones
    Write-After ("Exportado a " + $FileNameActualizaciones )
}


$FileNameRed = "Red.txt"
function GetDireccionIP {
    
    # Ver direccion
    Write-Info "4. Direcciones IP"
    Write-Output '4. Direcciones IP' | Out-File -FilePath $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Get-NetIPAddress | Format-Table | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-After ("Exportado a " + $FileNameRed )
}

function GetTarjetasRed {
    
    # Ver adaptadores
    Write-Info "5. Tarjetas de Red"
    Write-Output '5. Tarjetas de Red' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Get-NetAdapter | Format-Table | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-After ("Exportado a " + $FileNameRed )

}

function GetIPv6 {
    
    # Verificar si está habilitado IPv6
    Write-Info "6. Verificar IPv6"
    Write-Output '6. Verificar IPv6' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    [System.Net.Sockets.Socket]::OSSupportsIPv6 | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameRed
    Write-After ("Exportado a " + $FileNameRed )
}

$FileNameEquipo = "Informacion Equipo.txt"
function GetNombreEquipo {
    
    # Ver nombre equipo
    Write-Info "7. Nombre del Equipo"
    Write-Output '7. Nombre del Equipo' | Out-File -FilePath $ServidorLocalPath/$FileNameEquipo
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    hostname | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Write-After ("Exportado a " + $FileNameEquipo )

}

function GetUsuarios {
    
    # Ver usuarios
    Write-Info "8. Usuarios"
    Write-Output '8. Usuarios' | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Get-LocalUser | Format-Table | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Write-Output '-------------------------------------------------------' | Out-File -Append $ServidorLocalPath/$FileNameEquipo
    Write-After ("Exportado a " + $FileNameEquipo )

}

function ReporteEnergetico {
    Write-Info "9. Reporte de Energetico"
    powercfg /energy /output "./Reportes Auditoria/1) Servidor Local/Reporte Energetico.html" /duration 10     
}

$FileNameSO = "Sistema Operativo.txt"
function GetSistemaOperativo {
    
    # Ver sistema operativo
    Write-Info "10. Nombre del Sistema Operativo"
    Write-Output '10. Nombre del Sistema Operativo' | Out-File -FilePath $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    (Get-CimInstance -ClassName CIM_OperatingSystem).Caption | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-After ("Exportado a " + $FileNameSA )
}

function GetVersionSistemaOperativo {
    # Ver version sistema operativo
    Write-Info "11. Version Sistema Operativo"
    Write-Output '11. Version Sistema Operativo' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    (Get-CimInstance -ClassName CIM_OperatingSystem).Version | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-After ("Exportado a " + $FileNameSA )
}

function GetUltimoArranque {
    # Ver ultimo arranque
    Write-Info "12. Ultimo Arranque"
    Write-Output '12. Ultimo Arranque' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    (Get-CimInstance -ClassName CIM_OperatingSystem).LastBootUpTime | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSO
    Write-After ("Exportado a " + $FileNameSA )
}
$FileNameSA = "Sistema de Archivos.txt"
function GetSistemaArchivos {
    # [ ] No lo genera  
    # Ver sistema de archivos

    Write-Info "13. Sistema de Archivos"
    Write-Output '13. Sistema de Archivo' | Out-File -FilePath $SistemaOperativoPath/$FileNameSA
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSA
    Get-Volume | Format-Table | Out-File -Append $SistemaOperativoPath/$FileNameSA
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSA
    Write-After ("Exportado a " + $FileNameSA )
}
function configuracionEFS {
    # TODO Falta corregir 1.- activacion de encryptacion 2.- asignacion de certificado DRA 
    Set-Location ./certificados_EFS
    cipher /r:EFSRA #Input usado para crear Pass PFX es auditoria
    
    Set-Location ../verificar_certificado_DRA_del_sistema_EFS
    fsutil behavior set disableencryption 0
    
}

function getCertificadoDRASystemEFS {
    # [ ] No lo genera
    Write-Info "14. Sistema de Cifrado de Archivos y Carpetas (EFS)."
    Write-Output '14. Sistema de Cifrado de Archivos y Carpetas (EFS).' | Out-File -FilePath $SistemaOperativoPath/$FileNameSA
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSA

    if (-not (test-Path -Path "./certificados_EFS/*")) {
        configuracionEFS
    }

    Set-Location ./verificar_certificado_DRA_del_sistema_EFS

    cipher * | Out-File -Append $SistemaOperativoPath/$FileNameSA
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSA
    Write-After ("Exportado a " + $FileNameSA )

    Set-Location ..
}

$FileNameProgramas = "Programas.txt"
function GetProgramasInstalados {
    
    # Ver programas instalados

    Write-Info "15. Programas Instalados"
    Write-Output '15. Programas Instalados' | Out-File -FilePath $SistemaOperativoPath/$FileNameProgramas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Get-WmiObject -Class Win32_Product | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Write-After ("Exportado a " + $FileNameProgramas )
}

function GetProgramasInicio {
    
    # Ver programas que se ejecutan al iniciar Windows

    Write-Info "16. Programas que se Ejecutan al Iniciar Windows"
    Write-Output '16. Programas que se Ejecutan al Iniciar Windows' | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    wmic startup | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProgramas
    Write-After ("Exportado a " + $FileNameProgramas )
}


$FileNameServicios = "Servicios.txt"
function GetServicios {
    
    # Ver servicios
    Write-Info "17. Servicios"
    Write-Output '17. Servicios' | Out-File -FilePath $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-After ("Exportado a " + $FileNameServicios )
}

function GetServiciosCorriendo {
    
    # Ver servicios corriendo
    Write-Info "18. Servicios Corriendo del Sistema"
    Write-Output '18. Servicios Corriendo del Sistema' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Get-Service | Where-Object { $_.Status -eq "Running" }  | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-After ("Exportado a " + $FileNameServicios )
}

function GetServiciosDetenidos {
    
    # Ver servicios detenidos
    Write-Info "19. Servicios Detenidos del Sistema"
    Write-Output '19. Servicios Detenidos del Sistema' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Get-Service | Where-Object { $_.Status -eq "Stopped" }  | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameServicios
    Write-After ("Exportado a " + $FileNameServicios )
}


$FileNameLog = "Logs.txt"
function GetLogsAdvertencias {
    
    # Ver logs de advertencia
    Write-Info "20. Logs de Warning"
    Write-Output '20. Logs de Warning' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-EventLog -LogName System -EntryType Warning | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("Exportado a " + $FileNameLog )
}

function GetLogsErrores {
    
    # Ver los logs de errores
    Write-Info "21. Logs de Error"
    Write-Output '21. Logs de Error' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-EventLog -LogName System -EntryType Error | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("Exportado a " + $FileNameLog )
}

function GetLogsActualizaciones {
    
    # Ver logs de Windows Update
    Write-Info "22. Logs de Actualizaciones"
    Write-Output '22. Logs de Actualizaciones' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-WinEvent -ProviderName  Microsoft-Windows-WindowsUpdateClient | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("Exportado a " + $FileNameLog )
}

function GetLogsAplicaciones {
    
    # Ver logs de aplicaciones
    Write-Info "23. Logs de Aplicaciones"
    Write-Output '23. Logs de Aplicaciones' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-Eventlog -Logname application | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("Exportado a " + $FileNameLog )
}

function GetLogsSeguridad {
    
    # Ver logs de seguridad
    Write-Info "24. Logs de Seguridad"
    Write-Output '24. Logs de Seguridad' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-Eventlog security | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("Exportado a " + $FileNameLog )
}

function GetLogsProgramasDesinstalados {
    
    # Ver logs de programas desinstalados

    Write-Info "25. Logs de Programas Desinstalados"
    Write-Output '25. Logs de Programas Desinstalados' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Get-EventLog -LogName Application -Source MSIInstaller | Where-Object { $_.EventID -eq '1034' } | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameLog
    Write-After ("Exportado a " + $FileNameLog )

    
}

$FileNameUnidadesDisco = "Unidades de Disco.txt"
function GetUnidadesDisco {
    
    # Ver las unidades de disco

    Write-Info "26. Unidades de Disco"
    Write-Output '26. Unidades de Disco' | Out-File -FilePath $SistemaOperativoPath/$FileNameUnidadesDisco
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameUnidadesDisco
    Get-PSDrive -PSProvider FileSystem | Out-File -Append $SistemaOperativoPath/$FileNameUnidadesDisco
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameUnidadesDisco
    Write-After ("Exportado a " + $FileNameUnidadesDisco )
}


$FileNameRecursosCompartidos = "Recursos Compartidos.txt"
function GetRecursosCompartidos {
    
    # Ver los recursos compartidos
    Write-Info "27. Recursos Compartidos"
    Write-Output '27. Recursos Compartidos' | Out-File -FilePath $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Get-SmbShare | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-After ("Exportado a " + $FileNameRecursosCompartidos )
}

function GetSMB1 {
    
    # Comprobar si SMB1 está activo
    Write-Info "28. SMB1"
    Write-Output '28. SMB1' | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameRecursosCompartidos
    Write-After ("Exportado a " + $FileNameRecursosCompartidos )
}

$FileNameUSB = "USB Conectados.txt"
function GetUSBConectados {
    
    # Comprobar los USB conectados
    Write-Info "29. USB Conectados"
    Write-Output '29. USB Conectados' | Out-File -FilePath $SistemaOperativoPath/$FileNameUSB
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameUSB
    Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | Out-File -Append $SistemaOperativoPath/$FileNameUSB
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameUSB
    Write-After ("Exportado a " + $FileNameUSB )
}
$FileNameSNMP = "SNMP.txt"
function GetSNMP {
    
    # Ver protocolo SNMP
    Write-Info "30. Protocolo SNMP"
    Write-Output '30. Protocolo SNMP' | Out-File -Append $SistemaOperativoPath/$FileNameSNMP
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSNMP
    Get-WindowsCapability -Online -Name “SNMP*” | Out-File -Append $SistemaOperativoPath/$FileNameSNMP
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameSNMP
    Write-After ("Exportado a " + $FileNameSNMP )
}

$FileNameCDROM = "Unidad CD-DVD.txt"
function GetCDROM {
    
    # Comprobar unidad CD/DVD
    Write-Info "31. Comprobar Unidad CD/DVD"
    Write-Output '31. Comprobar Unidad CD/DVD' | Out-File -FilePath $SistemaOperativoPath/$FileNameCDROM
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameCDROM
    (Get-WMIObject -Class Win32_CDROMDrive -Property *).MediaLoaded | Out-File -Append $SistemaOperativoPath/$FileNameCDROM
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameCDROM
    Write-After ("Exportado a " + $FileNameCDROM )
}

$FileNameProcesos = "Procesos.txt"
function GetProcesos {
    
    # Lista de procesos
    Write-Info "32. Lista de Procesos"
    Write-Output '32. Lista de Procesos' | Out-File -FilePath $SistemaOperativoPath/$FileNameProcesos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Get-Process  | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Write-After ("Exportado a " + $FileNameProcesos )
}   

function Get5Procesos {
    
    # Lista de 5 procesos que ocupan más memoria
    Write-Info "33. 5 Procesos que Ocupan mas Memoria"
    Write-Output '33. 5 Procesos que Ocupan mas Memoria' | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    ps | sort -p ws | select -last 5  | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameProcesos
    Write-After ("Exportado a " + $FileNameProcesos )
}

$FileNameTareas = "Tareas Programadas.txt"
function GetTareasProgramadas {
    
    # Ver tareas programadas
    Write-Info "34. Tareas Programadas"
    Write-Output '34. Tareas Programadas' | Out-File -FilePath $SistemaOperativoPath/$FileNameTareas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameTareas
    Get-ScheduledTask  | Out-File -Append $SistemaOperativoPath/$FileNameTareas
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameTareas
    Write-After ("Exportado a " + $FileNameTareas )
}

$FileNamePuertos = "Puertos.txt"

function GetPuertos {
    
    # Ver puertos del sistema
    Write-Info "35. Puertos del Sistema"
    Write-Output '35. Puertos del Sistema' | Out-File -FilePath $SistemaOperativoPath/$FileNamePuertos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNamePuertos
    Get-NetTCPConnection -State Listen  | Out-File -Append $SistemaOperativoPath/$FileNamePuertos
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNamePuertos
    Write-After ("Exportado a " + $FileNamePuertos )

}

$FileNameDefender = "Defender.txt"
function GetEstadoMalware {
    #[ ] falta ver que que numero es 
    Write-Info "36. Informacion de Defender"
    Write-Output "36. Informacion de Defender" | Out-File -Append $SistemaOperativoPath/$FileNameDefender
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameDefender
    Get-MpComputerStatus | Out-File -Append $SistemaOperativoPath/$FileNameDefender
    Write-Output '-------------------------------------------------------' | Out-File -Append $SistemaOperativoPath/$FileNameDefender
    Write-After ("Exportado a " + $FileNameDefender )
}

$FileNameDominioAD = "Informacion Dominio y AD.txt"
function GetDominio {
     
    # Ver dominio
    Write-Info "37. Dominio"
    Write-Output '37. Dominio' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Get-WMIObject Win32_ComputerSystem | Select-Object -ExpandProperty Domain | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-After ("Exportado a " + $FileNameDominioAD )
}


function GetADDController {
     
    # Ver Controlador de dominio AD
    Write-Info "38. Controlador de Dominio AD"
    Write-Output '38. Controlador de Dominio AD' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Get-AdDomainController | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-After ("Exportado a " + $FileNameDominioAD )
}

function GetGPO ($Dominio) {

    Write-Info "39. GPO de Active Directory"
    Write-Output "39. GPO de Active Directory" | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Get-GPO -All -Domain $Dominio | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameDominioAD
    Write-After ("Exportado a " + $FileNameDominioAD )
    
}

$FileNameAuditoriaAudipol = "Audipol.txt"
function GetCategoriasAuditoria {
     
    # Ver categorias de auditoria
    Write-Info "40. Categorias de Auditoria"
    Write-Output '40. Categorias de Auditoria' | Out-File -FilePath $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    auditpol /get /category:* | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-After ("Exportado a " + $FileNameAuditoriaAudipol )
}

function GetSubcategoriasAuditoria {
     
    # Ver subcategorias de auditoria
    Write-Info "41. Subcategorias de Auditoria"
    Write-Output '41. Subcategorias de Auditoria' | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    auditpol /list /subcategory:* | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameAuditoriaAudipol
    Write-After ("Exportado a " + $FileNameAuditoriaAudipol )
}

$FileNamePoliticaContra = "Politica de Contras.txt"
function GetPoliticaContras {
     
    # Ver la política de contraseñas
    Write-Info "42. Politica de Contras"
    Write-Output '42. Politica de Contras' | Out-File -Append $ActiveDirectoryPath/$FileNamePoliticaContra
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNamePoliticaContra
    Get-ADDefaultDomainPasswordPolicy | Out-File -Append $ActiveDirectoryPath/$FileNamePoliticaContra
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNamePoliticaContra
    Write-After ("Exportado a " + $FileNamePoliticaContra )
}

$FileNameUsuariosAD = "Usuarios.txt"
function GetUsuariosAD {
     
    # Ver la lista de usuarios de AD
    Write-Info "43. Usuarios de AD"
    Write-Output '43. Usuarios de AD' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Get-ADUser -Filter * -Properties whencreated | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-After ("Exportado a " + $FileNameUsuariosAD )

}


function GetUsuariosDeshabilitados {
     
    # Ver la lista de usuarios de AD deshabilitados
    Write-Info "44. Usuarios de AD Deshabilitados"
    Write-Output '44. Usuarios de AD Deshabilitados' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Search-ADAccount -AccountDisabled | select name | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-After ("Exportado a " + $FileNameUsuariosAD )
}

function GetUsuariosContras {
     
    # Ver la lista de usuarios de AD cuya contraseña no expira

    Write-Info "45. Usuarios de AD Cuya Contra no Expira"
    Write-Output '45. Usuarios de AD Cuya Contra no Expira' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Get-ADUser -Filter * -Properties Name, PasswordNeverExpires | where { $_.passwordNeverExpires -eq "true" } | Select-Object DistinguishedName, Name, Enabled | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-After ("Exportado a " + $FileNameUsuariosAD )
}
function GetPermisosUsuarioAD {
    #[ ] falta ver que que numero es 
    Write-Info "46. Permisos de usuario de Active Directory"
    Write-Output "46. Permisos de usuario de Active Directory" | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Get-ADUser -Filter * | % { (Get-ACL "AD:$($_.distinguishedname)").access } | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-After ("Exportado a " + $FileNameUsuariosAD )
}

function GetUltimaConexionUsuario($User) {
     
    # última conexión de un usuario en específico
    Write-Info "47. Ultima conexion del Usuario de AD"
    Write-Output '47. Ultima conexion del Usuario de AD' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Get-ADUser -Identity $User -Properties "LastLogonDate" | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameUsuariosAD
    Write-After ("Exportado a " + $FileNameUsuariosAD )
}



$FileNameEquiposAD = "Equipos Conectados al Dominio.txt"
function GetEquiposConectadosDominio {
     
    # Ver equipos conectados al dominio
    Write-Info "48. Equipos Conectados al Dominio"
    Write-Output "48. Equipos Conectados al Dominio" | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Get-ADComputer -Filter * | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-After ("Exportado a " + $FileNameEquiposAD )
}

function GetContadorEquiposDominio {
     
    # Ver cantidad de equipos conectados al dominio
    Write-Info "49. Cantidad de Equipos Conectados"
    Write-Output "49. Cantidad de Equipos Conectados" | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Get-ADComputer -Filter * | measure | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-After ("Exportado a " + $FileNameEquiposAD )
}

function GetSOEquiposConectadosDominio {
     
    # Ver sistemas operativos de equipos conectados al dominio

    Write-Info "50. Sistemas Operativos de los Equipos Conectados"
    Write-Output "50. Sistemas Operativos de los Equipos Conectados" | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Get-ADComputer -Filter "name -like '*'" -Properties operatingSystem | group -Property operatingSystem | Select Name, Count | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-Output '-------------------------------------------------------' | Out-File -Append $ActiveDirectoryPath/$FileNameEquiposAD
    Write-After ("Exportado a " + $FileNameEquiposAD )
}

#Configuración del Servidor
GetZonaHoraria
GetFechaHora
GetActualizaciones
GetDireccionIP
GetTarjetasRed
GetIPv6
GetNombreEquipo
GetUsuarios
ReporteEnergetico

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
GetSNMP
GetCDROM
GetProcesos
Get5Procesos
GetTareasProgramadas
GetPuertos
GetEstadoMalware

#Active Directory
GetDominio
GetADDController
GetGPO auditoria.log
GetCategoriasAuditoria
GetSubcategoriasAuditoria
GetPoliticaContras
GetUsuariosAD
GetUsuariosDeshabilitados
GetUsuariosContras
GetPermisosUsuarioAD
#Especificar usuario como parámetro
GetUltimaConexionUsuario Administrador
GetEquiposConectadosDominio
GetContadorEquiposDominio
GetSOEquiposConectadosDominio



