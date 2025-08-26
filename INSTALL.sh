#!/bin/bash

:'
https://www.virtualizor.com/docs/admin/adding-custom-control-panel/
'


cd /tmp
git clone https://github.com/stefanpejcic/OpenPanel-Virtualizor
cd /tmp/OpenPanel-Virtualizor
cp virt_openpanel.sh /usr/local/virtualizor/hook/
cp virt_openpanel.png /usr/local/virtualizor/enduser/themes/default/images/
cp openpanel_supported_os.json /usr/local/virtualizor/
cd ../
rm -rf /tmp/OpenPanel-Virtualizor
