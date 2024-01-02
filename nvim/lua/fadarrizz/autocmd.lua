local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function ()
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
