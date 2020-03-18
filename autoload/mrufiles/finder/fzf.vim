" Author: Mark Wu <markplace@gmail.com>
" Description: FZF provider for mrufiles.

let s:save_cpo = &cpoptions
set cpoptions&vim

function! mrufiles#finder#fzf#open() abort
    let preview = fzf#vim#with_preview()
    let fzf_mru_finders = {
                \   'source'  : mrufiles#mru#get(),
                \   'sink'    : 'edit',
                \   'options' : ['--multi', '--prompt', 'MruFiles> '] + preview.options
                \ }

    call fzf#run(fzf#wrap(fzf_mru_finder))
endfunction

function! mrufiles#finder#fzf#init() abort
    if exists('g:loaded_fzf') && g:loaded_fzf == 1
        command! -bar -bang FzfMruFiles call mrufiles#finder#fzf#open()
    endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
