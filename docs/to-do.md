# To-do list

## ~~Set up bare metal host~~ 

(certain processes done manually, need to automate this process with Ansible playbooks for the following tasks, which will end up as `init-proxmox-config`: Proxmox host configuration, SSH settings + key creation, partitioning disks, passing through disks to VM, setting up repository, removing nag screen, creating API tokens, creating appropriate service accounts, setting up user account)

Progress on manual setup:
- ~~Install the Proxmox VE hypervisor on NAS host; use on NVMe drive, formatted as `zfs`~~
- ~~[Set](https://www.servethehome.com/how-to-change-primary-proxmox-ve-ip-address/) internal static IP of the Proxmox host~~
- ~~Create [ZFS pool(s)](https://www.45drives.com/community/articles/RAID-and-RAIDZ/) and choose RAID level from available storage; RAID explained [here](https://eshop.macsales.com/blog/56056-a-beginners-guide-to-understanding-raid/)~~
- ~~Format SSD for VM guest OS use~~
- ~~install `sudo`~~
- ~~Create service account on Proxmox for the following services:~~
  -  ~~`packer`~~
  -  ~~`terraform`
  -  ~~`ansible`
  -  ~~SSH keys~~
- ~~Create API tokens~~

## Configure Proxmox automation

- Use Packer to create a standard VMI (Virtual Machine Image) containing `cloud-init`; this will produce an artifact for later deployment use - ***have base config, needs testing, needs more research***
- Use Terraform to automate provisioning of a VM on the Proxmox platform ***have base config, needs testing, needs more research***
- Use `cloud-init` to complete bare-minimum configuration of the VM
- Use custom Ansible playbooks to start application configuration and standing up of container infrastructure

## Things to architect and plan

- Provisioning (with Terraform) a "DevOps" VM containing the GitLab/Packer/Terraform/Ansible runners and container/artifact registry
- The end-to-end architecture of the GitLab CI/CD pipeline
- The network architecture (including reverse proxy (might need VM), SSL certificates, DDNS, port forwarding, etc)
- Create different Ansible playbooks for each VM, and within each VM, each task needing provisioning, container infrastructure provisioning, etc.

### Ansible tasks

- for the `init-ultimate-nas-vm` deployment:
  - editing the `/etc/fstab` file to include mounting the passthrough disks (via their disk id)
  - mounting the passed through disks within the VM, targeted at the hypervisor host
    - The order of this is:
      1. Power off the Ultimate NAS VM ([kill](https://forum.proxmox.com/threads/stop-vm-impossible.101736/) the VM if frozen)
      2. [Unmount](https://forum.proxmox.com/threads/remove-virtual-machine-options-with-qm.37122/) all the disks on the NAS that are attached to the Ultimate NAS VM
      3. Start the VM and wait until the VM tries to mount the disks, which hangs the boot process
      4. [Mount](https://pve.proxmox.com/pve-docs/qm.1.html) the disks, which allows the boot to continue