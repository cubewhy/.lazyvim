local sqlite_path = os.getenv("LIBSQLITE")
if sqlite_path then
  vim.g.sqlite_clib_path = sqlite_path
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
      return
    end

    lspconfig.nil_ls.setup({
      settings = {
        ["nil"] = {
          formatting = {
            command = { "alejandra", "--" },
          },
        },
      },
    })
  end,
})
