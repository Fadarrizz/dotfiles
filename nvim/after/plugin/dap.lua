require("mason-nvim-dap").setup({
    automatic_setup = true,
})

require("dapui").setup()

local dap = require('dap')
local ui = require('dapui')

local function dap_start_debugging ()
    dap.continue()
    ui.toggle({})
end

vim.keymap.set("n", "<leader>ds", dap_start_debugging, { desc = 'Dap start' })
vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover, { desc = 'Dap list' })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = 'Dap continue' })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = 'Dap toggle breakpoint' })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = 'Dap step over' })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = 'Dap step into' })
vim.keymap.set("n", "<leader>do", dap.step_out, { desc = 'Dap step out' })

dap.adapters = {
    node2 = {
        type = 'executable',
        command = 'node',
        args = { vim.fn.stdpath("data") .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
    }
}

dap.configurations = {
    javascript = {
        {
            name = 'Launch',
            type = 'node2',
            request = 'launch',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            -- For this to work you need to make sure the node process is started with the `--inspect` flag.
            name = 'Attach to process',
            type = 'node2',
            request = 'attach',
            processId = require'dap.utils'.pick_process,
        },
    }
}
