" Settings
set title hlsearch incsearch number showcmd ttyfast showmatch
set modeline autoindent smartindent nocompatible wildmenu
set mouse=a
set pdev=MFC235C
set directory^=$HOME/.vim_tmp/
set scrolloff=3
set textwidth=0
set matchtime=2
set laststatus=2
set dictionary+=/usr/share/dict/words
set spelllang=pt
"set tabstop=4

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
command Tab set list! listchars=tab:>-

" Binds
let mapleader = ","

map <C-N><C-N> :set invnumber<CR>
map <C-l><C-l> :call Togglestatus()<CR>
map <leader>ss :setlocal spell!<cr>
map <Tab> <C-W>w
map <S-Tab> <C-W>W

inoremap jj <ESC>

nnoremap <leader> y yyp
nnoremap <F3> :TlistToggle<CR>
nnoremap <F4> :GundoToggle<CR>
nnoremap <F5> :Tab<CR>

" Colors
set t_Co=256
colorscheme molokai
hi ModeMsg ctermbg=green ctermfg=black

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

" Typewriter sound
"function! PlaySound()
"  silent! exec '!aplay ~/.vim/type.wav 2>/dev/null &'
"endfunction
"autocmd CursorMovedI * call PlaySound()
