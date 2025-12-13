-- Small plugins that don’t need more than ~10 lines of setup
return {
  {
    -- Auto-close HTML tags
    'windwp/nvim-ts-autotag',
  },

  {
    -- Automatically detect and set tab/indent settings (like tabstop, shiftwidth)
    'tpope/vim-sleuth',
  },

  -- {
  --   -- Easy Git commands inside Neovim
  --   'tpope/vim-fugitive',
  -- },

  {
    -- Auto-close brackets, parentheses, quotes, etc.
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },

  {
    -- Highlight TODO, NOTE, FIX, etc. inside comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    -- Show colors for hex codes like #ff00aa directly in the file
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

    -- Add/delete/change surrounding pairs
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }

}

