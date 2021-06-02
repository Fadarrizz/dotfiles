lua require("fadarrizz")

nnoremap <silent> <C-f> :lua require("harpoon.term").sendCommand(1, "tmux2\n"); require("harpoon.term").gotoTerminal(1)<CR>

nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR
