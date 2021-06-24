" Author:  obcat <obcat@icloud.com>
" License: MIT License


if !exists('g:ipos#mark')
  if exists('g:ipos_mark')
    let g:ipos#mark = deepcopy(g:ipos_mark)
    let s:msg = "[ipos] g:ipos_mark is deprecated, please use g:ipos#mark instead\n"
          \  .. "[ipos] The value of g:ipos_mark has been assigned: let g:ipos#mark = " .. strtrans(string(g:ipos_mark))
    call ipos#message#warning(s:msg)
    unlet s:msg
  else
    let g:ipos#mark = 'i'
  endif
endif


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
"      position where the cursor was when this command was executed.
" }}}
function ipos#startinsert() abort
  try
    call ipos#mark#validate()
  catch /^\[ipos\] /
    call ipos#message#error(v:exception)
    return
  endtry

  let virtualedit = &virtualedit
  set virtualedit=all
  try
    let [bufnum, lnum, col, off] = getpos('''' .. g:ipos#mark)
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
      redraw
      call ipos#message#error('[ipos] Cannot make changes, ''modifiable'' is off')
    endif
  finally
    let &virtualedit = virtualedit
  endtry
endfunction


" NOTE: {{{
" - When an error is encountered the rest of the mapping is not executed.
" - In evaluation of <expr> mapping:
"   * The ":normal" command is blocked.
"   * Moving the cursor is allowed, but it is restored afterwards.
" }}}
