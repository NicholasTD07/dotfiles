augroup swift
  " *.swift is swift
  autocmd! BufNewFile,BufRead *.swift set filetype=swift
  autocmd FileType swift set ai sw=4 sts=4 et
  autocmd FileType swift call SetUpSwift()

  function! SetUpSwift()
    setlocal foldmethod=indent
    setlocal foldlevel=1

    " set up swift compile
    if !empty(glob("./Package.swift"))
      noremap <buffer> <leader>w :wa \| Neomake! swifttest <cr>
    elseif !empty(glob("./*.xcworkspace")) || !empty(glob("./*.xcodeproj"))
    else
      set makeprg=swift\ %
      noremap <buffer> <leader>w :w \| ! swift % <cr>
      noremap <buffer> <leader>t :w \| silent make \| redraw! \| cw 4 <cr>
    endif

    " reset errorformat
    set efm=

    " swift test/build errors
    set efm+=%E%f:%l:%c:\ error:\ %m
    set efm+=%W%f:%l:%c:\ warning:\ %m
    set efm+=%I%f:%l:%c:\ note:\ %m
    set efm+=%f:%l:\ error:\ %m
    set efm+=fatal\ error:\ %m

    " custom codecov errors (zero-hit detection)
    " Example: Ignore zero-hit ending brackets
    " File /path/to/another.swift:104|            }
    set efm+=%-GFile\ %f:%l:\ %#}
    " Example: Detect other zero-hit lines
    " File /path/to/a.swift:56|    func remove(todo: ToDo) -> State {
    set efm+=File\ %f:%l:\ %#%m

    set efm+=%-G%.%#

  endfunction
augroup END
