-- ============================
-- Basic Settings & Leader Keys
-- ============================

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Common keymap options
local opts = { noremap = true, silent = true }

-- Disable spacebar's default action (Normal + Visual mode)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


-- ==============================
-- Better Movement & Navigation
-- ==============================

-- Move smoothly on wrapped lines (gk/gj automatically)
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Clear search highlight
vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)

-- Center screen after moving half page
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Keep search result centered
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')


-- =====================
-- Save / Quit / Editing
-- =====================

-- Save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- Save file without running auto-format
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- Quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- Delete a character without copying it
vim.keymap.set('n', 'x', '"_x', opts)

-- Increase or decrease numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts)
vim.keymap.set('n', '<leader>-', '<C-x>', opts)


-- =================
-- Window Management
-- =================

-- Split windows
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- vertical split
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- horizontal split

-- Make all splits equal size
vim.keymap.set('n', '<leader>se', '<C-w>=', opts)

-- Close split
vim.keymap.set('n', '<leader>sx', ':close<CR>', opts)

-- Move between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)


-- ====================
-- Resize Windows Easily
-- ====================

vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)


-- ==========
-- Buffers
-- ==========

vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)

vim.keymap.set('n', '<C-i>', '<C-i>', opts) -- keep jump forward working
vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer


-- =======
-- Tabs
-- =======

vim.keymap.set('n', '<leader>ot', ':tabnew<CR>', opts) -- new tab
vim.keymap.set('n', '<leader>xt', ':tabclose<CR>', opts) -- close tab
vim.keymap.set('n', '<leader>nt', ':tabn<CR>', opts) -- next tab
vim.keymap.set('n', '<leader>pt', ':tabp<CR>', opts) -- previous tab


-- ======================
-- Misc Quality of Life
-- ======================

-- Toggle line wrap
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Press "jk" or "kj" fast to exit insert mode
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'kj', '<ESC>', opts)

-- Keep indentation active when shifting left/right
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Move selected text up/down
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', opts)

-- Paste without losing clipboard content
vim.keymap.set('v', 'p', '"_dP', opts)

-- Replace word under cursor
vim.keymap.set('n', '<leader>j', '*``cgn', opts)

-- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])


-- ===========================
-- Diagnostics (LSP Warnings)
-- ===========================

-- Toggle diagnostics on/off
local diagnostics_active = true

vim.keymap.set('n', '<leader>do', function()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.enable(true)
  else
    vim.diagnostic.enable(false)
  end
end)

-- Jump between errors/warnings
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

-- Open floating diagnostic popup
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open diagnostic message' })

-- Show list of diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- ========================
-- Save & Load Sessions
-- ========================

-- Save session
vim.keymap.set('n', '<leader>ss', ':mksession! .session.vim<CR>', {
  noremap = true, silent = false
})

-- Load session
vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', {
  noremap = true, silent = false
})

-- =========================
-- Tiny-inline-diagnostics
-- =========================
vim.keymap.set("n", "<leader>ed", "<cmd>TinyInlineDiag enable<cr>", { desc = "Enable diagnostics" })
vim.keymap.set("n", "<leader>dd", "<cmd>TinyInlineDiag disable<cr>", { desc = "Disable diagnostics" })
vim.keymap.set("n", "<leader>td", "<cmd>TinyInlineDiag toggle<cr>", { desc = "Toggle diagnostics" })
