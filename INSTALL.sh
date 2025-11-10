#!/bin/bash
# https://www.virtualizor.com/docs/admin/adding-custom-control-panel/

cd /tmp
git clone https://github.com/stefanpejcic/OpenPanel-Virtualizor

cd /tmp/OpenPanel-Virtualizor
cp virt_openpanel.sh /usr/local/virtualizor/hooks/virt_openpanel.sh
cp virt_openpanel.png /usr/local/virtualizor/enduser/themes/default/images/virt_openpanel.png
cp openpanel_supported_os.json /usr/local/virtualizor/openpanel_supported_os.json

cd ../
rm -rf /tmp/OpenPanel-Virtualizor
