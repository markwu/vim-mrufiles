" Author: Mark Wu <markplace@gmail.com>
" Description: Initial setup for mrufiles.

augroup MRUFilesSetup
    autocmd!
    autocmd VimEnter * call mrufiles#mru#load()
    autocmd VimEnter * call mrufiles#finder#fzf#init()
    autocmd VimEnter * call mrufiles#finder#clap#init()
    autocmd VimEnter * call mrufiles#finder#quickfix#init()
    autocmd BufEnter,BufLeave,BufWritePost * call mrufiles#mru#save()
    autocmd VimLeavePre * call mrufiles#mru#save()
augroup END
