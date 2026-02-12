return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          vim.diagnostic.config({ virtual_text = false })
        end,
      })
      require("tiny-inline-diagnostic").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}
