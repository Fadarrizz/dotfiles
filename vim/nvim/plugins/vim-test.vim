let test#strategy = "floaterm"
let test#filename_modifier = ':.'
let test#php#phpunit#executable = './phptest'

nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tv :TestVisit<CR>

" augroup AutoDeleteTestTermBuffers
"     autocmd!
"     autocmd BufLeave term://*artisan\stest* bdelete!
"     autocmd BufLeave term://*phpunit* bdelete!
" augroup END
