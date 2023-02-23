if exists('b:did_indent')
  finish
endif

" Indent settings
setlocal cindent
setlocal cinoptions=L0,(0,Ws,J1,j1,+N
setlocal cinkeys=0{,0},!^F,o,O,0[,0]
setlocal cinwords=table,set,chain
setlocal autoindent

" Disable lisp-style indenting
setlocal nolisp

" Prevent # from jumping to first column
setlocal indentkeys=0{,0},!^F,o,O,0[,0]

let b:did_indent = 1
