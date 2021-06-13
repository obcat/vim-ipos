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
        \   'first line',
        \   'second line',
        \ ])
  execute 'normal! ggwixxx '
  call setline(3, ['third line'])
  call g:assert.equals(getline(1, '$'), [
        \   'first xxx line',
        \   'second line',
        \   'third line',
        \ ], '#1')
  execute 'normal ziyyy '
  call g:assert.equals(getline(1, '$'), [
        \   'first yyy xxx line',
        \   'second line',
        \   'third line',
        \ ], '#2')
endfunction


function s:suite.A()
  call setline(1, [
        \   'first line',
        \   'second line',
        \ ])
  normal! ggA xxx
  call setline(3, ['third line'])
  call g:assert.equals(getline(1, '$'), [
        \   'first line xxx',
        \   'second line',
        \   'third line',
        \ ], '#1')
  normal zi yyy
  call g:assert.equals(getline(1, '$'), [
        \   'first line yyy xxx',
        \   'second line',
        \   'third line',
        \ ], '#2')
endfunction


function s:suite.virtualedit()
  set virtualedit=all

  call setline(1, [
        \   'first line',
        \   'second line',
        \ ])
  normal! gg$4lixxx
  call setline(3, ['third line'])
  call g:assert.equals(getline(1, '$'), [
        \   'first line   xxx',
        \   'second line',
        \   'third line',
        \ ], '#1')
  execute 'normal ziyyy '
  call g:assert.equals(getline(1, '$'), [
        \   'first line   yyy xxx',
        \   'second line',
        \   'third line',
        \ ], '#2')

  set virtualedit&
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
  call setline(3, ['third line'])
  call g:assert.equals(getline(1, '$'), [
        \   'first line   xxx',
        \   'second line',
        \   'third line',
        \ ], '#1')
  execute 'normal ziyyy '
  call g:assert.equals(getline(1, '$'), [
        \   'first line   yyy xxx',
        \   'second line',
        \   'third line',
        \ ], '#2')

  set virtualedit&
  set rightleft&
endfunction
