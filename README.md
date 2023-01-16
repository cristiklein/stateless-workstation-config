Stateless Workstation Configuration
===================================

This is how I configure a fresh Ubuntu installation for serving me as a workstation.

Usage
-----
After installing a fresh Ubuntu 22.04:

```
sudo apt install git
git clone https://github.com/cristiklein/stateless-workstation-config.git
cd stateless-workstation-config
./deploy.sh
```

Usage on Ubuntu for Windows
---------------------------
```
sudo apt install git
git clone https://github.com/cristiklein/stateless-workstation-config.git
cd stateless-workstation-config
./deploy.sh --skip-tags snap,systemd
```

Enjoy!
