local lazy = {}

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

lazy.opts = {
    default = {
        lazy = true,
        version = false,
    },
    install = {
        colorscheme = { "catppuccin" },
    },
    checker = {
        enabled = true,
        notify = false,
    }
}

function lazy.install(path)
    if not vim.loop.fs_stat(path) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            path,
        })
    end
end

function lazy.setup(plugins)
    lazy.install(lazy.path)
    vim.opt.rtp:prepend(lazy.path)

    require("lazy").setup(plugins, lazy.opts)
end

lazy.setup({ import = 'plugins' })
