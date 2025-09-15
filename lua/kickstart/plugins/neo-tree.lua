-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<M-b>', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<CR>'] = 'open_and_close', -- override Enter key
        },
      },
      commands = {
        open_and_close = function(state)
          local node = state.tree:get_node()
          if node.type == 'file' then
            require('neo-tree.sources.filesystem.commands').open(state)
            vim.cmd 'Neotree close' -- close sidebar after opening file
          else
            state.commands['toggle_node'](state)
          end
        end,
      },
    },
  },
}
