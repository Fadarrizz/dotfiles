local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
local fadarrizz_group = augroup('Fadarrizz', {})

autocmd('FileType', {
    group = fadarrizz_group,
    pattern = 'popup',
    callback = function ()
        
    end
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd("RecordingEnter", {
    callback = function(ctx)
        vim.opt.cmdheight = 1
        local msg = string.format("Key:  %s\nFile: %s", vim.fn.reg_recording(), ctx.file)
        vim.notify(msg, vim.log.levels.INFO, {
            title = "Macro Recording"
        })
    end
})

autocmd("RecordingLeave", {
    callback = function()
        vim.opt.cmdheight = 0
    end
})

autocmd("LspAttach", {
    group = fadarrizz_group,
    callback = function(e)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = e.buf, desc = 'LSP: ' .. desc })
        end
        local telescope = require("telescope.builtin")

        map('gd', telescope.lsp_definitions, 'Goto Definition')
        map('gD', telescope.lsp_definitions, 'Goto Declaration')
        map('gr', telescope.lsp_references, 'Goto References')
        map('gi', telescope.lsp_implementations, 'Goto Implementations')
        map('<leader>D', telescope.lsp_type_definitions, 'Type Definitions')
        map('<leader>ds', telescope.lsp_document_symbols, 'Document Symbols')
        map('<leader>ws', telescope.lsp_type_definitions, 'Workspace Symbols')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        map('<leader>f', function() vim.lsp.buf.format { async = true } end, 'Format')

        map('<leader>e', vim.diagnostic.open_float, 'Open Diagnostics')
        map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
        map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
        map('<leader>q', vim.diagnostic.setloclist, 'Set Location List')
    end
})
