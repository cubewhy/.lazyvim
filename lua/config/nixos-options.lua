local sqlite_path = os.getenv("LIBSQLITE")
if sqlite_path then
  vim.g.sqlite_clib_path = sqlite_path
end
