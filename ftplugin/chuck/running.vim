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
    silent !sudo chuck --loop
endfunction

function! ChuckAdd()
    silent !chuck + % 
endfunction

function! ChuckRemove()
    call inputsave()
    let in = input("Which Shred?")
    callinputrestore()
    execute "silent !chuck - " . in
endfunction

function! ChuckReplace()
    call inputsave()
    let in = input("Which Shred?")
    call inputrestore()
    execute "silent !chuck = " . in . " " . bufname("%")
endfunction

function! ChuckKill()
    silent !chuck --kill
endfunction

nnoremap <buffer> <localleader>r :call ChuckRunBuffer()<cr>
nnoremap <buffer> <localleader>c :call ChuckStartServer()<cr>
nnoremap <buffer> <localleader>+ :call ChuckAdd()<cr>
nnoremap <buffer> <localleader>- :call ChuckRemove()<cr>
nnoremap <buffer> <localleader>= :call ChuckReplace()<cr>
nnoremap <buffer> <localleader>k :call ChuckKill()<cr>
