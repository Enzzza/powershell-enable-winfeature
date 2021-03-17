# Enabling windows feature via powershell script


<p>If you are using Docker and Virtual Machine on Windows 10 you noticed you can't use both at same time. 
In my case if i want to use Docker i need to enable <em>Virtual Machine Feature</em>, and if i want to use VMware/Virtual Box i need to disable that feature.</p>
</br> 



![Windows Features](https://raw.githubusercontent.com/Enzzza/powershell-enable-winfeature/main/images/img1.PNG)  
</br> 


<p>I am lazy to open GUI so i made  powershell script that will enable/disable this feature.</p>
</br>   

```powershell
$feature = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
$featureState = $feature.State
$featureName = $feature.FeatureName
$programName = ''

if($featureState -eq "Enabled"){
    $programName = "Virtual Machine"
}else{
    $programName = "Docker"
}


$title    = 'Activate '+ $programName 
$question = 'Are you sure you want to proceed?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    
    if($featureState -eq "Enabled") {
        Write-Output("Disabling " + $featureName + " Feature")
        Disable-WindowsOptionalFeature -Online -FeatureName $featureName

    }else{
        Write-Output("Enabling " + $featureName + " Feature")
        Enable-WindowsOptionalFeature -Online -FeatureName $featureName -all
    }
} else {
   Exit
}
```  

<p>This script will check state of feature is it enabled or disabled.</p> 
<p>Based on state it will tell you what are you going to activate if you execute this script.</p>
</br> 




![Powershell script](https://raw.githubusercontent.com/Enzzza/powershell-enable-winfeature/main/images/img2.PNG)
</br> 

<p>We can't run powershell script with double click so we will make Batch script that will call powershell script with administrator rights.</p>
</br>   

```batch
@ECHO OFF
PowerShell.exe -NoProfile -Command "& {Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dpn0.ps1""' -Verb RunAs}"

TIMEOUT /t 10

```
</br> 

<p>Put both scripts in same folder.</p>
</br> 

![Folder](https://raw.githubusercontent.com/Enzzza/powershell-enable-winfeature/main/images/img3.PNG)
</br> 
<p>Now we will make shortcut to this Batch script.</p>
</br> 

![Shortcut](https://raw.githubusercontent.com/Enzzza/powershell-enable-winfeature/main/images/img4.PNG)
</br> 
<p>We will change icon so we can find it easier on desktop.</p>
</br> 

![Icon](https://raw.githubusercontent.com/Enzzza/powershell-enable-winfeature/main/images/img5.PNG)
</br> 

<p> I hope this will help someone :wink:</p>