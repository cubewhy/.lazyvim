return {
  {
    "abecodes/tabout.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "saghen/blink.cmp", -- also uses tab for completion, so needs to be loaded first
    },
    opts = {
      completion = true,
      tabkey = "",
      backwards_tabkey = "",
    },
    config = function(_, opts)
      local tab = require("tabout")
      tab.setup(opts)

      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if vim.snippet.active({ direction = 1 }) then
          return "<Cmd>lua vim.snippet.jump(1)<CR>"
        end
        return "<Plug>(Tabout)"
      end, { desc = "...", expr = true, silent = true })

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if vim.snippet.active({ direction = -1 }) then
          return "<Cmd>lua vim.snippet.jump(-1)<CR>"
        end
        return "<Plug>(TaboutBack)"
      end, { desc = "...", expr = true, silent = true })
    end,
  },
}
