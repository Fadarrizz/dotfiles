local dap, dapui = require("dap"), require("dapui")

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

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover, { desc = 'Dap list' })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = 'Dap continue' })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = 'Dap toggle breakpoint' })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = 'Dap step over' })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = 'Dap step into' })
vim.keymap.set("n", "<leader>do", dap.step_out, { desc = 'Dap step out' })
vim.keymap.set("n", "<leader>dvo", dapui.open, { desc = 'Dap UI open' })
vim.keymap.set("n", "<leader>dvc", dapui.close, { desc = 'Dap UI close' })

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
