# How to Use BasicSwap on Tails and Whonix: configuration examples

Source: https://monero.love/guides/basicswap-whonix-tails/

The article describes two different environments. Its Whonix Workstation recipe uses Whonix-Gateway for routing and does not enable BasicSwap's own Tor instance. Follow the article's installation and `basicswap-prepare` commands to generate the real configuration, wallet credentials and login password. Do not use a fabricated full basicswap.json.

Files under `debian-host/` are only for the article's separate persistent Debian host accessed from Tails. They are not a Whonix-Gateway recipe. They reflect the article's BasicSwap 0.19.1 interface and port assumptions. Review current release migration guidance before installation.

Set `SWAP_DATADIR` to your absolute data directory. Generate an X25519 client key pair using the Tor instructions, retain the private credential on the client, then run `bash debian-host/prepare-client-auth.bash` to save only the public key on the service host. Run it as the same unprivileged account that runs Tor. It writes an authorization file to the specified data directory and replaces `tails.auth` if present.

Prepare the separate Tor instance using the article's ports 9060, 9061 and 5363. Replace `/home/YOUR_USER/coinswaps/onion` in the fragment with the actual absolute directory and merge it into the generated torrc. Tor does not expand shell variables in configuration. Both HTTP and WebSocket forwarding belong to the same authenticated onion service. Validate the assembled file with `tor --verify-config -f "$SWAP_DATADIR/tor/torrc"`. Verify that Tor loads the authorization file, and that an unauthorized client is refused.

Stop BasicSwap before editing its generated JSON. Replace the hostname placeholder with the generated onion hostname and merge that single URL into the existing `allowed_hosts` list, preserving the other settings. Keep loopback listeners, web-password authentication and inbound firewall restrictions. Do not use a wildcard host or disable origin checks. The JSON fragment is not a replacement for the full application configuration.

No live swap, Whonix routing or Tails browser acceptance test was performed for this bundle.

References: [BasicSwap preparation source at the article version](https://github.com/basicswap/basicswap/blob/v0.19.1/basicswap/bin/prepare.py), [Tor client authorization](https://community.torproject.org/onion-services/advanced/client-auth/).

## Files

- `debian-host/torrc-onion.fragment.conf`
- `debian-host/prepare-client-auth.bash`
- `debian-host/allowed-hosts.fragment.json`

`ARTICLE-EXAMPLES.md` preserves the published code blocks for context. It is a reference, not a script to execute in one pass. `SOURCE.json` identifies the fetched page and packaged file hashes. No services were installed or restarted when preparing this repository.
