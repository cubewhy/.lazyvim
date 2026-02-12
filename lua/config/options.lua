-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
  -- vim.o.guifont = "JetBrainsMono Nerd Font,Noto Color Emoji:h13"
  vim.g.neovide_floating_blur = false
  vim.g.neovide_floating_blur_amount_x = 0
  vim.g.neovide_floating_blur_amount_y = 0
  -- vim.g.neovide_refresh_rate_idle = 5
  -- vim.g.neovide_refresh_rate = 60
  -- vim.g.neovide_cursor_animation_length = 0
  -- vim.g.neovide_profiler = true
  -- vim.o.winbl = 30
  -- vim.g.neovide_window_blurred = true
  -- vim.g.neovide_opacity = 0.8
  -- vim.g.neovide_normal_opacity = 0.8
end

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.snacks_animate = false
vim.g.lazyvim_blink_main = false
vim.opt.termguicolors = true

-- nixos start
local sqlite_path = os.getenv("LIBSQLITE")
if sqlite_path then
  vim.g.sqlite_clib_path = sqlite_path
end
-- nixos end
