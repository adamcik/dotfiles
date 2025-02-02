" Control variables for skipping some setup, can be set from .local
let g:skip_language_settings=0
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

if (has('termguicolors'))
  set termguicolors
endif

if &term =~ '256color'
  if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
endif

colorscheme tokyonight

" make select inside/around work for slash:
onoremap <silent> i/ :<C-U>normal! T/vt/<CR>
onoremap <silent> a/ :<C-U>normal! F/vf/<CR>

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
	autocmd FileType c,cpp,slang setlocal cindent
	autocmd FileType c setlocal formatoptions+=ro cindent
	autocmd FileType c setlocal ts=4 et shiftwidth=4
	autocmd FileType perl setlocal smartindent ts=4 et shiftwidth=4
	autocmd FileType php setlocal autoindent
	autocmd FileType css setlocal smartindent
	autocmd FileType html setlocal formatoptions+=tl tabstop=2 expandtab sw=2
	autocmd FileType css setlocal noexpandtab tabstop=2
	autocmd FileType make setlocal noexpandtab shiftwidth=8
	autocmd FileType xml setlocal tabstop=2 expandtab
	autocmd FileType python setlocal ts=4 et shiftwidth=4 colorcolumn=80
	autocmd FileType javascript setlocal ts=4 et shiftwidth=4 colorcolumn=80

	augroup encrypted
		au!
		autocmd BufReadPre,FileReadPre	pass.* set viminfo=
		autocmd BufReadPre,FileReadPre	pass.* set noswapfile
	augroup END
endif

if g:skip_omni_complete==0
	autocmd FileType python set omnifunc=pythoncomplete#Complete
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
endif
