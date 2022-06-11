# WorkstationSetup

```bash
ssh-keygen -t ed25519 -C "email@domain.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub

// Paste output of above command to https://github.com/settings/ssh/new
ssh -T git@github.com
```

## Ansible
```bash
 ansible-playbook playbooks/ubuntu_setup.yml --tags "<TAG>" --extra-vars "ansible_sudo_pass=<PASS>"
# mind the space, to not show the command in history
```
## TODO
- [x] Install variety
- [x] Increase keyrepeat
- [x] Install tldr
- [x] Install docker-compose
- [x] Install Flutter
