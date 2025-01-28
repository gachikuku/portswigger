#!/bin/bash

NETWORK_SERVICE="Wi-Fi"
PROXY_SERVER="127.0.0.1"
PROXY_PORT="8080"
ORIGINAL_FILE="_http1.py"
PATCH_FILE="smuggle.patch"

enable_proxy() {
    echo "Enabling web proxy for $NETWORK_SERVICE..."
    sudo networksetup -setwebproxy "$NETWORK_SERVICE" "$PROXY_SERVER" "$PROXY_PORT"
    sudo networksetup -setsecurewebproxy "$NETWORK_SERVICE" "$PROXY_SERVER" "$PROXY_PORT"
    echo "Web proxy enabled."
}

disable_proxy() {
    echo "Disabling web proxy for $NETWORK_SERVICE..."
    sudo networksetup -setwebproxystate "$NETWORK_SERVICE" off
    sudo networksetup -setsecurewebproxystate "$NETWORK_SERVICE" off
    echo "Web proxy disabled."
}

apply_patch() {
    echo "Applying patch to $ORIGINAL_FILE..."
    patch < "$PATCH_FILE"
    if [ $? -eq 0 ]; then
        echo "Patch applied successfully."
    else
        echo "Failed to apply patch. Exiting."
        disable_proxy
        exit 1
    fi
}

revert_patch() {
    echo "Reverting patch from $ORIGINAL_FILE..."
    patch -R < "$PATCH_FILE"
    if [ $? -eq 0 ]; then
        echo "Patch reverted successfully."
    else
        echo "Failed to revert patch. Please check manually."
    fi
}

# Main script
enable_proxy
#apply_patch

echo "Starting mitmproxy..."
mitmproxy

echo "mitmproxy exited. Cleaning up..."
#revert_patch
disable_proxy

echo "Done."
