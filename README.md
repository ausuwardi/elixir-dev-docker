Elixir Development Environment With Docker
==========================================

Steps:

1. Clone this repo
2. Review build args in `docker-compose.yml`. Match `C_UID` and `C_GID` to host user's uid and gid.
3. `docker compose build`
4. `docker compose up -d`
5. `docker compose exec devenv bash` to open shell in the development environment

Tmux:

- `tmux` to open tmux session
- On first run only (or after recreating container): `CTRL+Space` then `Shift+I` to install plugins and reload tmux.
- Bind key is remapped to `CTRL+Space`
- Seamless pane switching with Neovim with `CTRL+{h,j,k,l}`

Notes:

- Host's `./code` is mounted to user's `$HOME/code`
- Host's `./local` is mounted to user's `$HOME/.local`
