" trailblazer.vim - Relentless whitespace management
" Maintainer:   Zakhary Kaplan <https://github.com/zakharykaplan>
" Version:      0.1.2
" SPDX-License-Identifier: Vim

" Setup: {{{
if exists("g:loaded_trailblazer")
  finish
endif
let g:loaded_trailblazer = 1
" }}}

" Options: {{{
" Set trailblazer enabled flag
if !exists('g:trailblazer_enabled')
  let g:trailblazer_enabled = 1
endif
" Set patterns to highlight for trailing whitespace
if !exists('g:trailblazer_pattern')
  let g:trailblazer_patterns = {}
  " Highlight all trailing whitespace
  let g:trailblazer_patterns['all']    = '\s\+$'
  " Highlight all, but only highlight after (excluding) the cursor on current line
  let g:trailblazer_patterns['after']  = '\v(.*%#)@!\s+$'
  " Highlight all, but only highlight before (including) the cursor on current line
  let g:trailblazer_patterns['before'] = '\v((.*%#)@!|%#)\s+$'

  " Choose specific pattern to use
  let g:trailblazer_pattern = g:trailblazer_patterns['before']
endif
" Set highlight colours for trailing whitespace
if !exists('g:trailblazer_color')
  let g:trailblazer_colors = {}
  let g:trailblazer_colors['red']     = 'ctermbg=204 guibg=#ff5370'
  let g:trailblazer_colors['green']   = 'ctermbg=115 guibg=#c3e88d'
  let g:trailblazer_colors['yellow']  = 'ctermbg=180 guibg=#ffcb6b'
  let g:trailblazer_colors['blue']    = 'ctermbg=39 guibg=#82b1ff'
  let g:trailblazer_colors['magenta'] = 'ctermbg=170 guibg=#c792ea'
  let g:trailblazer_colors['cyan']    = 'ctermbg=38 guibg=#89ddff'
  let g:trailblazer_colors['grey']    = 'ctermbg=59 guibg=#697098'
  " Choose specific colour to use
  let g:trailblazer_color = g:trailblazer_colors['red']
endif
" }}}

" Autocmds: {{{
augroup Trailblazer
  autocmd!
augroup END
" }}}

" Commands: {{{
command! TrailblazerDisable call trailblazer#disable()
command! TrailblazerEnable call trailblazer#enable()
command! TrailblazerToggle call trailblazer#toggle()
" }}}

" Highlights: {{{
" Set exteral highlight group
execute 'highlight ExtraWhitespace ' . g:trailblazer_color
" Set internal highlight linking group
highlight link TrailblazerWhitespace NONE
" }}}

" Matches: {{{
" Set pattern to highlight for trailing whitespace
autocmd WinEnter * silent! call trailblazer#matchadd()
autocmd VimEnter * silent! call trailblazer#matchadd()
" }}}

" Setup: {{{
call trailblazer#set(g:trailblazer_enabled)
" }}}

" vim:fdl=0:fdm=marker:
