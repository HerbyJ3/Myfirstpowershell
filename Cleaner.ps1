#############Bios function start###########

$computername = Read-Host "Enter PC Name"


$Monit = get-wmiobject Win32_Desktopmonitor -ComputerName $computername -ea silentlycontinue
$Winversion=Get-WmiObject win32_operatingsystem -ComputerName $computername -ea silentlycontinue
$os = Get-WmiObject Win32_bios -ComputerName $computername -ea silentlycontinue
$Ninstance = Get-CimInstance Win32_SystemEnclosure -ComputerName $computername -ea silentlycontinue
$Mod=Get-CimInstance Win32_ComputerSystemProduct -ComputerName $computername -ea silentlycontinue
 if($os){

   $SerialNumber =$os.SerialNumber
   $servername=$os.PSComputerName 
   $SMBIOSBIOSVersion=$os.SMBIOSBIOSVersion
   $Manufacturer=$Ninstance.SMBIOSAssetTag
   $SMBIOSAssetTag = $Ninstance.SMBIOSAssetTag
   $Model=$Mod.Name
   $Operate=$Winversion.Name.TrimEnd("|C:\WINDOWS|\Device\Harddisk0\Partition4")
   $Bit = $Winversion.OSArchitecture
   $Monitor = $Monit.DeviceID.Count

 $results =new-object psobject

 $results |Add-Member noteproperty SerialNumber $SerialNumber
 $results |Add-Member noteproperty ComputerName $servername
 #$results |Add-Member noteproperty BIOSVersion $SMBIOSBIOSVersion
 $results |Add-Member noteproperty SMBIOSAssetTag $Manufacturer
 $results |Add-Member noteproperty Model $Model
 $results |Add-Member noteproperty OS $Operate
 $results |Add-Member noteproperty Bit $Bit
 $results |Add-Member noteproperty Monitors $Monitor
 #Display the results
 
 
 $results| Select-Object Model, computername,SerialNumber, SMBIOSAssetTag,Bit,OS, Monitors |Out-GridView | Out-String

 }
   
    
else

 {

 
 $results =new-object psobject

 $results |Add-Member noteproperty SerialNumber "Na"
 $results |Add-Member noteproperty ComputerName "NA"
 $results |Add-Member noteproperty Name  "NA"
 $results |Add-Member noteproperty SMBIOSBIOSVersion  "NA"
 $results |Add-Member noteproperty Manufacture   "NA"
 Write-Output "PC does not exist"

 
 #display the results
 $results | Select-Object computername,SMBIOSBIOSVersion,Name,Manufacture ,SerialNumber,AssetTag  | Out-GridView | Out-String
 }
 

 




 



 
 $infbios =@()


 foreach($allserver in $allservers){

 $infbios += get-Bios $allserver 
 }

 $infbios

 ####################################Bios function end############################

