" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Load Once {{{
if (exists('g:loaded_operator_star') && g:loaded_operator_star) || &cp
    finish
endif
let g:loaded_operator_star = 1
" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


call operator#user#define('star', 'operator#star#do')


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
