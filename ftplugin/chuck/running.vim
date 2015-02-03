if !exists("g:chuck_command")
    let g:chuck_command = "chuck"
endif

function! ChuckRunBuffer()
    if has("win32") || has("win16")
        silent !cls
    else
        silent !clear
    endif
    execute "!" . g:chuck_command . " " . bufname("%")
endfunction

function! ChuckStartServer()
    if has("win32unix") && &shell == '/bin/bash'
        " for that massive crowd of cygwin users ;)
        call inputsave()
        let un = input("Windows Username:")
        call inputrestore()
        let cmd = escape("runas /user:".un."\\administrator \"chuck --loop\"", '\')
        silent call system("cmd /c start cmd /c ".cmd)
    endif

    if has("win32") || has("win64") || has("win16")
        " for regular windows
        call inputsave()
        let un = input("Windows Username:")
        call inputrestore()
        let cmd = escape("runas /user:".un."\\administrator \"chuck --loop\"", '\')
        silent call system("start cmd /k runas /user:".cmd)
    endif

endfunction


function! ChuckAdd()
    let path = GetPath()
    let path = path ."/" . bufname("%")
    silent call system("chuck + ". path)
endfunction

function! ChuckRemove()
    call inputsave()
    let in = input("Which Shred?")
    call inputrestore()
    call system("chuck - " . in)
endfunction

function! ChuckReplace()
    call inputsave()
    let in = input("Which Shred?")
    call inputrestore()
    let path = GetPath() . "/" . bufname("%")
    silent call system("chuck = " . in . " " . path)
endfunction

function! ChuckKill()
    call system("chuck --kill")
endfunction

" Get the current buffer path 
" This can be used for giving the vm 'context'
function! GetPath()
    if has("win32unix") || has("win64unix") " Cygwin
        let s:h = getcwd()
        let s:p = system( "cygpath -m " . s:h ) " remove nulls
        let s:p = substitute(s:p, "\n", "", "" )
    elseif has("win32") || has("win64") || has("win16") " reg'lar win
        let s:h = getcwd()
        let s:p = substitute(s:h, "\n", "", "") " remove nulls
    elseif has("unix")
        let s:uname = system("uname")
        if s:uname == "Darwin"
            let s:h = getcwd()
            let s:p = substitute(s:h, "\n", "", "")
        else
            let s:h = getcwd()
            let s:p = substitute(s:h, "\n", "","")
        endif
    endif
    return s:p 
endfunction


nnoremap <buffer> <localleader>r :call ChuckRunBuffer()<cr>
nnoremap <buffer> <localleader>c :call ChuckStartServer()<cr>
nnoremap <buffer> <localleader>+ :call ChuckAdd()<cr>
nnoremap <buffer> <localleader>- :call ChuckRemove()<cr>
nnoremap <buffer> <localleader>= :call ChuckReplace()<cr>
nnoremap <buffer> <localleader>k :call ChuckKill()<cr>
