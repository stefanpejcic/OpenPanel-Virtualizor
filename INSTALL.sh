#!/bin/bash
set -e

readonly GITHUB_REPO="https://github.com/stefanpejcic/OpenPanel-Virtualizor"

#1. check requirements
if [[ $EUID -ne 0 ]]; then
    echo "[✖] This script must be run as root!"
    exit 1
fi

if command -v virtualizor >/dev/null 2>&1; then
    echo "[✔] Virtualizor detected - proceeding with the install.."
else
    echo "[✖] Virtualizor binary not found! Is this a Virtualizor master server?"
    exit 1
fi

#2. set cleanup
cleanup() {
    echo
    echo "Cleaning up..."
    rm -rf "/tmp/OpenPanel-Virtualizor"
}

trap cleanup EXIT INT TERM

#3. clone feom github
echo
echo "Clonning $GITHUB_REPO"
cd /tmp
git clone "$GITHUB_REPO"

#4. https://youtu.be/tw429JGL5zo
echo
echo "Setup according to https://www.virtualizor.com/docs/admin/adding-custom-control-panel/"
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
echo
echo "Checking if installation succeded.."
for f in "${FILES[@]}"; do
    if [[ -f "$f" ]]; then
        echo "[✔] $f"
    else
        echo "[✖] $f"
        missing=true
    fi
done
if [[ "$missing" = true ]]; then
    echo
    echo "[⚠️] Some files are missing. Please re-run the script with"
    exit 1
else
    echo
    echo "[✅] All files copied successfully."
    echo "Done."
    exit 0
fi
