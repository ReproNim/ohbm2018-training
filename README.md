# Instructions
## Install VirtualBox
- Go to the VirtualBox Download page: https://www.virtualbox.org/wiki/Downloads
- Select the link from the "VirtualBox 5.2.12 platform packages" section that matches your system.

- For Windows 10 users:
    Double-click the downloaded executable file (Windows Installer 1.1 or higher is required)
    Select default options in installation dialog.
    The installer will create a "VirtualBox" group in the Windows Start menu.
    See here for more detailed step-by-step instructions: https://websiteforstudents.com/installing-virtualbox-windows-10/

  - For Mac users:
    Double-click on the downloaded dmg file to have its contents mounted
    A window will open telling you to double click on the VirtualBox.pkg installer file displayed in that window.
    This will start the installer, which will allow you to select where to install VirtualBox to.
    After installation, you can find a VirtualBox icon in the "Applications" folder in the Finder.
 
  - For Ubuntu users:
    Step-by-step instructions can be found here: https://websiteforstudents.com/install-virtualbox-latest-on-ubuntu-16-04-lts-17-04-17-10/
    

## Download and import the VM file
  - Download from https://training.repronim.org/reprotraining.ova
  - To import the reprotraining.ova file, select "File" -> "Import Appliance" from the VirtualBox menu.
    Click through the import wizard dialog leaving the default settings.
    See here for example step-by-step instructions: https://docs.oracle.com/cd/E26217_01/E26796/html/qs-import-vm.html
  
## Issues: 
  - if you have a windows 10 pro 64 bit (eg Lenovo X1C) machine and get an error like: 
    vt-x/amd-v hardware acceleration is not available on your system  
  [look here](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v#enable-the-hyper-v-role-through-settings)
  - if you are unable to install VirtualBox due to virtualization technology (VT-x) not being enabled on your system [look here] (https://docs-old.fedoraproject.org/en-US/Fedora/13/html/Virtualization_Guide/sect-Virtualization-Troubleshooting-Enabling_Intel_VT_and_AMD_V_virtualization_hardware_extensions_in_BIOS.html)
  

# OHBM 2018 Reproducibility Course Schedule

## Stats components
* sampling : do we get the same results with sampling 
* [ permutation ? ]
* p-values: what they do not tell you
* p-hacking : vibration with sampling/QC: data selection, vibration with model, 
* power ? 
