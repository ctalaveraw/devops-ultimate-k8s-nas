# Proxmox Full-Clone
# ---
# Create a new VM from a clone

# VMID generator
resource "random_integer" "vmid" {
  min = 101
  max = 109
}

resource "proxmox_vm_qemu" "pipeline-runner" {
    /*
    Sensible defaults for VM settings are used
    Documentation on minimum system requirements for self-hosting GitLab can be found here:
    https://docs.gitlab.com/ee/install/requirements.html
    */

    # VM General Settings
    target_node = "${var.proxmox_target_node}"
    vmid = random_integer.vmid
    name = "pipeline-runner"
    desc = "VM to host containers for running GitLab, which will host the CI/CD pipeline"

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings
    clone = "${var.proxmox_vm_template_name}"

    # VM System Settings
    agent = 1 # Set to "1" to enable QEMU Guest Agent
    
    # VM CPU Settings
    cores = 4
    sockets = 1
    cpu = "host" # Set to "host" for best CPU emulation performance
    
    # VM Memory Settings
    memory = 4096

    # VM Network Settings
    network {
        bridge = "vmbr0"
        model  = "virtio"
    }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    # ipconfig0 = "ip=0.0.0.0/0,gw=0.0.0.0"
    
    # (Optional) Default User
    # ciuser = "your-username"
    
    # (Optional) Add your SSH KEY
    # sshkeys = <<EOF
    # #YOUR-PUBLIC-SSH-KEY
    # EOF
}