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

function! jspretmpl#loadOtherSyntax(filetype)
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

function! jspretmpl#applySyntax(filetype)
  if &ft == 'javascript' || &ft == 'typescript'
    let regexp_start = '`'
    let regexp_skip = '\\`'
    let regexp_end = '`'

    let group_def = 'start="'.regexp_start.'" skip="'.regexp_skip.'" end="'.regexp_end.'"'
  elseif &ft == 'coffee'
    let regexp_start = '"""'
    let regexp_end = '"""'
    let group_def = 'start=+'.regexp_start.'+ end=+'.regexp_end.'+'
  else
    return
  endif

  let group = s:tmplSyntaxGroup(a:filetype)
  let region = s:tmplSyntaxRegion(a:filetype)

  execute 'syntax region '.region.' matchgroup=markdownCodeDelimiter '.group_def.' keepend contains=@'.group
endfunction

function! jspretmpl#loadAndApply(...)
  if a:0 == 0
    return
  endif
  let l:ft = a:1
  call jspretmpl#loadOtherSyntax(l:ft)
  call jspretmpl#applySyntax(l:ft)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
