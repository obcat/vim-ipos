let s:suite = themis#suite('startinsert')


function s:suite.before()
  nmap zi <Plug>(ipos-startinsert)
endfunction

function s:suite.before_each() abort
  % delete
  set virtualedit&
  set rightleft&
endfunction

function s:suite.after()
  call s:suite.before_each()
  nunmap zi
endfunction


function s:suite.i()
  call setline(1, [
        \   'line 1',
        \   'line 2',
        \ ])
  execute 'normal! gg$ixxx '
  call setline(3, ['line 3'])
  call g:assert.equals(getline(1, '$'), [
        \   'line xxx 1',
        \   'line 2',
        \   'line 3',
        \ ], '#1')
  execute 'normal ziyyy '
  call g:assert.equals(getline(1, '$'), [
        \   'line yyy xxx 1',
        \   'line 2',
        \   'line 3',
        \ ], '#2')
endfunction


function s:suite.A()
  call setline(1, [
        \   'line 1',
        \   'line 2',
        \ ])
  normal! ggA
  call setline(3, ['line 3'])
  call g:assert.equals(getline(1, '$'), [
        \   'line 1',
        \   'line 2',
        \   'line 3',
        \ ], '#1')
  normal zi yyy
  call g:assert.equals(getline(1, '$'), [
        \   'line 1 yyy',
        \   'line 2',
        \   'line 3',
        \ ], '#2')
endfunction


function s:suite.virtualedit()
  set virtualedit=all

  call setline(1, [
        \   'line 1',
        \   'line 2',
        \ ])
  normal! gg$4lixxx
  call setline(3, ['line 3'])
  call g:assert.equals(getline(1, '$'), [
        \   'line 1   xxx',
        \   'line 2',
        \   'line 3',
        \ ], '#1')
  execute 'normal ziyyy '
  call g:assert.equals(getline(1, '$'), [
        \   'line 1   yyy xxx',
        \   'line 2',
        \   'line 3',
        \ ], '#2')

  set virtualedit&
endfunction


function s:suite.virtualedit_x_rightleft() abort
  set virtualedit=all
  set rightleft

  call setline(1, [
        \   'line 1',
        \   'line 2',
        \ ])
  " NOTE: "normal! l" moves the cursor forward even though rightleft is on
  " (this may be a bug of Vim).
  normal! gg$4lixxx
  call setline(3, ['line 3'])
  call g:assert.equals(getline(1, '$'), [
        \   'line 1   xxx',
        \   'line 2',
        \   'line 3',
        \ ], '#1')
  execute 'normal ziyyy '
  call g:assert.equals(getline(1, '$'), [
        \   'line 1   yyy xxx',
        \   'line 2',
        \   'line 3',
        \ ], '#2')

  set virtualedit&
  set rightleft&
endfunction
