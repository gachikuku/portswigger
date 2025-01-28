#!/bin/bash

NETWORK_SERVICE="Wi-Fi"
PROXY_SERVER="127.0.0.1"
PROXY_PORT="8080"

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

# Main script
enable_proxy

echo "Starting mitmproxy..."
mitmproxy

echo "mitmproxy exited. Cleaning up..."
disable_proxy

echo "Done."
