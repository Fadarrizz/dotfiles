let g:phpactorOmniError = v:true
autocmd FileType php setlocal omnifunc=phpactor#Complete

" Automatic namespace insert
nnoremap <buffer><leader>u :call phpactor#UserAdd()<CR>

nnoremap <buffer><leader>rmc :call phpactor#MoveFile()<CR>
nnoremap <buffer><leader>rcc :call phpactor#CopyFile()<CR>

nnoremap <buffer><leader>rmr :call phpactor#FindReferences()<CR>

map <buffer><leader>] :call phpactor#GotoDefinition()<CR>
