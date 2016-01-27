" Indenting help a la David Bustos <bustos@caltech.edu> python file
" Language: ChucK
" Author: Danny Clarke
" Date: 1/5/2015

" Only load when no other indent file was loaded.
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

" Preliminary settings
setlocal nolisp
setlocal autoindent

setlocal indentexpr=GetChuckIndent(v:lnum)
setlocal indentkeys+=<:>,=elif,=except

" Only define function once.
if exists("*GetChuckIndent")
    finish
endif
let s:keepcpo= &cpo
set cpo&vim

" Come here when loading script first time

let s:maxoff = 50 " max number of lines to look back for (

function GetChuckIndent(lnum)

    " If this line is explicitly joined: If the previous line was also joined,
    " line it up with that one, otherwise add to 'shiftwidth'
    if getline(a:lnum - 1) =~ '\\$'
        if a:lnum > 1 && getline(a:lnum - 2) =~ '\\$'
            return indent(a:lnum-1)
        endif
        return indent(a:lnum - 1)
    endif

    " If start of the line is in a string don't change indent.
    

    " Search backward for the previous non-empty line.
    let plnum = prevnonblank(v:lnum - 1)

    if plnum == 0
        return 0
    endif

endfunction

