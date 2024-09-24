return {
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'
      require('dap-python').setup 'python'
      require('dapui').setup()

      -- Handled by nvim-dap-go
      -- dap.adapters.go = {
      --   type = "server",
      --   port = "${port}",
      --   executable = {
      --     command = "dlv",
      --     args = { "dap", "-l", "127.0.0.1:${port}" },
      --   },
      -- }

      vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<space>gb', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<space>dc', dap.continue)
      vim.keymap.set('n', '<space>di', dap.step_into)
      vim.keymap.set('n', '<space>do', dap.step_over)
      vim.keymap.set('n', '<space>du', dap.step_out)
      vim.keymap.set('n', '<space>db', dap.step_back)
      vim.keymap.set('n', '<space>dr', dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
