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
        silent call system("start cmd /k runas /user:".un."\\administrator \"chuck --loop\"")
    endif

endfunction

function! ChuckAdd()
    call system("chuck + ". bufname("%"))
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
    call system("chuck = " . in . " " . bufname("%"))
endfunction

function! ChuckKill()
    call system("chuck --kill")
endfunction

nnoremap <buffer> <localleader>r :call ChuckRunBuffer()<cr>
nnoremap <buffer> <localleader>c :call ChuckStartServer()<cr>
nnoremap <buffer> <localleader>+ :call ChuckAdd()<cr>
nnoremap <buffer> <localleader>- :call ChuckRemove()<cr>
nnoremap <buffer> <localleader>= :call ChuckReplace()<cr>
nnoremap <buffer> <localleader>k :call ChuckKill()<cr>
