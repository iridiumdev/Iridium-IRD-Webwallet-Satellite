#!/usr/bin/env bash

wallet_regex_short=".*-w\ (\S+).*"
wallet_regex_long=".*--container-file[=,\ ](\S+).*"

WALLET=""

if [[ "$@" =~ $wallet_regex_short ]]; then

    WALLET=${BASH_REMATCH[1]}

elif [[ "$@" =~ $wallet_regex_long ]]; then

    WALLET=${BASH_REMATCH[1]}

else
    echo "Please specify a wallet file!"
    exit 1;
fi


if [ ! -f "$WALLET" ]; then
    echo "Wallet $WALLET does not exist. Going to create a new one."
    /iridium/iridium_walletd "$@" -g
    chmod -R 777 "$WALLET"
else
    echo "Wallet $WALLET already present."
fi

echo "Going to launch walletd now..."

/iridium/iridium_walletd "$@"