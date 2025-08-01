-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

---@module 'lazy'
---@type LazySpec
return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- event = 'VeryLazy',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
  },
  keys = {
    {
      '<F5>',
      function() require('dap').continue() end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function() require('dap').step_into() end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function() require('dap').step_over() end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function() require('dap').step_out() end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>cb',
      function() require('dap').toggle_breakpoint() end,
      desc = 'Code Debug: Toggle Breakpoint',
    },
    {
      '<leader>cB',
      function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      desc = 'Code Debug: Set Breakpoint',
    },
    { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: See last session result.' },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    require('mason-nvim-dap').setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
      },
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup({
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }

    -- local dap_utils = require 'user.plugins.configs.dap.utils'
    local BASH_DEBUG_ADAPTER_BIN = vim.fn.stdpath('data') .. '/mason/packages/bash-debug-adapter/bash-debug-adapter'
    local BASHDB_DIR = vim.fn.stdpath('data') .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir'

    dap.adapters.sh = {
      type = 'executable',
      command = BASH_DEBUG_ADAPTER_BIN,
    }
    dap.configurations.sh = {
      {
        name = 'Launch Bash debugger',
        type = 'sh',
        request = 'launch',
        program = '${file}',
        cwd = '${fileDirname}',
        pathBashdb = BASHDB_DIR .. '/bashdb',
        pathBashdbLib = BASHDB_DIR,
        pathBash = 'bash',
        pathCat = 'cat',
        pathMkfifo = 'mkfifo',
        pathPkill = 'pkill',
        env = {},
        args = {},
        -- showDebugOutput = true,
        -- trace = true,
      },
    }
  end,
}

