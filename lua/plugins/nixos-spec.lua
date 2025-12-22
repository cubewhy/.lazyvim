local utils = require("utils")

if not utils.IsNixOS() then
  return {}
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        db = {
          sqlite3_path = vim.g.sqlite_clib_path,
        },
      },
    },
  },
}
