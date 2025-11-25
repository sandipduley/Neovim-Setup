-- Fuzzy Finder (search files, LSP symbols, git items, etc.)
return {
  'nvim-telescope/telescope.nvim',
  -- branch = '0.1.x',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',

    -- Fast fuzzy search engine for Telescope.
    -- Only loads if your system has `make`. Build tools must be installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

    -- Use Telescope-style menus for vim.ui.select()
    'nvim-telescope/telescope-ui-select.nvim',

    -- Icons for files (used in Telescope UI)
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local actions = require 'telescope.actions'
    local builtin = require 'telescope.builtin'

    require('telescope').setup {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'bottom',
            preview_width = 0.6,
            width = { padding = 0 },
            height = { padding = 0 },
          },
        },

        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- go to previous result
            ['<C-j>'] = actions.move_selection_next, -- go to next result
            ['<C-l>'] = actions.select_default, -- open selected file
          },
          n = {
            ['q'] = actions.close, -- quit telescope
          },
        },
      },

      pickers = {
        find_files = {
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
          hidden = true,
        },

        buffers = {
          initial_mode = 'normal',
          sort_lastused = true,
          -- sort_mru = true,
          mappings = {
            n = {
              ['d'] = actions.delete_buffer, -- delete buffer from list
              ['l'] = actions.select_default, -- open buffer
            },
          },
        },

        marks = {
          initial_mode = 'normal',
        },

        oldfiles = {
          initial_mode = 'normal',
        },
      },

      live_grep = {
        file_ignore_patterns = { 'node_modules', '.git', '.venv' },
        additional_args = function(_)
          return { '--hidden' } -- search hidden files too
        end,
      },

      path_display = {
        filename_first = {
          reverse_directories = true,
        },
      },

      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },

      git_files = {
        previewer = false,
      },
    }

    -- Enable fzf extension if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- Keymaps for telescope functions
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
    vim.keymap.set('n', '<leader><tab>', builtin.buffers, { desc = '[S]earch [B]uffers' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find Buffers' })

    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })

    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Search [G]it [C]ommits' })
    vim.keymap.set('n', '<leader>gcf', builtin.git_bcommits, { desc = 'Search commits for current file' })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Search [G]it [B]ranches' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Search [G]it [S]tatus (diff view)' })

    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = 'Search Recent Files' })

    vim.keymap.set('n', '<leader>sds', function()
      builtin.lsp_document_symbols {
        symbols = {
          'Class',
          'Function',
          'Method',
          'Constructor',
          'Interface',
          'Module',
          'Property',
        },
      }
    end, { desc = '[S]earch LSP [S]ymbols' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = 'Search in open files' })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, { desc = 'Fuzzy search in current buffer' })
  end,
}

