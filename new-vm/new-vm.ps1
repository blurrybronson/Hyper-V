# variable values
$vm_name = Read-Host("VM Name ")
$memory_size = Read-Host("Memory (GB) ")
$vhd_size = Read-Host("VHD (GB) ")

# static values
$gen = 1                                                           # generation of the machine: 1 or 2. Gen 2 supports UEFI
$computer_name = "BRONSON-MAIN"                                    # name of the hyper-v host
$vhd_path = "e:\VMs\$vm_name\Virtual Hard Disks\$vm_name.VHDX"     # path where the new VHD will be stored
$switch = "External Switch"                                        # switch to be used by the vm
$checkpoint_type = "Production"                                    # the type of checkpoint to be used
$memory_min = 1MB*512                                              # minimum RAM to be used
$paging_path = "e:\VMs\$vm_name"                                   # location of the Virtual Machines folder
$snapshot_path = "e:\VMs\$vm_name"                                 # location of the Snapshot folder

# byte conversions 
$memory_size = 1GB*$memory_size
$vhd_size = 1GB*$vhd_size

# creating new vm
New-VM -Name $vm_name `
    -MemoryStartupBytes $memory_size `
    -Generation $gen `
    -BootDevice IDE `
    -ComputerName $computer_name `
    -NewVHDPath $vhd_path `
    -NewVHDSizeBytes $vhd_size `
    -SwitchName $switch 

# setting vm attriubutes 
Set-VM -Name $vm_name `
    -SmartPagingFilePath $paging_path `
    -CheckpointType $checkpoint_type `
    -DynamicMemory `
    -MemoryMinimumBytes $memory_min `
    -MemoryMaximumBytes $memory_size `
    -SnapshotFileLocation $snapshot_path