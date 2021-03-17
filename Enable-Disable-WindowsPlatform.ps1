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




