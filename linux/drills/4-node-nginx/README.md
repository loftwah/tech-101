# Node and Nginx Setup Drill

A guide on setting up Node.js with Nginx as a reverse proxy.

## Table of Contents

- [Node and Nginx Setup Drill](#node-and-nginx-setup-drill)
  - [Table of Contents](#table-of-contents)
  - [Nginx Commands](#nginx-commands)
  - [Node Version Manager](#node-version-manager)

## Nginx Commands

Useful Nginx commands for managing your Nginx server:

- Check installed modules:

```bash
nginx -V
```

- Pretty print installed modules:

```bash
2>&1 nginx -V | xargs -n1
```

- Test a configuration without reloading:

```bash
nginx -t
```

- Stop all Nginx processes:

```bash
nginx -s stop
```

- Start all Nginx processes:

```bash
nginx -s start
```

- Restart all Nginx processes:

```bash
nginx -s restart
```

- Reload Nginx configuration (without restarting):

```bash
nginx -s reload
```

## Node Version Manager

Install and use Node Version Manager (NVM) to manage multiple Node.js versions.

1. Install NVM:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

2. Add the following lines to your `~/.zshrc` or other shell configuration file if needed:

```bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

3. Install the latest LTS (Long Term Support) version of Node.js:

```bash
nvm install --lts
```
