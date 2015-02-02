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
    "silent !sudo chuck --loop
    call system("cygstart --show --action=runas chuck --loop")
    " for windows, you need to run chuck as admin to prevent crash
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
