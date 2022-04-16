# WorkstationSetup

```bash
ssh-keygen -t ed25519 -C "email@domain.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub

// Paste output of above command to https://github.com/settings/ssh/new
ssh -T git@github.com
```

## TODO
- [x] Install variety
- [x] Increase keyrepeat