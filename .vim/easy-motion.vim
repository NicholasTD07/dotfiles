let g:EasyMotion_smartcase = 1 " turn on case insensitive feature
let g:EasyMotion_do_mapping = 0 " disable default mappings
let g:EasyMotion_use_smartsign_us = 1 " 1 will match 1 and !
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_enter_jump_first = 1

nmap <leader>g <Plug>(easymotion-bd-w)
nmap s <Plug>(easymotion-s2)
map t <Plug>(easymotion-bd-t)
map f <Plug>(easymotion-bd-f2)
omap t <Plug>(easymotion-tl)
omap f <Plug>(easymotion-fl)
vmap t <Plug>(easymotion-tl)
vmap f <Plug>(easymotion-fl)

" jk motions: line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)