local kitty_sync_group = vim.api.nvim_create_augroup("KittyColorSync", { clear = true })

vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, {
  group = kitty_sync_group,
  desc = "Restore default kitty colors",
  callback = function(args)
    io.stderr:write("\x1b]21;background\x07")
  end,
})

-- also update kitty's bg on ColorScheme
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume", "ColorScheme" }, {
  group = kitty_sync_group,
  desc = "Set specified highlight groups as transparent",
  callback = function(args)
    local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    local rgb_hex = string.format("#%06x", hl.bg)
    io.stderr:write("\x1b]21;background=" .. rgb_hex .. "\x07")
  end,
})

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
