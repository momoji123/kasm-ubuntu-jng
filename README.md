# kasm-ubuntu-jng

Kasm Ubuntu-focal for Java & Node development in kasm envirnment

## Contents
### basics
- Ubuntu 20.04 Kasm-version
- Java 17
- Node 20.x
- Postgresql 13
- VS Code

### Browsers
- Chrome
- Firefox
- Brave



# Run with persistent environment

1. Setup volume mapping:

{
  "/mnt/kasm_profiles/kasm-ubuntu-jng/etc/{username}/postgresql": {
    "bind": "/etc/postgresql",
    "mode": "rw",
    "uid": 117,
    "gid": 127,
    "required": true,
    "skip_check": false
  },
  "/mnt/kasm_profiles/kasm-ubuntu-jng/var/{username}/postgresql": {
    "bind": "/var/lib/postgresql",
    "mode": "rw",
    "uid": 117,
    "gid": 127,
    "required": true,
    "skip_check": false
  }
}

2. Setup Persistent Profile Path

/mnt/kasm_profiles/kasm-ubuntu-jng/{username}	

Have fun!
