" Author: Mark Wu <markplace@gmail.com>
" Description: Clap provider for mrufiles.

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:provider = {
\ 'sink': 'edit',
\ 'syntax': 'clap_mrufiles',
\ }

function! s:provider.source() abort
    let files = copy(mrufiles#mru#get())
    let files = map(files, {i, filepath -> fnamemodify(filepath, ':~:.')})
    return files
endfunction

function! s:provider.on_move() abort
    let line = g:clap.display.getcurline()
    call clap#preview#file(g:clap.display.getcurline())
endfunction


function! mrufiles#finder#clap#init() abort
    if exists('g:loaded_clap') && g:loaded_clap == 1
        let g:clap#provider#mrufiles# = s:provider
    endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
