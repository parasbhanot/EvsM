#!/bin/sh

BOARD_DIR="$(dirname $0)"
OVERLAY_CFG="${BOARD_DIR}/overlay"
TARGET_CFG="${TARGET_DIR}"
OUTPUT_CFG="${BASE_DIR}"

echo "This is Fake root script"
echo "copy some files and pest at target folder"
echo "board dir" "${OVERLAY_CFG}"
echo "build dir" "${TARGET_CFG}"
echo "output dir" "${OUTPUT_CFG}"

echo "giving permissions"

chmod 755 "${TARGET_CFG}"/var/empty
chmod -R 777 "${TARGET_CFG}"/home/launchApps/
chmod -R 777 "${TARGET_CFG}"/etc/init.d
#chattr +i "${TARGET_CFG}"/etc/resolv.conf


