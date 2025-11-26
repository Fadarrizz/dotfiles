return {
    "akinsho/toggleterm.nvim",
    version = '*',
    opts = {
        open_mapping = '<leader>tt',
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        direction = 'float',
        float_opts = {
            border = 'rounded',
            width = function()
                return math.ceil(vim.api.nvim_get_option("columns") * .8)
            end,
            height = function()
                return math.ceil(vim.api.nvim_get_option("lines") * .8 - 4)
            end
        },
        winbar = {
            enabled = true,
        },
    },
    config = function()
        -- necessary for keeping terminals alive upon closing
        vim.opt.hidden = true

        -- local Terminal = require('toggleterm.terminal').Terminal

        -- Default
        -- local floating = Terminal:new({ cmd = "zsh", hidden = true, direction = 'float' })
        -- local floating2 = Terminal:new({ cmd = "zsh", hidden = true, direction = 'float' })

        -- vim.keymap.set({ "n", "t" }, "<leader>tt", function() floating:toggle() end, {
        --     noremap = true,
        --     silent = true,
        --     desc = "Toggle main term",
        -- })

        -- vim.keymap.set({ "n", "t" }, "<leader>t2", function() floating2:toggle() end, {
        --     noremap = true,
        --     silent = true,
        --     desc = "Toggle 2nd term",
        -- })
    end
}
