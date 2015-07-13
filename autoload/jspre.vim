"============================================================================
" FILE: autoload/jspre.vim
" AUTHOR: Quramy <yosuke.kurami@gmail.com>
"============================================================================

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

"#### TemplateSyntax

function! s:tmplSyntaxGroup(filetype)
  let ft = toupper(a:filetype)
  return 'markdownCodeGroup'.ft
endfunction

function! s:tmplSyntaxRegion(filetype)
  let ft = toupper(a:filetype)
  return 'markdownCodeRegion'.ft
endfunction

function! jspre#loadOtherSyntax(filetype)
  let group = s:tmplSyntaxGroup(a:filetype)

  " syntax save
  if exists('b:current_syntax')
    let s:current_syntax = b:current_syntax
    unlet b:current_syntax
  endif

  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'

  " syntax restore
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif

  return group
endfunction

function! jspre#applySyntax(filetype)
  let group = s:tmplSyntaxGroup(a:filetype)
  let region = s:tmplSyntaxRegion(a:filetype)

  let regexp_start = "`\\s*$"
  let regexp_end = "^\\s*`"

  execute 'syntax region '.region.'
        \ matchgroup=markdownCodeDelimiter
        \ start="'.regexp_start.'" end="'.regexp_end.'"
        \ keepend contains=@'.group
endfunction

function! jspre#loadAndApply(...)
  if a:0 == 0
    return
  endif
  let l:ft = a:1
  call jspre#loadOtherSyntax(l:ft)
  call jspre#applySyntax(l:ft)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
