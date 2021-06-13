" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

if exists('g:loaded_ipos')
  finish
endif
let g:loaded_ipos = v:true


if !exists('g:ipos_mark')
  let g:ipos_mark = 'i'
endif


nnoremap <Plug>(ipos-startinsert) <Cmd>call ipos#startinsert()<CR>


augroup ipos
  autocmd!
  autocmd InsertEnter * call setpos('''' .. g:ipos_mark, getpos('.'))
augroup END
