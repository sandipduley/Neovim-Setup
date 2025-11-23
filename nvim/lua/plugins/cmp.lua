return {
  "hrsh7th/nvim-cmp", -- Main completion engine
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",      -- LSP completions
    "hrsh7th/cmp-buffer",        -- Buffer completions
    "hrsh7th/cmp-path",          -- Path completions
    "hrsh7th/cmp-cmdline",       -- Command line completions
    "L3MON4D3/LuaSnip",          -- Snippet engine
    "saadparwaiz1/cmp_luasnip",  -- Snippet completions
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    ----------------------------------------------------------------
    -- 🔁 Persistent toggle state
    ----------------------------------------------------------------
    local cmp_state_file = vim.fn.stdpath("data") .. "/cmp_toggle_state.txt"
    local cmp_enabled = true

    if vim.fn.filereadable(cmp_state_file) == 1 then
      local state = vim.fn.readfile(cmp_state_file)[1]
      cmp_enabled = (state == "true")
    end

    ----------------------------------------------------------------
    -- ⚙️ Main cmp setup
    ----------------------------------------------------------------
    cmp.setup({
      enabled = function()
        return cmp_enabled
      end,

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        -- Change confirm key to Shift+Enter
        ["<S-CR>"] = cmp.mapping.confirm({ select = true }),

        -- Optional: prevent Enter from confirming
        ["<CR>"] = cmp.mapping(function(fallback)
          fallback() -- just insert newline
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })

    ----------------------------------------------------------------
    -- 🎚️ Toggle autocomplete shortcut
    ----------------------------------------------------------------
    vim.keymap.set("n", "<leader>ta", function()
      cmp_enabled = not cmp_enabled
      vim.fn.writefile({ tostring(cmp_enabled) }, cmp_state_file)
      cmp.setup({
        enabled = function()
          return cmp_enabled
        end,
      })
      print(cmp_enabled and " Autocomplete: ON" or " Autocomplete: OFF")
    end, { desc = "Toggle autocomplete" })
  end,
}


