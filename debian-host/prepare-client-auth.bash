#!/usr/bin/env bash
set -euo pipefail
: "${SWAP_DATADIR:?Set the absolute BasicSwap data directory}"
umask 077
mkdir -p "$SWAP_DATADIR/onion/authorized_clients"
read -r -p 'Client X25519 public key, base32: ' BSX_CLIENT_PUBLIC
[[ "$BSX_CLIENT_PUBLIC" =~ ^[A-Z2-7]{52}$ ]] || exit 1
printf 'descriptor:x25519:%s\n' "$BSX_CLIENT_PUBLIC" \
  > "$SWAP_DATADIR/onion/authorized_clients/tails.auth"
chmod 700 "$SWAP_DATADIR/onion" "$SWAP_DATADIR/onion/authorized_clients"
chmod 600 "$SWAP_DATADIR/onion/authorized_clients/tails.auth"
