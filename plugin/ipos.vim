" Author:  obcat <obcat@icloud.com>
" License: MIT License

if exists('g:loaded_ipos')
  finish
endif
let g:loaded_ipos = v:true


nnoremap <Plug>(ipos-startinsert) <Cmd>call ipos#startinsert()<CR>


augroup ipos
  autocmd!
  autocmd InsertEnter * call ipos#mark#set()
augroup END
