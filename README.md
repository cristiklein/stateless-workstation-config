Stateless Workstation Configuration
===================================

[![Lint](https://github.com/cristiklein/stateless-workstation-config/actions/workflows/lint.yaml/badge.svg)](https://github.com/cristiklein/stateless-workstation-config/actions/workflows/lint.yaml)
[![Test](https://github.com/cristiklein/stateless-workstation-config/actions/workflows/test.yaml/badge.svg)](https://github.com/cristiklein/stateless-workstation-config/actions/workflows/test.yaml)

This is how I configure a fresh Ubuntu installation for serving me as a workstation.

Usage
-----
After installing a fresh Ubuntu 24.04:

```
sudo apt install git
git clone https://github.com/cristiklein/stateless-workstation-config.git
cd stateless-workstation-config
./deploy.sh
```

Enjoy!

Development
-----------
To work on a single role:

```
ansible localhost --module-name include_role --args name=cklein.wallpapers
```

Out of scope
------------
To avoid putting credentials in this repo, this script currently doesn't configure:

- Dropbox username and password;
- Chrome username, password and sync passphrase;
- Slack workspaces;
- Wireless networks;
- VPNs;
- Printers.

The following configuration is deemed to volatile, and is out-of-scope for this script:

- Display configuration.
