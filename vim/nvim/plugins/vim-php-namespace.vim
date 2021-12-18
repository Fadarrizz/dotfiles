function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
"autocmd FileType php inoremap <Leader>m <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>m :call PhpInsertUse()<CR>
