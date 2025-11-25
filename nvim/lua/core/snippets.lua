-- ============================
-- Custom Tweaks & Improvements
-- ============================

-- Stop LSP from overwriting Treesitter colors
-- (Treesitter uses priority 100, so we set LSP lower)
vim.hl.priorities.semantic_tokens = 95


-- ===================
-- Diagnostic Settings
-- ===================

vim.diagnostic.config {
  virtual_text = {
    prefix = '●', -- small dot icon

    -- Show error codes along with the message
    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },

  underline = false,       -- don't underline text
  update_in_insert = true, -- update diagnostics while typing
  float = { source = true }, -- show source of error in floating window

  -- Icons in the sign column
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN]  = ' ',
      [vim.diagnostic.severity.INFO]  = ' ',
      [vim.diagnostic.severity.HINT]  = '󰌵 ',
    },
  },

  -- Make virtual text background transparent
  on_ready = function()
    vim.cmd 'highlight DiagnosticVirtualText guibg=NONE'
  end,
}


-- ==========================
-- Highlight Text When Yanking
-- ==========================

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank() -- flash highlight after copying
  end,
  group = highlight_group,
  pattern = '*',
})


-- ================================
-- Kitty Terminal Padding Adjustment
-- ================================

-- Remove padding when entering Neovim, restore when leaving
vim.cmd [[
  augroup kitty_mp
    autocmd!
    au VimLeave * :silent !kitty @ set-spacing padding=default margin=default
    au VimEnter * :silent !kitty @ set-spacing padding=0 margin=0 3 0 3
  augroup END
]]

