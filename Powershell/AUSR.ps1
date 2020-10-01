# Ausr powershell

function Advanced-Reboot
{
  param
  (
    [string]$ControlerIP="Default",
    [string]$ControllerUser="Default",
    [string]$ControllerPassword="Default",
    [int]$ControllerPort=0,
    [string]$ControllerTimer="Default",
    [string]$ControllerCommand="Default",
    [int]$UniFiDeviceCount=0
  )

}

function Schedule-Reboot
{
    if(Test-Path -Path $ENV:USERPROFILE"\Documents\AUSR.txt")
    {
      # Do nothing
    }
    else
    {
      New-Item $ENV:USERPROFILE"\Documents\AUSR.txt"
      Write-Host "Created text file for loging purposes..."
    }
    $ControllerIP = Read-Host "What's the IP address of the controller "
    $ControllerUser = Read-Host "What's the Username for the controller "
    $ControllerPassword = Read-Host "What's the password for the controller "
    $ControllerTimer = Read-Host "Please input the desire reboot time for the
controller in Cron format. If you need help go here https://crontab.guru/ . If
you don't want to reboot the controller just type skip "
     if($ControllerTimer -eq "skip")
     {
       $UniFiDeviceCount = Read-Host "How many devices do you want to reboot? "
       $isUnameSame = Read-Host "Is the username for each device the same "
       $isPassSame = Read-Host "Is the password for each device the same "
       $DeviceCount = 0

       if($isUnameSame -eq "y" -and $isPassSame -eq "y")
       {
         $DeviceUser = Read-Host "Input device username "
         $DevicePass = Read-Host "Input device password "


         while($DeviceCount -lt [int]$UniFiDeviceCount)
         {
           $DeviceCount+=1
           if($DeviceCount -gt 0 -and $DeviceCount -lt $UniFiDeviceCount)
           {
             $DeviceIP = Read-Host "Enter the IP for device " $DeviceCount " "
             $DeviceTimer = Read-Host "Enter the Timer for device " $DeviceCount " "
             $DeviceCommand = Read-Host "Enter the Command for device " $DeviceCount " "
             # Execute-Commands($DeviceIP, $DeviceUser, $DevicePass, 22, $DeviceTimer, $DeviceCommand)
             Execute-Commands -UName $DeviceUser -IPAddress $DeviceIP -DiffPort 22 -PWord $DevicePass -DevTimer $DeviceTimer -DevCommand $DeviceCommand
             # Finish this function first
           }
         }
       }

       if($isUnameSame -eq "n" -or $isPassSame -eq "n")
       {
         while($DeviceCount -lt [int]$UniFiDeviceCount)
         {
           $DeviceCount+=1
           $DeviceUser = Read-Host "Input username for device "$DeviceCount" "
           $DevicePass = Read-Host "Input password for device "$DeviceCount" "
           $DeviceIP = Read-Host "Enter the IP for device " $DeviceCount " "
           $DeviceTimer = Read-Host "Enter the Timer for device " $DeviceCount " "
           $DeviceCommand = Read-Host "Enter the Command for device " $DeviceCount " "
           Execute-Commands($DeviceUser, $DeviceIP, 22, $DevicePass, $DeviceTimer, $DeviceCommand)
         }
       }
       # End Skip Clause
     }
     if($ControllerTimer -ne "skip")
     {

       $UniFiDeviceCount = Read-Host "How many devices do you want to reboot? "
       $isUnameSame = Read-Host "Is the username for each device the same "
       $isPassSame = Read-Host "Is the password for each device the same "
       $DeviceCount = 0

       if($isUnameSame -eq "y" -and $isPassSame -eq "y")
       {
         $DeviceUser = Read-Host "Input device username "
         $DevicePass = Read-Host "Input device password "


         while($DeviceCount -lt [int]$UniFiDeviceCount)
         {
           $DeviceCount+=1
           if($DeviceCount -gt 0 -and $DeviceCount -lt $UniFiDeviceCount)
           {
             $DeviceIP = Read-Host "Enter the IP for device " $DeviceCount " "
             $DeviceTimer = Read-Host "Enter the Timer for device " $DeviceCount " "
             $DeviceCommand = Read-Host "Enter the Command for device " $DeviceCount " "
             Execute-Commands($DeviceIP, $DeviceUser, $DevicePass, 22, $DeviceTimer, $DeviceCommand)
           }
         }
       }

       if($isUnameSame -eq "n" -or $isPassSame -eq "n")
       {
         while($DeviceCount -lt [int]$UniFiDeviceCount)
         {
           $DeviceCount+=1
           $DeviceUser = Read-Host "Input username for device "$DeviceCount" "
           $DevicePass = Read-Host "Input password for device "$DeviceCount" "
           $DeviceIP = Read-Host "Enter the IP for device " $DeviceCount " "
           $DeviceTimer = Read-Host "Enter the Timer for device " $DeviceCount " "
           $DeviceCommand = Read-Host "Enter the Command for device " $DeviceCount " "
           Execute-Commands($DeviceIP, $DeviceUser, $DevicePass, 22, $DeviceTimer, $DeviceCommand)
         }
       }
     }

} # End basic func

function Execute-Commands
{
     param
     (
         [string]$UName="Default",
         [string]$IPAddress="Default",
         [int]$DiffPort=22,
         [string]$PWord="Default",
         [string]$DevTimer="Default",
         [string]$DevCommand="Default"
     )
     Log-Data -usr $Uname -ady $IPAddress -selp $DiffPort -pass $PWord -ctime $DevTimer -ecom $DevCommand
}

function Log-Data
{
  param
  (
      [string]$usr="Default",
      [string]$ady="Default",
      [int]$selp=22,
      [string]$pass="Default",
      [string]$ctime="Default",
      [string]$ecom="Default"
  )
  Add-Content $ENV:USERPROFILE"\Documents\AUSR.txt" "$($usr)@$($ady):$($selp) sshpass -p $($pass) $($ctime) $($ecom)"
}

Schedule-Reboot
