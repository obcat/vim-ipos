" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License


" NOTE: {{{
" - When an error is encountered the rest of the mapping is not executed.
" - In evaluation of <expr> mapping:
"   * The ":normal" command is blocked.
"   * Moving the cursor is allowed, but it is restored afterwards.
" }}}


" NOTE: {{{
" 1) Mark does not exist.  In this case, start Insert mode at the current
"    cursor position.  This is the same behavior as the "gi" command.
" 2) Do not replace this block with:
"            call setpos('.', [bufnum, lnum, col, off])
"    or the cursor may be moved to undesired position when 'virtualedit' is on.
" 3) No need to consider the 'rightleft' option.
"            execute "normal! \<Right>"`
"    moves the cursor forward even if 'rightleft' is on (this may be a bug of
"    Vim).
" 4) The ":startinsert" command:
"    - Starts Insert mode even if 'modifiable' is off.
"    - Using this command in a function, the insertion starts after the
"      function is finished, but the position to start the insertion is the
"      cursor position when this command was executed.
" }}}
function ipos#startinsert() abort
  let virtualedit = &virtualedit
  set virtualedit=all
  try
    let [bufnum, lnum, col, off] = getpos('''' .. g:ipos_mark)
    if [bufnum, lnum, col, off] == [0, 0, 0, 0]
      " 1)
    else
      " 2)
      call setpos('.', [bufnum, lnum, col, 0])
      if off >= 1
        " 3)
        execute 'normal!' off .. "\<Right>"
      endif
    endif
    if &modifiable
      startinsert " 4)
    else
      let msg = '[ipos] ' .. gettext('E21: Cannot make changes, ''modifiable'' is off')
      call s:echoerr(msg)
    endif
  finally
    let &virtualedit = virtualedit
  endtry
endfunction


function s:echoerr(msg) abort
  echohl ErrorMsg
  echomsg a:msg
  echohl None
endfunction
