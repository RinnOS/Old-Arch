#! /usr/bin/env bash

sudo npm i -g typescript-language-server
sudo npm i -g typescript
sudo npm i -g vscode-langservers-extracted
sudo npm i -g bash-language-server
sudo npm i -g svelte-language-server
sudo npm i -g @tailwindcss/language-server
sudo npm i -g yaml-language-server
sudo npm i -g sql-language-server

cargo install --features lsp --locked taplo-cli
