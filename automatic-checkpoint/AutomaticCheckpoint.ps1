# variable to store the current date
$date = Get-Date

# loop through all VMs to create a checkpoint 
# writes to eventlog with success or error messages 
foreach ($vm in Get-VM){
    try  {
        Checkpoint-VM -VM $vm -SnapshotName "Automatic Backup: $date"
        Write-EventLog -LogName System -EventID 70 -Source "Microsoft-Windows-Hyper-V-Hypervisor" -Message "Checkpoint created successfully for $vm"
    } catch {
        Write-EventLog -LogName System -EventId 71 -Source "Microsoft-Windows-Hyper-V-Hypervisor" -Message "Failed creating checkpoint for $vm"
    }
}