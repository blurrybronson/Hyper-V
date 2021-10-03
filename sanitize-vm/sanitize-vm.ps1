# reading and parsing the config file
$config = Get-Content -path "config.json" | ConvertFrom-Json

# assigning variables
$machine_name = $config.settings.machine_name
$snapshot_name = $config.settings.snapshot_name


$vm = Get-VM -Name $machine_name

# disconnecting the network adapter
Disconnect-VMNetworkAdapter -VMName $vm.Name
Write-Host "Please press any key when you have finished working in the virtual environment"
Read-Host

# powering down the VM
Stop-VM -Name $vm.Name

# restoring the vm from the checkpoint
Restore-VMSnapshot -VMName $vm.Name -Name $snapshot_name -Confirm:$false

# providing output for verification
Write-Host "Machine state has been restored successfully"
Read-Host