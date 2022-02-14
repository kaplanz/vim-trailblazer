" trailblazer.vim - Relentless whitespace management
" Maintainer:   Zakhary Kaplan <https://zakhary.dev>
" Version:      0.1.3
" SPDX-License-Identifier: Vim

" Disable trailblazer
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

" Enable trailblazer
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

" Add matches for trailblazer patterns
function! trailblazer#matchadd()
  silent! call matchadd('TrailblazerWhitespace', g:trailblazer_pattern, 0x54)
endfunction

" Set trailblazer to enabled or disabled
function! trailblazer#set(enabled)
  if a:enabled
    call trailblazer#enable()
  else
    call trailblazer#disable()
  endif
endfunction

" Strip trailing whitespace
function! trailblazer#strip()
  keeppatterns %s/\s\+$//e
endfunction

" Toggle trailblazer
function! trailblazer#toggle()
  call trailblazer#set(g:trailblazer_enabled ? v:false : v:true)
endfunction

" vim:fdl=0:fdm=indent:
