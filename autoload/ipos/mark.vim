" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License


" set g:ipos#mark at cursor position
function ipos#mark#set() abort
  try
    call ipos#mark#validate()
  catch /^\[ipos\] /
    call ipos#message#error(v:exception)
    return
  endtry

  call setpos('''' .. g:ipos#mark, getpos('.'))
endfunction


" validate g:ipos#mark
function ipos#mark#validate() abort
  if type(g:ipos#mark) == v:t_string && g:ipos#mark =~# '^[a-z]$'
    " ok
  else
    throw '[ipos] g:ipos#mark must be a lowercase letter, but specified value is ' .. strtrans(string(g:ipos#mark))
  endif
endfunction
