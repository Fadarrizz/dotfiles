local dap, dapui = require("dap"), require("dapui")
require("nvim-dap-virtual-text").setup()

dapui.setup()

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003,
        pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}"
        }
    }
}

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { vim.fn.stdpath("data") .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
}

dap.configurations.rust = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false
    }
}

dap.adapters.lldb = {
  type = 'executable',
  command = "codelldb", -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

local map = function(lhs, rhs, desc)
  if desc then
    desc = "[DAP] " .. desc
  end

  vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<leader>dl", require("dap.ui.widgets").hover, 'list')
map("<leader>dvo", dapui.open, 'UI open')
map("<leader>dvc", dapui.close, 'UI close')

map("<F1>", dap.step_back, "step_back")
map("<F2>", dap.step_into, "step_into")
map("<F3>", dap.step_over, "step_over")
map("<F4>", dap.step_out, "step_out")
map("<F5>", dap.continue, "continue")

map("<leader>db", dap.toggle_breakpoint, "toggle_breakpoint")
map("<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "[DAP] Condition > ")
end)
map("<leader>dr", dap.repl.open, "open repl")

-- dap.adapters = {
--     node2 = {
--         type = 'executable',
--         command = 'node',
--         args = { vim.fn.stdpath("data") .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
--     }
-- }

-- dap.configurations = {
--     javascript = {
--         {
--             name = 'Launch',
--             type = 'node2',
--             request = 'launch',
--             program = '${file}',
--             cwd = vim.fn.getcwd(),
--             sourceMaps = true,
--             protocol = 'inspector',
--             console = 'integratedTerminal',
--         },
--         {
--             -- For this to work you need to make sure the node process is started with the `--inspect` flag.
--             name = 'Attach to process',
--             type = 'node2',
--             request = 'attach',
--             processId = require'dap.utils'.pick_process,
--         },
--     }
-- }
