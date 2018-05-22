#!/usr/bin/env bash

wallet_regex=".*-w\ (\S+).*|.*--container-file=(\S+).*"

if [[ "$@" =~ $wallet_regex ]]; then
    WALLET=${BASH_REMATCH[1]}

    if [ ! -f "$WALLET" ]; then
        echo "Wallet $WALLET does not exist. Going to create a new one."
        /iridium/iridium_walletd "$@" -g
        chmod -R 777 "$WALLET"
    else
        echo "Wallet $WALLET already present."
    fi

    echo "Going to launch walletd now..."

    /iridium/iridium_walletd "$@"



else
    echo "Please specify a wallet file!"
    exit 1;
fi
