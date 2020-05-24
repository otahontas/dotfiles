" Disable polyglot stuff, reasons:
" - Polyglot is packed with Latex-box which doesn't work too well with vimtex.
" - python-compiler sets PYTHONWARNINGS env variable to ignore, which makes 
"   debugging a pain in the ass :))
let g:polyglot_disabled = ['latex', 'python-compiler']
