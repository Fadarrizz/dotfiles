" ---------- ALE SETTINGS ---------- "

let g:ale_sign_error = '!!'
let g:ale_sign_style_error = '!!'
let g:ale_sign_warning = '!'
let g:ale_sign_style_warnign = '!'

" ---------- LINTERS ---------- "

let g:ale_linters = {
    \ 'php': ['php', 'phpcs', 'phpmd'],
  \ }

let g:ale_php_phpcs_standard = 'PSR2'

" ---------- FIXERS ---------- "

let g:ale_fixers = {
    \ 'php': ['php_cs_fixer'],
  \ }

augroup fix_on_save
    autocmd! *
    autocmd BufEnter *.php call s:fix_php()
augroup END

function! s:fix_php()
    if filereadable('.php_cs.dist')
        let b:ale_fix_on_save = 1
    endif
endfunction
