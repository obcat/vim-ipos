let s:suite = themis#suite('startinsert')


function s:suite.before()
  nmap zi <Plug>(ipos-startinsert)
endfunction

function s:suite.after()
  nunmap zi
endfunction


function s:suite.i()
  call setline(1, [
        \   'first line',
        \   'second line',
        \ ])
  execute 'normal! ggwixxx '
  $put = 'third line'
  execute 'normal ziyyy '
  call g:assert.equals(getline(1, '$'), [
        \   'first yyy xxx line',
        \   'second line',
        \   'third line',
        \ ], '#1')

  bwipeout!
endfunction


function s:suite.A()
  call setline(1, [
        \   'first line',
        \   'second line',
        \ ])
  normal! ggA xxx
  $put = 'third line'
  normal zi yyy
  call g:assert.equals(getline(1, '$'), [
        \   'first line yyy xxx',
        \   'second line',
        \   'third line',
        \ ], '#1')

  bwipeout!
endfunction


function s:suite.virtualedit()
  set virtualedit=all

  call setline(1, [
        \   'first line',
        \   'second line',
        \ ])
  normal! gg$4lixxx
  $put = 'third line'
  execute 'normal ziyyy '
  call g:assert.equals(getline(1, '$'), [
        \   'first line   yyy xxx',
        \   'second line',
        \   'third line',
        \ ], '#1')

  set virtualedit&
  bwipeout!
endfunction


function s:suite.virtualedit_x_rightleft() abort
  set virtualedit=all
  set rightleft

  call setline(1, [
        \   'first line',
        \   'second line',
        \ ])
  " NOTE: "normal! l" moves the cursor forward even though rightleft is on
  " (this may be a bug of Vim).
  normal! gg$4lixxx
  $put = 'third line'
  execute 'normal ziyyy '
  call g:assert.equals(getline(1, '$'), [
        \   'first line   yyy xxx',
        \   'second line',
        \   'third line',
        \ ], '#1')

  set virtualedit&
  set rightleft&
  bwipeout!
endfunction
