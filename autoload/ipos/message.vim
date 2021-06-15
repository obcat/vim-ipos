" Author:  obcat <obcat@icloud.com>
" License: MIT License


function ipos#message#error(msg) abort
  call s:echomsg(a:msg, 'ErrorMsg')
endfunction


function ipos#message#warning(msg) abort
  call s:echomsg(a:msg, 'WarningMsg')
endfunction


function s:echomsg(msg, hl = 'None') abort
  execute 'echohl' a:hl
  try
    for line in split(a:msg, "\n")
      echomsg line
    endfor
  finally
    echohl None
  endtry
endfunction
