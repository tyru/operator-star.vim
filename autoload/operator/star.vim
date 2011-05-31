" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


" Interface {{{

function! operator#star#load()
    " dummy function to load this script.
endfunction


function! operator#star#star(wiseness)
    return s:operator('*', a:wiseness)
endfunction

function! operator#star#gstar(wiseness)
    return s:operator('g*', a:wiseness)
endfunction

function! operator#star#sharp(wiseness)
    return s:operator('#', a:wiseness)
endfunction

function! operator#star#gsharp(wiseness)
    return s:operator('g#', a:wiseness)
endfunction

" }}}

" Implementation {{{

function! s:SID()
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
let s:SID_PREFIX = s:SID()
delfunction s:SID

function! s:operator(command, wiseness)
    let visualstar = '(visualstar-' . a:command . ')'
    if maparg('<Plug>' . visualstar, 'v', 0) == ''
        echoerr 'operator-star:'
        \       'you must have installed visualstar.vim'
        \       '(see :help operator-star-requirements)'
        return
    endif

    let visual_command = s:get_visual_command(a:wiseness)
    execute 'nmap <SID>(reselect)' '`['.visual_command.'`]'
    let reselect = "\<SNR>" . s:SID_PREFIX . "_(reselect)"

    execute 'normal' reselect . "\<Plug>" . visualstar
endfunction

function! s:get_visual_command(wiseness)
    return get({
    \   'char': 'v',
    \   'line': 'V',
    \   'block': "\<C-v>",
    \}, a:wiseness, 'v')
endfunction

" }}}


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
