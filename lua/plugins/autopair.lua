return {
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    config = function()
      local function is_lsp_generic_context()
        local curr_win = vim.api.nvim_get_current_win()
        local cursor = vim.api.nvim_win_get_cursor(curr_win)
        local row, col = cursor[1] - 1, cursor[2]
        local line = vim.api.nvim_get_current_line()
        local char_after = line:sub(col + 1, col + 1)

        if char_after == ">" then
          return true
        end

        local prefix = line:sub(1, col)

        if prefix:match("%s$") or prefix:match("%d$") or prefix == "" then
          return false
        end

        local token_type = nil
        local ok, tokens = pcall(vim.lsp.semantic_tokens.get_at_pos, row, col - 1)
        if ok and tokens then
          for _, token in ipairs(tokens) do
            token_type = token.type
            break
          end
        end

        local type_likes = {
          ["type"] = true,
          ["class"] = true,
          ["struct"] = true,
          ["enum"] = true,
          ["interface"] = true,
          ["typeParameter"] = true,
        }
        if token_type and type_likes[token_type] then
          return true
        end

        if token_type == nil or token_type == "unresolvedReference" or token_type == "variable" then
          local last_word = prefix:match("[%w_]+$")
          if last_word then
            if prefix:match(":[%s]*[%w_]+$") or last_word:match("^[A-Z]") then
              return true
            end
          end
        end

        -- Turbofish (size_of::<...>)
        if prefix:match("::[:]*$") then
          return true
        end

        -- Nest (Vec<Vec<T>>)
        if prefix:match("[%>%)%]]$") then
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
          cond = function(fn)
            return is_lsp_generic_context()
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
}
