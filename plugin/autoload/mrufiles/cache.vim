" Author: Mark Wu <markplace@gmail.com>
" Description: Cache API for mrufiles.

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:path_separator = has('win32') ? '\' : '/'
let s:mrufiles_cache_directory = get(g:, 'mrufiles_cache_directory', '')

function! mrufiles#cache#directory() abort
    if empty(s:mrufiles_cache_directory)
        if has('nvim')
            let user_cache = stdpath('cache')
        elseif exists('$XDG_CACHE_HOME')
            let user_cache = $XDG_CACHE_HOME
        else
            let user_cache = $HOME . s:path_separator . '.cache'
        endif
        let s:mrufiles_cache_directory = user_cache . s:path_separator . 'mrufiles'
    endif

    if !isdirectory(s:mrufiles_cache_directory)
        call mkdir(s:mrufiles_cache_directory, 'p')
    endif

    return s:mrufiles_cache_directory
endfunction

function! mrufiles#cache#file(fname) abort
    return mrufiles#cache#directory() . s:path_separator . a:fname
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
