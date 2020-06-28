" Disable stuff when entering Goyo
function! s:goyo_enter()
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
    set noshowmode
    set noshowcmd
    set scrolloff=999
    colorscheme delek
    Limelight
endfunction

" Enable stuff and ensure :q quits when Goyo is active
function! s:goyo_leave()
    set showmode
    set showcmd
    set scrolloff=0
    colorscheme rigel
    Limelight!
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
