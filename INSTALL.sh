#!/bin/bash
set -e

readonly GITHUB="stefanpejcic" # might be org eventually
readonly REPOSITORY="OpenPanel-Virtualizor"

#1. check requirements
if [[ $EUID -ne 0 ]]; then
    echo "[✖] This script must be run as root!"
    exit 1
fi

if command -v virtualizor >/dev/null 2>&1; then
    echo "[ OK ] Virtualizor detected - proceeding with the install.."
else
    echo "[FAIL] Virtualizor binary not found! Is this a Virtualizor master server?"
    exit 1
fi

#2. set cleanup
cleanup() {
    echo
    echo "Cleaning up..."
    rm -rf "/tmp/$REPOSITORY"
}

trap cleanup EXIT INT TERM

#3. clone from github
echo
echo "Clonning $GITHUB/$REPOSITORY"
cd /tmp
git clone "https://github.com/$GITHUB/$REPOSITORY"

#4. https://youtu.be/tw429JGL5zo
echo
echo "Setup according to https://www.virtualizor.com/docs/admin/adding-custom-control-panel/"
cd "$REPOSITORY"
cp virt_openpanel.sh /usr/local/virtualizor/hooks/virt_openpanel.sh
cp virt_openpanel.png /usr/local/virtualizor/enduser/themes/default/images/virt_openpanel.png
cp openpanel_supported_os.json /usr/local/virtualizor/openpanel_supported_os.json

#5. check
FILES=(
    "/usr/local/virtualizor/hooks/virt_openpanel.sh"
    "/usr/local/virtualizor/enduser/themes/default/images/virt_openpanel.png"
    "/usr/local/virtualizor/openpanel_supported_os.json"
)

missing=false
x_command="bash -x <(curl -sSL https://raw.githubusercontent.com/$GITHUB/$REPOSITORY/refs/heads/main/INSTALL.sh)"

echo
echo "Checking files.."
for f in "${FILES[@]}"; do
    if [[ -f "$f" ]]; then
        echo " [✔] $f"
    else
        echo " [✖] $f"
        missing=true
    fi
done
if [[ "$missing" = true ]]; then
    echo
    echo "[FAILED] Please re-run this command and share it's output on community.openpanel.org"
    echo
    echo "$x_command"
    exit 1
else
    echo
    echo "[OK] Installation completed successfully, OpenPanel is now available on your Virtualizor server."
    exit 0
fi
