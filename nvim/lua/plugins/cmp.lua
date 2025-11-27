return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets", -- Extra snippets
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    ------------------------------------------------------------------
    -- 🔄 Load VSCode-style snippets (friendly-snippets)
    ------------------------------------------------------------------
    require("luasnip.loaders.from_vscode").lazy_load()

    ------------------------------------------------------------------
    -- 🔁 Persistent toggle state
    ------------------------------------------------------------------
    local cmp_state_file = vim.fn.stdpath("data") .. "/cmp_toggle_state.txt"
    local cmp_enabled = true

    if vim.fn.filereadable(cmp_state_file) == 1 then
      local state = vim.fn.readfile(cmp_state_file)[1]
      cmp_enabled = (state == "true")
    end

    ------------------------------------------------------------------
    -- ⚙️ Main cmp setup
    ------------------------------------------------------------------
    cmp.setup({
      enabled = function()
        return cmp_enabled
      end,

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      ----------------------------------------------------------
      -- 🖼️ Beautiful bordered completion/documentation windows
      ----------------------------------------------------------
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      ----------------------------------------------------------
      -- 🎨 Formatting for clean menus
      ----------------------------------------------------------
      formatting = {
        format = function(entry, item)
          item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip  = "[Snip]",
            buffer   = "[Buf]",
            path     = "[Path]",
          })[entry.source.name]
          return item
        end,
      },

      ----------------------------------------------------------
      -- ⌨️ Key mappings
      ----------------------------------------------------------
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        -- Confirm: Shift + Enter
        ["<S-CR>"] = cmp.mapping.confirm({ select = true }),

        -- Enter = newline (not confirm!)
        ["<CR>"] = cmp.mapping(function(fallback)
          fallback()
        end, { "i", "s" }),

        -- Tab / Shift-Tab for snippet navigation
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end,

        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
      }),

      ----------------------------------------------------------
      -- 🔌 Sources (priority-ordered)
      ----------------------------------------------------------
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })

    ------------------------------------------------------------------
    -- 🎚️ Toggle autocomplete shortcut
    ------------------------------------------------------------------
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

