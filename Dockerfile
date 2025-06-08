FROM hexpm/elixir:1.18.4-erlang-26.2.5.11-ubuntu-noble-20250415.1

ARG C_GID=1000
ARG C_GROUP=elixir
ARG C_UID=1000
ARG C_USER=elixir
ARG C_HOMEDIR=/workspace

RUN apt-get update -y \
  && apt-get install -y software-properties-common python3-dev python3-pip \
                    tmux git wget curl fzf ripgrep bat unzip \
  && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN groupadd --gid ${C_GID} ${C_GROUP} \
  && useradd --home-dir ${C_HOMEDIR} --gid ${C_GID} --uid ${C_UID} --shell /usr/bin/bash --create-home ${C_USER}

RUN mkdir -p /opt/neovim \
  && curl -Lo /opt/neovim/nvim.appimage https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage \
  && chmod +x /opt/neovim/nvim.appimage \
  && cd /opt/neovim \
  && /opt/neovim/nvim.appimage --appimage-extract \
  && ln -s /opt/neovim/squashfs-root/AppRun /usr/local/bin/nvim

USER ${C_USER}

RUN mix local.hex --force \
  && mix local.rebar --force \
  && echo "export PATH=$HOME/.mix/elixir/1-18-otp-26:$PATH" >> ~/.bashrc

RUN mkdir -p ${C_HOMEDIR}/.local \
  && mkdir -p ${C_HOMEDIR}/.tmux/plugins \
  && git clone https://github.com/tmux-plugins/tpm ${C_HOMEDIR}/.tmux/plugins/tpm

COPY --chown=${C_USER}:${C_GROUP} ./.home/config ${C_HOMEDIR}/.config

VOLUME ${C_HOMEDIR}/code
VOLUME ${C_HOMEDIR}/.local

WORKDIR ${C_HOMEDIR}/code
