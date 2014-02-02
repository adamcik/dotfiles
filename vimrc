" Control variables for skipping some setup, can be set from .local
let g:skip_language_settings=0
let g:skip_pylint=0
let g:skip_omni_complete=0

" load per machine settings, missing file will be ignored.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

syntax on
filetype on

" Don't help me please...
nmap <F1> <nop>

set background=dark
set nobackup
set nowritebackup
set noswapfile
set pastetoggle=<F10>

colorscheme peachpuff

" Avoid trailing spaces.
highlight WhitespaceEOL ctermbg=red guibg=red
autocmd BufWinEnter * match WhitespaceEOL /\s\+$/

" Spell check on
set spell spelllang=en_us
setlocal spell spelllang=en_us

" Toggle spelling with the F7 key
nn <F7> :setlocal spell! spell?<CR>

" underline spelling mistakes
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" colorcolumn coloring
highlight clear ColorColumn
highlight ColorColumn ctermbg=0

if g:skip_language_settings==0
	autocmd FileType c,cpp,slang set cindent
	autocmd FileType c set formatoptions+=ro cindent
	autocmd FileType c set ts=4 et shiftwidth=4
	autocmd FileType perl set smartindent ts=4 et shiftwidth=4
	autocmd FileType php set autoindent
	autocmd FileType css set smartindent
	autocmd FileType html set formatoptions+=tl tabstop=2 expandtab sw=2
	autocmd FileType css set noexpandtab tabstop=2
	autocmd FileType make set noexpandtab shiftwidth=8
	autocmd FileType xml set tabstop=2 expandtab
	autocmd FileType python set ts=4 et shiftwidth=4 colorcolumn=80
endif

if g:skip_pylint==0
	function! s:PyLint()
	  let a:lint = 'pylint --output-format=parseable --include-ids=y'
	  cexpr system(a:lint . ' ' . expand('%'))
	endfunction
	au FileType python command! Lint :call s:PyLint()
endif

if g:skip_omni_complete==0
	autocmd FileType python set omnifunc=pythoncomplete#Complete
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
endif
