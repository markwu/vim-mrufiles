" Author: Mark Wu <markplace@gmail.com>
" Description: MRU API for mrufiles.

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:mrufiles_max_files = get(g:, 'mrufiles_max_files', 100)
let s:mrufiles_exclude_filetypes = ['fugitive', 'git', 'gitcommit', 'gitrebase', 'gitblame']
let s:mrufiles_cache_file = mrufiles#cache#file('mrufiles.txt')

function! mrufiles#mru#import_oldfiles() abort
    let oldfiles = filter(v:oldfiles, 'filereadable(v:val)')
    return oldfiles
endfunction

function! mrufiles#mru#load() abort
    let s:mrufiles_list = []
    if filereadable(s:mrufiles_cache_file)
        let s:mrufiles_list = readfile(s:mrufiles_cache_file)
        call filter(s:mrufiles_list, 'filereadable(v:val)')
    else
        let s:mrufiles_list = mrufiles#mru#import_oldfiles()
        silent! call writefile(s:mrufiles_list, s:mrufiles_cache_file)
    endif
endfunction

function! mrufiles#mru#save() abort
    call mrufiles#mru#load()

    let bufnr = bufnr('%')
    let bufname = expand('%:p')
    let buftype = getbufvar(bufnr, '&buftype')
    let filetype = getbufvar(bufnr, '&filetype')
    if index(s:mrufiles_exclude_filetypes, filetype) == -1
                \ && !empty(bufname)
                \ && filereadable(bufname)
                \ && empty(buftype)
        call filter(s:mrufiles_list, 'v:val != bufname')
        call insert(s:mrufiles_list, bufname)

        if len(s:mrufiles_list) > s:mrufiles_max_files
            call remove(s:mrufiles_list, s:mrufiles_max_files, -1)
        endif

        silent! call writefile(s:mrufiles_list, s:mrufiles_cache_file)
    endif
endfunction

function! mrufiles#mru#get() abort
    return s:mrufiles_list
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
