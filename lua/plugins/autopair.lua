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
  {
    "RRethy/nvim-treesitter-endwise",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup({
        whitespace = {
          remove_blankline_trail = false,
        },
        scope = { highlight = highlight },
      })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
  },
}
