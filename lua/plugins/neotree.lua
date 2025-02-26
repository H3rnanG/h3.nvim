return {
  -- If you want neo-tree's file operations to work with LSP (updating imports, etc.), you can use a plugin like
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim',
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      --{'3rd/image.nvim', opts = {}},
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        config = function()
          require('window-picker').setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', 'quickfix' },
              },
            },
          })
        end,
      },
    },
    config = function()
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

      require('neo-tree').setup({
        close_if_last_window = false,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
        open_files_using_relative_paths = false,
        sort_case_insensitive = false,
        sort_function = nil,
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            highlight = 'NeoTreeIndentMarker',
            with_expanders = nil,
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '󰜌',
            provider = function(icon, node, state)
              if node.type == 'file' or node.type == 'terminal' then
                local success, web_devicons = pcall(require, 'nvim-web-devicons')
                local name = node.type == 'terminal' and 'terminal' or node.name
                if success then
                  local devicon, hl = web_devicons.get_icon(name)
                  icon.text = devicon or icon.text
                  icon.highlight = hl or icon.highlight
                end
              end
            end,
            default = '*',
            highlight = 'NeoTreeFileIcon',
          },
          modified = {
            symbol = '[+]',
            highlight = 'NeoTreeModified',
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = 'NeoTreeFileName',
          },
          git_status = {
            symbols = {
              -- Change type
              added = '', -- or '✚', but this is redundant info if you use git_status_colors on the name
              modified = '', -- or '', but this is redundant info if you use git_status_colors on the name
              deleted = '✖', -- this can only be used in the git_status source
              renamed = '󰁕', -- this can only be used in the git_status source
              -- Status type
              untracked = '',
              ignored = '',
              unstaged = '󰄱',
              staged = '',
              conflict = '',
            },
          },
          file_size = {
            enabled = true,
            width = 12,
            required_width = 64,
          },
          type = {
            enabled = true,
            width = 10,
            required_width = 122,
          },
          last_modified = {
            enabled = true,
            width = 20,
            required_width = 88,
          },
          created = {
            enabled = true,
            width = 20,
            required_width = 110,
          },
          symlink_target = {
            enabled = false,
          },
        },
        commands = {},
        window = {
          position = 'left',
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ['<space>'] = {
              'toggle_node',
              nowait = false,
            },
            ['<2-LeftMouse>'] = 'open',
            ['l'] = 'open',
            ['<esc>'] = 'cancel',
            ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
            ['L'] = 'focus_preview',
            ['S'] = 'open_split',
            ['s'] = 'open_vsplit',
            -- ['S'] = 'split_with_window_picker',
            -- ['s'] = 'vsplit_with_window_picker',
            ['t'] = 'open_tabnew',
            -- ['<cr>'] = 'open_drop',
            -- ['t'] = 'open_tab_drop',
            ['w'] = 'open_with_window_picker',
            ['C'] = 'close_node',
            --['C'] = 'close_all_subnodes',
            ['z'] = 'close_all_nodes',
            ['Z'] = 'expand_all_nodes',
            ['a'] = {
              'add',
              config = {
                show_path = 'none',
              },
            },
            ['A'] = 'add_directory', -- also accepts the optional config.show_path option like 'add'. this also supports BASH style brace expansion.
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['b'] = 'rename_basename',
            ['y'] = 'copy_to_clipboard',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like 'add':
            -- ['c'] = {
              --  'copy',
              --  config = {
                --    show_path = 'none' -- 'none', 'relative', 'absolute'
                --  }
                --}
                ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like 'add'.
                ['q'] = 'close_window',
                ['R'] = 'refresh',
                ['?'] = 'show_help',
                ['<'] = 'prev_source',
                ['>'] = 'next_source',
                ['i'] = 'show_file_details',
                -- ['i'] = {
                  --   'show_file_details',
                  --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
                  --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
                  --   -- config = {
                    --   --   created_format = '%Y-%m-%d %I:%M %p',
                    --   --   modified_format = 'relative', -- equivalent to the line below
                    --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
                    --   -- }
                    -- },
                  },
                },
                nesting_rules = {},
                filesystem = {
                  filtered_items = {
                    visible = false, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_hidden = true, -- only works on Windows for hidden files/directories
                    hide_by_name = {
                      --'node_modules'
                    },
                    hide_by_pattern = { -- uses glob style patterns
                      --'*.meta',
                      --'*/src/*/tsconfig.json',
                    },
                    always_show = { -- remains visible even if other settings would normally hide it
                      --'.gitignored',
                    },
                    always_show_by_pattern = { -- uses glob style patterns
                      --'.env*',
                    },
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                      --'.DS_Store',
                      --'thumbs.db'
                    },
                    never_show_by_pattern = { -- uses glob style patterns
                      --'.null-ls_*',
                    },
                  },
                  follow_current_file = {
                    enabled = false, -- This will find and focus the file in the active buffer every time
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                  },
                  group_empty_dirs = false, -- when true, empty folders will be grouped together
                  hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
                  use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                  window = {
                    mappings = {
                      ['<bs>'] = 'navigate_up',
                      ['.'] = 'set_root',
                      ['H'] = 'toggle_hidden',
                      ['/'] = 'fuzzy_finder',
                      ['D'] = 'fuzzy_finder_directory',
                      ['#'] = 'fuzzy_sorter',
                      -- ['D'] = 'fuzzy_sorter_directory',
                      ['f'] = 'filter_on_submit',
                      ['<c-x>'] = 'clear_filter',
                      ['[g'] = 'prev_git_modified',
                      [']g'] = 'next_git_modified',
                      ['o'] = {
                        'show_help',
                        nowait = false,
                        config = { title = 'Order by', prefix_key = 'o' },
                      },
                      ['oc'] = { 'order_by_created', nowait = false },
                      ['od'] = { 'order_by_diagnostics', nowait = false },
                      ['og'] = { 'order_by_git_status', nowait = false },
                      ['om'] = { 'order_by_modified', nowait = false },
                      ['on'] = { 'order_by_name', nowait = false },
                      ['os'] = { 'order_by_size', nowait = false },
                      ['ot'] = { 'order_by_type', nowait = false },
                    },
                    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                      ['<down>'] = 'move_cursor_down',
                      ['<C-n>'] = 'move_cursor_down',
                      ['<up>'] = 'move_cursor_up',
                      ['<C-p>'] = 'move_cursor_up',
                      ['<esc>'] = 'close',
                    },
                  },

                  commands = {},
                },
                buffers = {
                  follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                  },
                  group_empty_dirs = true,
                  show_unloaded = true,
                  window = {
                    mappings = {
                      ['d'] = 'buffer_delete',
                      ['bd'] = 'buffer_delete',
                      ['<bs>'] = 'navigate_up',
                      ['.'] = 'set_root',
                      ['o'] = {
                        'show_help',
                        nowait = false,
                        config = { title = 'Order by', prefix_key = 'o' },
                      },
                      ['oc'] = { 'order_by_created', nowait = false },
                      ['od'] = { 'order_by_diagnostics', nowait = false },
                      ['om'] = { 'order_by_modified', nowait = false },
                      ['on'] = { 'order_by_name', nowait = false },
                      ['os'] = { 'order_by_size', nowait = false },
                      ['ot'] = { 'order_by_type', nowait = false },
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
                      ['o'] = {
                        'show_help',
                        nowait = false,
                        config = { title = 'Order by', prefix_key = 'o' },
                      },
                      ['oc'] = { 'order_by_created', nowait = false },
                      ['od'] = { 'order_by_diagnostics', nowait = false },
                      ['om'] = { 'order_by_modified', nowait = false },
                      ['on'] = { 'order_by_name', nowait = false },
                      ['os'] = { 'order_by_size', nowait = false },
                      ['ot'] = { 'order_by_type', nowait = false },
                    },
                  },
                },
              })
            end,
            keys = {
              {
                '<leader>ee',
                mode = 'n',
                ':Neotree focus<cr>'
              },
              {
                '<leader>eb',
                mode = 'n',
                ':Neotree buffers<cr>'
              },
              {
                '<leader>et',
                mode = 'n',
                ':Neotree toggle<cr>'
              },
              {
                '<leader>ef',
                mode = 'n',
                ':Neotree position=current<cr>'
              },
            }
          },
        }
