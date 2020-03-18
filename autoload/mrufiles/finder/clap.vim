" Author: Mark Wu <markplace@gmail.com>
" Description: Clap provider for mrufiles.

let s:save_cpo = &cpoptions
set cpoptions&vim

function! mrufiles#finder#clap#preview() abort
    let line = g:clap.display.getcurline()
    call clap#preview#file(g:clap.display.getcurline())
endfunction

function! mrufiles#finder#clap#init() abort
    if exists('g:loaded_clap') && g:loaded_clap == 1
        let g:clap#provider#mrufiles# = {
                    \ 'source': function('mrufiles#mru#get'),
                    \ 'sink': 'edit',
                    \ 'on_move': function('mrufiles#finder#clap#preview')
                    \ }
    endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
