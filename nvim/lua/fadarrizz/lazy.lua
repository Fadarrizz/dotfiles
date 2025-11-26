local lazy = {}

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

lazy.opts = {
    rocks = { enabled = false },
    spec = {
        { import = "fadarrizz.plugins" },
    },
    install = {
        colorscheme = { "catppuccin" },
    },
    performance = {
        rtp = { disabled_plugins = { 'netrwPlugin' } },
    },
    ui = { border = 'rounded', },
    checker = {
        enabled = true,
        notify = false,
    }
}

function lazy.install(path)
    if not (vim.uv or vim.loop).fs_stat(path) then
        local out = vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--branch=stable",
            "https://github.com/folke/lazy.nvim.git",
            path,
        })

        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
              { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
              { out, "WarningMsg" },
              { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
end

function lazy.setup()
    lazy.install(lazy.path)
    
    vim.opt.rtp:prepend(lazy.path)
    
    require("lazy").setup(lazy.opts)
end

lazy.setup()
