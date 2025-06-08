# Elixir Development Environment With Docker

## How To Start

1. Clone this repo
2. Review build args in `docker-compose.yml`. Match `C_UID` and `C_GID` to host user's uid and gid.
3. `docker compose build`
4. `mkdir -p local code`
5. `docker compose up -d`
6. `docker compose exec devenv bash` to open shell in the development environment.

## Neovim

- Run neovim with `nvim`.
- First time run, Packer will install plugins. Wait for the install process to be finished, then quit with `:qa`.
- Second run, Mason will install language servers. Wait for this to finish, then you're good to go.
- Configuration is at `$HOME/.config/nvim/init.lua`

## tmux

- `tmux` to open tmux session.
- On first run only (or after recreating container): `CTRL+Space` then `Shift+I` to install plugins and reload tmux.
- Bind key is remapped to `CTRL+Space`.
- Seamless pane switching with Neovim with `CTRL+{h,j,k,l}`.

## Notes

- Host's `./code` is mounted to user's `$HOME/code`
- Host's `./local` is mounted to user's `$HOME/.local`
