" Author: Mark Wu <markplace@gmail.com>
" Description: FZF provider for mrufiles.

let s:save_cpo = &cpoptions
set cpoptions&vim

function! mrufiles#finder#quickfix#open()
    let s:mrufiles_list = map(mrufiles#mru#get(), {index, value -> {'filename': value, 'valid': 1}})
    call setqflist(s:mrufiles_list)
    copen
    setlocal nolist
endfunction

function! mrufiles#finder#quickfix#init() abort
    command! -bar -bang MRUFiles call mrufiles#finder#quickfix#open()
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
