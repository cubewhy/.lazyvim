# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Installation

### Linux

- Make a backup of your current Neovim files:

```shell
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

- Clone the starter

```shell
git clone https://github.com/cubewhy/.lazyvim ~/.config/nvim
```

### Windows (With PowerShell)

- Make a backup of your current Neovim files

```powershell
# required
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak

# optional but recommended
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
```

- Clone the starter

```powershell
git clone https://github.com/cubewhy/.lazyvim $env:LOCALAPPDATA\nvim
```

### Try with Docker

```shell
docker run -w /root -it --rm fedora:latest sh -uelic '
  dnf copr enable -y dejan/lazygit
  dnf install -y git lazygit fd-find curl ripgrep tree-sitter-cli neovim
  git clone https://github.com/cubewhy/.lazyvim ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```
