" trailblazer.vim - Relentless whitespace management
" Maintainer:   Zakhary Kaplan <https://zakharykaplan.ca>
" Version:      0.1.2
" SPDX-License-Identifier: Vim

function! trailblazer#disable()
  " Unset the enable flag
  let g:trailblazer_enabled = 0

  " Unlink whitespace highlighting group
  highlight link TrailblazerWhitespace NONE

  " Delete the autocmd group
  augroup Trailblazer
    autocmd!
  augroup END
endfunction

function! trailblazer#enable()
  " Set the enable flag
  let g:trailblazer_enabled = 1

  " Link whitespace highlighting group
  highlight link TrailblazerWhitespace ExtraWhitespace

  " Set autocmd group
  augroup Trailblazer
    autocmd!

    " Trim trailing whitespace on write
    autocmd BufWritePre * call trailblazer#strip()
  augroup END
endfunction

function! trailblazer#matchadd()
  silent! call matchadd('TrailblazerWhitespace', g:trailblazer_pattern, 0x54)
endfunction

function! trailblazer#set(enabled)
  if a:enabled
    call trailblazer#enable()
  else
    call trailblazer#disable()
  endif
endfunction

function! trailblazer#strip()
  keeppatterns %s/\s\+$//e
endfunction

function! trailblazer#toggle()
  call trailblazer#set(g:trailblazer_enabled ? v:false : v:true)
endfunction

" vim:fdl=0:fdm=indent:
