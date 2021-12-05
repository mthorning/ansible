# Ansible Plays to install my env

To test:

```
docker build -t ansible . && docker run -it --rm ansible
```

Add vault password to .vault-pass

When running for real you can supply option to `ansible-playbook --vault-password-file=.vault_pass local.yml`
