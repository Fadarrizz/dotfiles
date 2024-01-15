return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader> ", function() require("harpoon"):list():append() end, desc = 'toggle marking file'},
        { "H", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = 'toggle harpoon menu'},
        { "<C-H>", function() require("harpoon"):list():select(1) end, desc = 'goto file 1'},
        { "<C-J>", function() require("harpoon"):list():select(2) end, desc = 'goto file 2'},
        { "<C-K>", function() require("harpoon"):list():select(3) end, desc = 'goto file 3'},
        { "<C-L>", function() require("harpoon"):list():select(4) end, desc = 'goto file 4'},
    },
    config = function()
        require("harpoon"):setup()
    end
}
