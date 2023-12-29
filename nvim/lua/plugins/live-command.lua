-- preview for commands (e.g. substitute)
return {
    "smjonas/live-command.nvim",
    config = function()
        require("live-command").setup {
            commands = {
                Norm = { cmd = "norm" },
                LSubvert = { cmd = "Subvert" },
            },
        }
    end
}

