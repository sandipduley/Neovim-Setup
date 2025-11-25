return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'moll/vim-bbye',              -- lets you close buffers without closing the window
    'nvim-tree/nvim-web-devicons', -- icons for file types
  },

  config = function()
    -- vim.opt.linespace = 8

    require('bufferline').setup {
      options = {
        mode = 'buffers', -- use buffers instead of tabs
        themable = true, -- allows themes to override highlight groups
        numbers = 'none', -- how buffer numbers should be shown
        close_command = 'Bdelete! %d', -- what happens when you close a buffer
        right_mouse_command = 'Bdelete! %d', -- close buffer with right-click
        left_mouse_command = 'buffer %d', -- switch buffer with left-click
        middle_mouse_command = nil, -- do nothing on middle-click

        -- buffer_close_icon = '󰅖',
        buffer_close_icon = '✗', -- icon shown for closing a buffer
        -- buffer_close_icon = '✕',
        close_icon = '', -- icon for the main close button

        path_components = 1, -- only show the file name (no full path)
        modified_icon = '●', -- icon for modified buffers
        left_trunc_marker = '',
        right_trunc_marker = '',

        max_name_length = 30,
        max_prefix_length = 30, -- used when buffer names repeat
        tab_size = 21,

        diagnostics = false, -- disable LSP diagnostic icons on bufferline
        diagnostics_update_in_insert = false, -- do not update diagnostics while typing

        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        persist_buffer_sort = true, -- keep buffer sorting even after restart

        separator_style = { '│', '│' }, -- style of separators between buffers
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        show_tab_indicators = false,

        indicator = {
          -- icon = '▎', -- only used if style is 'icon'
          style = 'none', -- options: 'icon', 'underline', 'none'
        },

        icon_pinned = '󰐃', -- icon for pinned buffers

        minimum_padding = 1,
        maximum_padding = 5,
        maximum_length = 15,

        sort_by = 'insert_at_end', -- new buffers go to the end of the list
      },

      highlights = {
        separator = {
          fg = '#434C5E', -- separator color
        },
        buffer_selected = {
          bold = true,    -- selected buffer is bold
          italic = false, -- no italics for selected buffer
        },
        -- Other highlight groups can be added here if needed
      },
    }

    -- Keymaps (disabled for now, uncomment if needed)
    local opts = { noremap = true, silent = true, desc = 'Go to Buffer' }

    -- vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
    -- vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
    -- vim.keymap.set('n', '<leader>1', "<cmd>lua require('bufferline').go_to_buffer(1)<CR>", opts)
    -- vim.keymap.set('n', '<leader>2', "<cmd>lua require('bufferline').go_to_buffer(2)<CR>", opts)
    -- vim.keymap.set('n', '<leader>3', "<cmd>lua require('bufferline').go_to_buffer(3)<CR>", opts)
    -- vim.keymap.set('n', '<leader>4', "<cmd>lua require('bufferline').go_to_buffer(4)<CR>", opts)
    -- vim.keymap.set('n', '<leader>5', "<cmd>lua require('bufferline').go_to_buffer(5)<CR>", opts)
    -- vim.keymap.set('n', '<leader>6', "<cmd>lua require('bufferline').go_to_buffer(6)<CR>", opts)
    -- vim.keymap.set('n', '<leader>7', "<cmd>lua require('bufferline').go_to_buffer(7)<CR>", opts)
    -- vim.keymap.set('n', '<leader>8', "<cmd>lua require('bufferline').go_to_buffer(8)<CR>", opts)
    -- vim.keymap.set('n', '<leader>9', "<cmd>lua require('bufferline').go_to_buffer(9)<CR>", opts)
  end,
}

