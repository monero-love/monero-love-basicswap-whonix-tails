# Packaging validation

Checked 2026-11-21T18:16:04.578385+00:00 UTC.

Shell syntax, JSON parsing and Tor 0.4.9.17 verify-config passed with a temporary service directory and networking disabled. Whonix and separate Debian-host instructions remain distinct. No BasicSwap process, client-authentication handshake or trade was tested.

JSON files parsed and Python files passed AST parsing where present. Files were reviewed for credentials, destination assumptions and source fidelity. The files contain examples and placeholders, not production credentials. These checks do not establish end-to-end operation on the target environment.
