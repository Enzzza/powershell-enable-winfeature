# Enabling windows feature via powershell script


If you are using Docker and Virtual Machine on Windows 10 you noticed you can't use both at same time. 
In my case if i want to use Docker i need to enable *Virtual Machine Feature*, and if i want to use VMware/Virtual Box i need to disable that feature.

![Windows Features](https://raw.githubusercontent.com/Enzzza/powershell-enable-winfeature/main/images/img1.PNG)

I am lazy to open GUI so i made  powershell script that will enable/disable this feature.

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

This script will check state of feature is it enabled or disabled. Based on state it will tell you what are you going to activate if you execute this script.