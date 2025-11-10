#!/bin/bash

# check if virtualizor


# clone script
cd /tmp
git clone https://github.com/stefanpejcic/OpenPanel-Virtualizor

# setup according to https://www.virtualizor.com/docs/admin/adding-custom-control-panel/
cd /tmp/OpenPanel-Virtualizor
cp virt_openpanel.sh /usr/local/virtualizor/hooks/virt_openpanel.sh
cp virt_openpanel.png /usr/local/virtualizor/enduser/themes/default/images/virt_openpanel.png
cp openpanel_supported_os.json /usr/local/virtualizor/openpanel_supported_os.json

#cleanul
cd ../
rm -rf /tmp/OpenPanel-Virtualizor
