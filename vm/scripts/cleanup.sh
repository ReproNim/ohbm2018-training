#!/bin/bash
echo 'Clean up disk ...'
rm /home/vagrant/VBoxGuestAdditions.iso
sync && $HOME/miniconda2/bin/conda clean -tipsy && sync
sudo apt-get clean

# Zero out padded disk space for later compacting by 
# VBoxManage commands run in packer post-processing
sudo dd if=/dev/zero of=zerofillfile bs=1M
sudo rm zerofillfile
