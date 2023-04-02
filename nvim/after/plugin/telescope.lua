local builtin = require('telescope.builtin')

local function search_all_files()
    builtin.find_files {
        prompt_title = "Find All Files",
        no_ignore = true,
    }
end

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>fa', search_all_files, { desc = "Find all files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Find in live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffer" })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Find old files" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find help tag" })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = "Resume previous picker" })
vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = "Find recent command" })
vim.keymap.set('n', '<leader>fs', builtin.reloader, { desc = "Find recent search" })

require('telescope').setup {
    defaults = {
        path_display = { truncate = 1 },
        file_ignore_patterns = { '.git/' },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        buffers = {
            previewer = false,
            layout_config = {
                width = 80,
            },
            sort_lastused = true,
        },
        lsp_references = {
            previewer = false,
        },
    },
}
