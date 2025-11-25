return {
  'nvim-neo-tree/neo-tree.nvim',
  event = 'VeryLazy',
  branch = 'v3.x',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',

    -- Optional: support for showing images inside the preview window
    '3rd/image.nvim',

    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      config = function()
        require('window-picker').setup {
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,

            -- Filter windows based on filetype or buffer type
            bo = {
              -- Ignore these filetypes
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },

              -- Ignore these buffer types
              buftype = { 'terminal', 'quickfix' },
            },
          },
        }
      end,

      -- Keymaps for opening different Neo-tree views
      keys = {
        { '<leader>w', ':Neotree toggle float<CR>',  silent = true, desc = 'Float File Explorer' },
        { '<leader>e', ':Neotree toggle position=left<CR>', silent = true, desc = 'Left File Explorer' },
        { '<leader>ngs', ':Neotree float git_status<CR>', silent = true, desc = 'Git Status Window' },
      },
    },
  },

  config = function()
    require('neo-tree').setup {
      close_if_last_window = false,               -- Do not close Neotree if it's the only window left
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,

      -- Do not replace windows that show these types when opening files
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },

      sort_case_insensitive = false,              -- Case-sensitive file sorting
      sort_function = nil,                        -- No custom sorting function

      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1,                            -- Extra space on the left
          with_markers = true,                    -- Show indent guides
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',

          -- Symbols for expanding/collapsing folders
          with_expanders = nil,
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '󰜌',
          default = '*',                          -- Fallback icon
          highlight = 'NeoTreeFileIcon',
        },
        modified = {
          symbol = '[+]',                          -- Mark modified files
          highlight = 'NeoTreeModified',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
        git_status = {
          symbols = {
            added = '',
            modified = '',
            deleted = '✖',
            renamed = '󰁕',
            untracked = '',
            ignored = '',
            unstaged = '󰄱',
            staged = '',
            conflict = '',
          },
        },

        -- Extra columns (only show when window is wide enough)
        file_size = { enabled = true, required_width = 64 },
        type = { enabled = true, required_width = 122 },
        last_modified = { enabled = true, required_width = 88 },
        created = { enabled = true, required_width = 110 },
        symlink_target = { enabled = false },
      },

      commands = {},                               -- Custom global commands (empty)

      window = {
        position = 'left',
        width = 40,
        mapping_options = { noremap = true, nowait = true },

        -- Navigation and action keys inside Neo-tree
        mappings = {
          ['<space>'] = { 'toggle_node', nowait = false },
          ['<2-LeftMouse>'] = 'open',
          ['<cr>'] = 'open',
          ['<esc>'] = 'cancel',                    -- Close popup or preview
          ['P'] = { 'toggle_preview', config = { use_float = true } },
          ['l'] = 'open',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
          ['w'] = 'open_with_window_picker',
          ['C'] = 'close_node',
          ['z'] = 'close_all_nodes',

          ['a'] = {
            'add',
            config = { show_path = 'none' },
          },

          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy',
          ['m'] = 'move',

          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
          ['i'] = 'show_file_details',
        },
      },

      nesting_rules = {},

      filesystem = {
        filtered_items = {
          visible = false,                     -- If true, hidden items are shown but dimmed
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            '.DS_Store',
            'thumbs.db',
            'node_modules',
            '__pycache__',
            '.virtual_documents',
            '.git',
            '.python-version',
            '.venv',
          },
          hide_by_pattern = {},
          always_show = {},
          never_show = {},
          never_show_by_pattern = {},
        },

        follow_current_file = {
          enabled = false,                    -- Do NOT auto-jump to current file
          leave_dirs_open = false,
        },

        group_empty_dirs = false,
        hijack_netrw_behavior = 'open_default', -- Replace netrw
        use_libuv_file_watcher = false,         -- Do not use OS-level file watchers

        -- File explorer window keymaps
        window = {
          mappings = {
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
            ['H'] = 'toggle_hidden',
            ['/'] = 'fuzzy_finder',
            ['D'] = 'fuzzy_finder_directory',
            ['#'] = 'fuzzy_sorter',
            ['f'] = 'filter_on_submit',
            ['<c-x>'] = 'clear_filter',
            ['[g'] = 'prev_git_modified',
            [']g'] = 'next_git_modified',

            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created' },
            ['od'] = { 'order_by_diagnostics' },
            ['og'] = { 'order_by_git_status' },
            ['om'] = { 'order_by_modified' },
            ['on'] = { 'order_by_name' },
            ['os'] = { 'order_by_size' },
            ['ot'] = { 'order_by_type' },
          },

          fuzzy_finder_mappings = {
            ['<down>'] = 'move_cursor_down',
            ['<C-n>'] = 'move_cursor_down',
            ['<up>'] = 'move_cursor_up',
            ['<C-p>'] = 'move_cursor_up',
          },
        },

        commands = {},
      },

      buffers = {
        follow_current_file = {
          enabled = true,        -- Always move to the current buffer's file
          leave_dirs_open = false,
        },

        group_empty_dirs = true,
        show_unloaded = true,

        window = {
          mappings = {
            ['bd'] = 'buffer_delete',
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',

            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created' },
            ['od'] = { 'order_by_diagnostics' },
            ['om'] = { 'order_by_modified' },
            ['on'] = { 'order_by_name' },
            ['os'] = { 'order_by_size' },
            ['ot'] = { 'order_by_type' },
          },
        },
      },

      git_status = {
        window = {
          position = 'float',

          mappings = {
            ['A'] = 'git_add_all',
            ['gu'] = 'git_unstage_file',
            ['ga'] = 'git_add_file',
            ['gr'] = 'git_revert_file',
            ['gc'] = 'git_commit',
            ['gp'] = 'git_push',
            ['gg'] = 'git_commit_and_push',

            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created' },
            ['od'] = { 'order_by_diagnostics' },
            ['om'] = { 'order_by_modified' },
            ['on'] = { 'order_by_name' },
            ['os'] = { 'order_by_size' },
            ['ot'] = { 'order_by_type' },
          },
        },
      },
    }

    -- Extra keymaps for toggling Neo-tree
    vim.keymap.set('n', '\\', ':Neotree reveal toggle<CR>', { noremap = true, silent = true })
  end,
}

