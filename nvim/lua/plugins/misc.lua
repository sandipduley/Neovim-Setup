-- Standalone plugins with less than 10 lines of config go here
return {
  {
    -- autoclose tags
    'windwp/nvim-ts-autotag',
  },

  {
    -- detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },

  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
  },

  {
    -- Autoclose parentheses, brackets, quotes, etc.
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },

  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
  'NvChad/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup()
  end,
},

}

