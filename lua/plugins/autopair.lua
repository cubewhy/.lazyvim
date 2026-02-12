return {
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    config = function()
      local function is_generic(o)
        local line = o.line
        local col = o.col
        local prefix = line:sub(1, col)

        if prefix:match("%s$") or prefix:match("%d$") or prefix == "" then
          return false
        end

        local row = vim.api.nvim_win_get_cursor(0)[1] - 1
        local ok, tokens = pcall(vim.lsp.semantic_tokens.get_at_pos, row, math.max(0, col - 1))

        if ok and tokens then
          local type_likes = {
            ["type"] = true,
            ["class"] = true,
            ["struct"] = true,
            ["enum"] = true,
            ["interface"] = true,
            ["typeParameter"] = true,
          }
          for _, token in ipairs(tokens) do
            if type_likes[token.type] then
              return true
            end
          end
        end

        if prefix:match("::[:]*$") or prefix:match("[%>%)%]]$") then
          return true
        end
        local last_word = prefix:match("[%w_]+$")
        if last_word and (prefix:match(":[%s]*[%w_]+$") or last_word:match("^[A-Z]")) then
          return true
        end

        return false
      end

      local ua = require("ultimate-autopair")

      ua.setup({
        {
          "<",
          ">",
          fly = true,
          dosuround = true,
          multiline = false,
          bs = true,
          cond = function(fns, o, m)
            local char_after = o.line:sub(o.col + 1, o.col + 1)

            if char_after == ">" then
              return true
            end

            if fns.is_start_pair() then
              return is_generic(o)
            end

            return true
          end,
          space = true,
          surround = true,
        },
      })
    end,
  },
  {
    "nvim-mini/mini.pairs",
    enabled = false,
  },
  { "RRethy/nvim-treesitter-endwise" },
}
