" Set up :make to use fish for syntax checking.
" compiler fish
setlocal comments=:#
setlocal commentstring=#%s
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal formatprg="fish_indent"

autocmd BufWritePost *.fish silent !fish_indent -w %

" Enable folding of block structures in fish.
" setlocal foldmethod=expr
