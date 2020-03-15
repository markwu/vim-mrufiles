" Author: Mark Wu <markplace@gmail.com>
" Description: FZF provider for mrufiles.

let s:save_cpo = &cpoptions
set cpoptions&vim

function! mrufiles#finder#fzf#open() abort
    let s:mrufiles_finder_fzf_options = {
                \   'source'  : mrufiles#mru#get(),
                \   'sink'    : 'edit',
                \   'options' : '--multi --prompt "MruFiles> "'
                \ }

    call fzf#run(fzf#wrap(s:mrufiles_finder_fzf_options))
endfunction

function! mrufiles#finder#fzf#init() abort
    if exists('g:loaded_fzf') && g:loaded_fzf == 1
        command! -bar -bang FzfMruFiles call mrufiles#finder#fzf#open()
    endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
