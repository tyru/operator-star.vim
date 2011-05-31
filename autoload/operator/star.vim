" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}



function! s:SID()
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
let s:SID_PREFIX = s:SID()
delfunction s:SID

function! operator#star#load()
    " dummy function to load this script.
endfunction

function! operator#star#do(wiseness)
    if maparg('<Plug>(visualstar-*)', 'v', 0) == ''
        echoerr 'operator-star: '
        \       'you must have installed visualstar.vim'
        return
    endif

    let visual_command = s:get_visual_command(a:wiseness)
    execute 'nmap <SID>(reselect)' '`['.visual_command.'`]'
    let reselect = "\<SNR>" . s:SID_PREFIX . "_(reselect)"
    let visualstar = "\<Plug>(visualstar-*)"

    execute 'normal' reselect . visualstar
endfunction

function! s:get_visual_command(wiseness)
    return get({
    \   'char': 'v',
    \   'line': 'V',
    \   'block': "\<C-v>",
    \}, a:wiseness, 'v')
endfunction


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
