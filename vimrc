" Settings
set title hlsearch incsearch number showcmd ttyfast showmatch
set autoindent nocompatible wildmenu
set modeline
set secure
set cindent
set cinkeys-=0#
set indentkeys-=0#
set mouse=a
set pdev=Default
set directory^=$HOME/.vim_tmp/
set scrolloff=3
set textwidth=0
set matchtime=2
set laststatus=2
set dictionary+=/usr/share/dict/words
set spelllang=en
set colorcolumn=80
set wildmode=longest,list,full
"set listchars=tab:\|\\u202F,trail:\\u202F
set listchars=tab:\|\\u202F,eol:$,nbsp:~,trail:X
syntax on

let g:vimtex_view_method='zathura'
let g:tex_flavor = 'latex'

if version >= 703
	set undofile
	set undodir^=$HOME/.vim_tmp/
endif

" ~/.vimrc[+]  unix utf-8 vim                                                           22,22  47/75  62%
set statusline=%F%m%r%h%w\ \ %{&ff}\ %{&fenc}\ %{&ft}%=%c,%v\ \ %l/%L\ \ %p%%\ 

" Alias
command W write
command Q quit
command Wq wq
command WQ wq
command Qa qa
command QA qa
command Noh noh
command Set set
command Sudo w !sudo tee %

" Binds
let mapleader = ","

map <C-N><C-N> :call ToggleLineNumbers()<CR>
map <C-l><C-l> :call Togglestatus()<CR>
map <leader>ss :setlocal spell!<cr>
map <Tab> <C-W>w
map <S-Tab> <C-W>W

inoremap jj <ESC>

nnoremap <leader> y yyp
nnoremap <F5> :TlistToggle<CR>
nnoremap <F6> :GundoToggle<CR>
nnoremap <F7> :call ToggleList()<CR>

" Colors
set t_Co=256
colorscheme molokai
hi ModeMsg ctermbg=green ctermfg=black
hi ColorColumn ctermbg=black

" Enable spell check on git commit edits
autocmd FileType gitcommit setlocal spell

" Highlight extra white space
highlight ExtraWhitespace ctermbg=darkgray guibg=lightgreen
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/ 
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinLeave * call clearmatches()

" Enable/Disable status bar
function Togglestatus()
	if &laststatus == 2
		set laststatus=1
	else
		set laststatus=2
	endif
endfunction

" Toggle line numbers mode
function ToggleLineNumbers()
	if &number
		if &relativenumber
			set nonumber
			set norelativenumber
		else
			set relativenumber
		endif
	else
		set number
	endif
endfunction

let g:current_list_mode = 0
function ToggleList()
	if g:current_list_mode == 0
		set list listchars=tab:\|\\u202F
		let g:current_list_mode=1

	elseif g:current_list_mode == 1
		set list listchars=tab:\|-,eol:$,nbsp:~,trail:X
		let g:current_list_mode = 2

	elseif g:current_list_mode == 2
		set list!
		let g:current_list_mode = 0
	endif
endfunction
