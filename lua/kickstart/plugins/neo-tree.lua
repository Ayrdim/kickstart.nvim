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
    event_handlers = {
      -- This is causing weird behavior with the preview window
      -- {
      --   event = 'after_render',
      --   handler = function()
      --     local state = require('neo-tree.sources.manager').get_state 'filesystem'
      --     if not require('neo-tree.sources.common.preview').is_active() then
      --       state.config = { use_float = false } -- or whatever your config is
      --       state.commands.toggle_preview(state)
      --     end
      --   end,
      -- },
    },
    window = {
      mappings = {
        ['<cr>'] = 'open_and_close',
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
}
