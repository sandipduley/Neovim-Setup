-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load core configs
require("core.options")
require("core.keymaps")

-- Setup lazy.nvim and import plugins from lua/plugins/
require("lazy").setup({
  spec = {
     { import = "plugins.alpha" },
     { import = "plugins.autocompletion" },
     { import = "plugins.bufferline" },
     { import = "plugins.cmp" },
     { import = "plugins.colorscheme-switcher" },
     { import = "plugins.comments" },
     -- { import = "plugins.debug" },
     { import = "plugins.gitsigns" },
     { import = "plugins.indent-blankline" },
     { import = "plugins.lsp" },
     { import = "plugins.lualine" },
     { import = "plugins.misc" },
  -- { import = "plugins.neotree" },
     { import = "plugins.none-ls" },
     { import = "plugins.telescope" },
     { import = "plugins.tiny-inline-diagnostic" },
     { import = "plugins.treesitter" },
     { import = "plugins.undotree" },
     { import = "plugins.yazi" },
     { import = "plugins.lazygit" },
  },
  change_detection = { notify = false },

  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },

})

 

