# Published examples

Source: https://monero.love/guides/basicswap-whonix-tails/

Read the article for the ordering, prerequisites and version limits of these separate examples.

## Block 1

```text
sudo apt update
sudo apt full-upgrade
```

## Block 2

```text
sudo apt install --no-install-recommends \
  git python3-venv libpython3-dev gnupg pkg-config gcc libc-dev curl jq
```

## Block 3

```text
python3 --version
uname -m
df -h "$HOME"
umask 077
export SWAP_DATADIR="$HOME/coinswaps"
mkdir -p "$SWAP_DATADIR"
python3 -m venv "$SWAP_DATADIR/venv"
. "$SWAP_DATADIR/venv/bin/activate"
git clone --branch v0.19.1 --depth 1 \
  https://github.com/basicswap/basicswap.git "$SWAP_DATADIR/basicswap"
cd "$SWAP_DATADIR/basicswap"
git rev-parse HEAD
python3 -m pip install --require-hashes -r requirements.txt
python3 -m pip install .
basicswap-prepare --help
```

## Block 4

```text
read -r -p 'Monero daemon hostname: ' XMR_RPC_HOST
read -r -p 'Monero daemon RPC port: ' XMR_RPC_PORT
export XMR_RPC_HOST XMR_RPC_PORT
read -r -p 'Verified current Monero height for this NEW wallet: ' XMR_HEIGHT
basicswap-prepare --datadir="$SWAP_DATADIR" \
  --withcoins=bitcoin,monero --btc-mode=electrum \
  --xmrrestoreheight="$XMR_HEIGHT" --trustremotenode=false \
  --htmlhost=127.0.0.1 --wshost=127.0.0.1 --client-auth-password
```

## Block 5

```text
basicswap-run --datadir="$SWAP_DATADIR"
```

## Block 6

```text
ip route
cat /etc/resolv.conf
ss -lntp
curl --fail --max-time 60 https://check.torproject.org/api/ip
```

## Block 7

```text
BSX_LOCAL_TOR=true TOR_PROXY_PORT=9060 TOR_CONTROL_PORT=9061 \
  TOR_DNS_PORT=5363 basicswap-prepare --datadir="$SWAP_DATADIR" \
  --enabletor --trustremotenode=false
```

## Block 8

```text
umask 077
mkdir -p "$SWAP_DATADIR/onion/authorized_clients"
read -r -p 'Client X25519 public key, base32: ' BSX_CLIENT_PUBLIC
[[ "$BSX_CLIENT_PUBLIC" =~ ^[A-Z2-7]{52}$ ]] || exit 1
printf 'descriptor:x25519:%s\n' "$BSX_CLIENT_PUBLIC" \
  > "$SWAP_DATADIR/onion/authorized_clients/tails.auth"
chmod 700 "$SWAP_DATADIR/onion" "$SWAP_DATADIR/onion/authorized_clients"
chmod 600 "$SWAP_DATADIR/onion/authorized_clients/tails.auth"
```

## Block 9

```text
HiddenServiceDir /home/YOUR_USER/coinswaps/onion
HiddenServicePort 80 127.0.0.1:12700
HiddenServicePort 11700 127.0.0.1:11700
```

## Block 10

```text
tor --verify-config -f "$SWAP_DATADIR/tor/torrc"
tor -f "$SWAP_DATADIR/tor/torrc"
```
