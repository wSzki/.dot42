
" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: wszurkow <wszurkow@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2020/09/29 17:22:42 by wszurkow          #+#    #+#              "
"    Updated: 2020/10/07 15:58:18 by wszurkow         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

"################################################ "
"### VIMPLUG INSTALL ### "
"################################################ "
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" INSTALL PYTHON VIM
"	python3 -m pip install --user --upgrade pynvim

" LINK VIMRC to NVIMRC > ~/.config/nvim/init.vim
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vimrc

"################################################ "
"### INTERFACE SETUP ### "
"################################################ "
" Syntax
""""""""
syntax on
syn match cType "\<[a-zA-Z_][a-zA-Z0-9_]*_[t]\>"
syn match cType "\<[t]_*[a-zA-Z_][a-zA-Z0-9_]\>"


" Settings
"""""""""""
set mouse=a
set splitright
set clipboard^=unnamed,unnamedplus
set nu
set scrolloff=5
set relativenumber
set laststatus=2
set background=dark
set history=1000
set noswapfile
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=20
"set foldmethod=manual, indent, syntax, diff
"set signcolumn=number
"set clipboard=unnamed

"Indentation
"""""""""""""
filetype indent on
filetype plugin on
set autoindent
set cindent
set smartindent

" Lines, rulers, wrapping
""""""""""""""""""""""""""
set linebreak
set ruler
set nowrap
set tabstop=4
set shiftwidth=4
set breakindent
set breakindentopt=shift:2
set showbreak=↳
set nocursorcolumn
"set nocursorline
set cursorline
"set showbreak=\\\\\↳

" Search
"""""""""
set incsearch
set hlsearch
set infercase
set smartcase

" Wildmenu
"""""""""""
set wildmode=longest:full,full
set wildmenu
set wildignorecase
"set wildmode=longest,list,full
"set wildmode=list

" Split
""""""""
"Automatically equalize splits when Vim is resized
autocmd VimResized * wincmd =
set splitbelow
set splitright

" WhiteSpaces
""""""""""""""
set list
set listchars=space:.,tab:•-,trail:~,extends:>,precedes:<
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

"################################################ "
"### PERFORMANCE SETTINGS  ### "
"################################################ "
" Improve scroll performance for certain file types:
"""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup syntaxSyncMinLines
	autocmd!
	autocmd Syntax * syntax sync minlines=2000
augroup END

" Performance misc
"""""""""""""""""""
set encoding=utf-8
set complete-=5
set lazyredraw
set re=1
set timeoutlen=1000
set ttimeoutlen=0
set synmaxcol=200
syntax sync minlines=256

" True Color settings
""""""""""""""""""""""
if has('termguicolors')
	set termguicolors
endif
"" Correct RGB escape codes for vim inside tmux
"if !has('nvim') && $TERM ==# 'screen-256color'
"	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"endif

" No Indent Pasting
""""""""""""""""""""
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
	set pastetoggle=<Esc>[201~
	set paste
	return ""
endfunction

" Disable clear clipboard onleave
""""""""""""""""""""""""""""""""""
"if  has('clipboard_data')
"autocmd VimLeave * call system("echo -n $'" . escape(getreg(), "'") . "' | xclip -selection buffer-cut")
"endif
autocmd VimLeave * call system("xclip -o | xclip -selection c")
"autocmd VimLeave * call system('echo -n' . shellescape(getreg('+')) .
			"\ ' | xclip -selection clipboard')
"autocmd VimLeave * call system("xsel -ib", getreg('+'))
"autocmd VimLeave * call system("xclip -selection clipboard -i", getreg('+'))
"autocmd VimLeave * call system("xclip -selection clipboard -i", getreg('+'))

"################################################ "
" ### MAPPINGS ####
"################################################ "

command PYNVIM :!python3 -m pip install --user --upgrade pynvim

nnoremap ; :
vnoremap ; :
inoremap <C-Space> <C-]>
" Indent and center
noremap <Leader>n :!norminette %<CR>

map gg gg=G''zz ml:execute 'match Search /\%'.line('.').'l/'<CR>


" Go to file under cursor
map gf :Ack<CR>q

" Surround
map ( saiw(
"))
map { saiw{
map [ saiw[

"map ]] zfa}
map <TAB><TAB> za

" Reload and PlugInstall
noremap <Leader>wso :w <CR>:so %<CR>:PlugInstall<CR><ESC>
noremap <Leader>o :silent execute '!kitty & disown'<CR><ESC>
"noremap <Leader>ack :Ack<CR>q

" Toggle relative number
nmap <f11> :windo set relativenumber!<CR>

" Search - Espace with ENTER
nnoremap <CR> :match<CR>:noh<CR>
inoremap <ESC> <ESC><ESC>

" Write
nnoremap <C-s> <ESC><ESC><ESC>:w<CR><ESC>
inoremap <C-s> <ESC><ESC><ESC>:w<CR><ESC>i

" Split navigation
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left>  <c-w>h
nnoremap <silent> <C-Up>    <c-w>k
nnoremap <silent> <C-Down>  <c-w>j

"open term
nnoremap <Leader>t    :20Term<CR>
nnoremap <Leader>T    :VTerm<CR>


" Remap visual block
nnoremap <C-e> <C-q>

" Quit
nnoremap <C-q> <ESC><ESC>:Sayonara<CR>
inoremap <C-q> <ESC><ESC>:Sayonora<CR>

" Buffer select
nnoremap <C-PageUp> :bp<CR>
nnoremap <C-PageDown> :bn<CR>
inoremap <C-PageUp> <ESC><ESC>:bp<CR>
inoremap <C-PageDown> <ESC><ESC>:bn<CR>

noremap <Leader>tree <C-p>

"################################################ "
"### PLUG ###"
"################################################ "

" PLug call
""""""""""""
call plug#begin('~/.vim/plugged')

" Themes
"""""""""
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'logico/typewriter-vim'
Plug 'mcchrish/zenbones.nvim'
Plug 'Soares/base16.nvim'
Plug 'chriskempson/base16-vim'
Plug 'arcticicestudio/nord-vim'
"Plug 'equt/paper.vim'
"Plug 'wimstefan/vim-artesanal'
"Plug 'nightsense/shoji'
"
" Vim exclusive
""""""""""""""""
if has (!('nvim'))
	"Plug 'ervandew/supertab'
	"Plug 'dense-analysis/ale'
	"Plug 'ycm-core/YouCompleteMe'
endif

"NVim Exclusive
""""""""""""""""
if has ('nvim')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'davidgranstrom/scnvim', { 'do': {-> scnvim#install() } }
	Plug 'honza/vim-snippets'
	Plug 'dstein64/nvim-scrollview'
	Plug 'vimlab/split-term.vim'
	"Plug 'nvim-lua/plenary.nvim'
	"Plug 'jose-elias-alvarez/null-ls.nvim'
	"Plug 'vinicius507/norme.nvim'
	"Plug 'wszki/nvim_tabline'
	"Plug 'kyazdani42/nvim-web-devicons'
endif

"General
"""""""""
Plug 'frazrepo/vim-rainbow'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'pandark/42header.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mg979/vim-visual-multi'
Plug 'airblade/vim-gitgutter'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'mileszs/ack.vim'
Plug 'ericbn/vim-relativize'
Plug 'chrisbra/colorizer'
Plug 'wszki/vim-smooth-scroll'
Plug 'mhinz/vim-sayonara'
Plug 'plasticboy/vim-markdown'
Plug 'vim-scripts/restore_view.vim'
Plug 'mbbill/undotree'
Plug 'machakann/vim-sandwich'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'stormherz/tablify'
Plug 'bfrg/vim-cpp-modern'
Plug 'ryanoasis/vim-devicons'

"Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'wfxr/minimap.vim'
"Plug '/mattn/emmet-vim'
"Plug 'sirver/ultisnips'
"Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
"Plug 'ryanoasis/vim-devicons' Icons without colours
"Plug 'akinsho/bufferline.nvim'
"Plug 'axlebedev/footprints'
"Plug 'jackguo380/vim-lsp-cxx-highlight'
"Plug 'vim-scripts/TagHighlight'
"Plug 'bbchung/Clamp'
"Plug 'jeaye/color_coded'
"Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'xolox/vim-easytags'
"Plug 'xolox/vim-notes'
"Plug 'xolox/vim-misc'
"Plug 'bfrg/vim-cpp-modern'
"Plug 'raimondi/delimitmate'
"Plug 'tommcdo/vim-exchange'
"Plug 'gorodinskiy/vim-coloresque'
"Plug 'junegunn/vim-peekaboo'
call plug#end()

"source ~/.dot/vim/supercollider.vim

"################################################ "
"### GRUVBOX MATERIAL ### "
"################################################ "
let g:gruvbox_material_enable_italic = 1
"let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_menu_selection_background = 'yellow'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_palette = {
			\ 'bg0':              ['#191d20',   '234'],
			\ 'bg1':              ['#262727',   '235'],
			\ 'bg2':              ['#191d20',   '235'],
			\ 'bg3':              ['#3c3836',   '237'],
			\ 'bg4':              ['#3c3836',   '237'],
			\ 'bg5':              ['#504945',   '239'],
			\ 'bg_statusline1':   ['#1f2428',   '235'],
			\ 'bg_statusline2':   ['#32302f',   '235'],
			\ 'bg_statusline3':   ['#504945',   '239'],
			\ 'bg_diff_green':    ['#32361a',   '22'],
			\ 'bg_visual_green':  ['#333e34',   '22'],
			\ 'bg_diff_red':      ['#3c1f1e',   '52'],
			\ 'bg_visual_red':    ['#442e2d',   '52'],
			\ 'bg_diff_blue':     ['#0d3138',   '17'],
			\ 'bg_visual_blue':   ['#2e3b3b',   '17'],
			\ 'bg_visual_yellow': ['#473c29',   '94'],
			\ 'bg_current_word':  ['#32302f',   '236'],
			\ 'fg0':              ['#d4be98',   '223'],
			\ 'fg1':              ['#ddc7a1',   '223'],
			\ 'red':              ['#ea6962',   '167'],
			\ 'orange':           ['#EBCB8B',   '208'],
			\ 'yellow':           ['#d8a657',   '214'],
			\ 'green':            ['#A3BE8C',   '142'],
			\ 'aqua':             ['#D08770',   '108'],
			\ 'blue':             ['#7C9C90',   '109'],
			\ 'purple':           ['#e78a4e',   '175'],
			\ 'bg_red':           ['#ea6962',   '167'],
			\ 'bg_green':         ['#a9b665',   '142'],
			\ 'bg_yellow':        ['#d8a657',   '214'],
			\ 'grey0':            ['#7c6f64',   '243'],
			\ 'grey1':            ['#928374',   '245'],
			\ 'grey2':            ['#a89984',   '246'],
			\ 'none':             ['NONE',      'NONE']
			\ }
			"\ green : #A3BE8C
"" bg5 : #504945
colorscheme gruvbox-material

"################################################ "
"### RESTORE VIEW ### "
"################################################ "
set viewoptions=cursor,folds,slash,unix
let g:skipview_files = ['*\.vim']

"################################################ "
"### NCOC ### "
"################################################ "

":CocConfig >
"{
"coc.preferences.semanticTokensHighlights": false,
"diagnostic.checkCurrentLine": true,
"diagnostic.virtualText": true,
"diagnostic.virtualTextCurrentLineOnly" : false,
"}

runtime! plugin/supertab.vim
inoremap <s-tab>  <tab>
nnoremap gd       :call       CocActionAsync('doHover')<CR>
nnoremap gD       :call       CocActionAsync('jumpDefinition')<CR>
command  COCSETUP :CocInstall coc-clangd coc-cmake coc-fzf coc-sh coc-snippets coc-yank
command  COCWEB   :CocInstall coc-emmet  coc-css   coc-html
nmap     <silent> <C-k>       <Plug>(coc-diagnostic-prev)
nmap     <silent> <C-j>       <Plug>(coc-diagnostic-next)


"################################################# "
"### EASY ALIGN ###
"################################################ "
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
map g=  gaip*=
map g\| gaip*\|
map g.  gaip*.
map g,  gaip*,
map g<Space> gaip*<Space>

"################################################ "
"### FOOTPRINTS ### "
"################################################ "
let g:footprintsColor            = '#3A3A3A'
let g:footprintsTermColor        = '208'
let g:footprintsEasingFunction   = 'linear'
let g:footprintsHistoryDepth     = 20
let g:footprintsExcludeFiletypes = ['magit', 'nerdtree', 'diff']
let g:footprintsEnabledByDefault = 1
let g:footprintsOnCurrentLine    = 0

"################################################ "
"### TABLINE ### "
"################################################ "
"let bufferline = get(g:, 'bufferline', {})
"let bufferline.icons = v:true
"let bufferline.animation = v:true
"let bufferline.tabpages = v:true

"################################################ "
"### AIRLINE ### "
"################################################ "
let g:airline#extensions#tabline#enabled   = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme                        = 'gruvbox_material'
"let g:airline_theme='base16'
"let g:airline#extensions#tabline#formatter = 'default'
"
"################################################ "
"### RAINBOW BRACKETS ### "
"################################################ "
map <C-b>                                  :RainbowToggle<CR>
"let g:rainbow_active = 1

"################################################ "
"### SMOOTH SCROLL ### "
"################################################ "

noremap  <silent> <PageUp>   :call      smooth_scroll#up(25,   3, 1)<CR>
noremap  <silent> <PageDown> :call      smooth_scroll#down(25, 3, 1)<CR>
inoremap <silent> <PageUp>   <ESC>:call smooth_scroll#up(25,   3, 1)<CR>
inoremap <silent> <PageDown> <ESC>:call smooth_scroll#down(25, 3, 1)<CR>

"################################################ "
"### 42 HEADER ### "
"################################################ "
nmap <F12> :FortyTwoHeader<CR>
let b:fortytwoheader_user="wszurkow"
let b:fortytwoheader_mail="wszurkow@student.42.fr"

"################################################ "
"### HEX HIGHLIGHT### "
"################################################ "
nmap <F2>			<ESC>:ColorToggle<CR>
"nmap <F2>           <Plug>ToggleHexHighlight
"nmap <leader><F2>   <Plug>ToggleSchemeHighlight

"################################################ "
"### NERDTREE ### "
"################################################ "
nmap <C-p> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=15
let NERDTreeMinimalUI=1
" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
			\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"################################################ "
"### VISUAL-MULTIPLE-CURSORS ### "
"################################################ "
let g:VM_maps = {}
let g:VM_maps["Select All"]                  = '\\a'
let g:VM_maps["Add Cursor Down"]             = '<S-Down>'
let g:VM_maps["Add Cursor Up"]               = '<S-Up>'
let g:VM_maps["Add Cursor At Pos"]           = '\\\'
let g:VM_maps['Find Under']                  = '<C-n>'
"let g:VM_maps['Find Subword Under']          = '<C-n>'
"let g:VM_maps["Start Regex Search"]          = '\\/'
"let g:VM_maps["Visual Regex"]                = '\\/'
"let g:VM_maps["Visual All"]                  = '\\a'
"let g:VM_maps["Visual Add"]                  = '\\a'
"let g:VM_maps["Visual Find"]                 = '\\f'
"let g:VM_maps["Visual Cursors"]              = '\\c'

"################################################ "
"### FZF ### "
"################################################ "
nnoremap <silent> <C-f> :Files<CR>
let g:fzf_preview_window = 'right:60%'

"################################################ "
"### UNDOTREE ### "
"################################################ "
nnoremap <C-u> :UndotreeToggle<cr>
let g:undotree_WindowLayout         = 2
let g:undotree_ShortIndicators      = 1
let g:undotree_SetFocusWhenToggle   = 1
let g:undotree_HighlightChangedText = 1
let g:undotree_HelpLine             = 1
if has("persistent_undo")
	try
		set undodir=~/.undodir
		set undofile
	catch
	endtry
endif

"################################################ "
"################################################ "
"################################################ "
"################################################ "
"################################################ "
"
"################################################ "
"### UTILSNIPS ###
"################################################ "
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'scnvim-data']
"
"################################################ "
"### GRUVBOX ### "
"################################################ "
" Gruvbox Classic
"let g:gruvbox_contrast_dark='hard'
"let g:gruvbox_improved_warnings=1
"let g:gruvbox_sign_color='none'
"let g:gruvbox_improved_strings=1
"colorscheme gruvbox

"################################################ "
"### YCM ### "
"################################################ "

" YcmRestartServer to reload
"let g:ycm_auto_trigger = 0
"let g:ycm_max_num_candidates = 15
"let g:ycm_max_num_identifier_candidates = 15
"let g:ycm_min_num_of_chars_for_completion = 2
"nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>
"" turn off YCM
"nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>
"
"################################################ "
"### ALE ### "
"################################################ "

"let g:ale_set_highlights = 1
"let g:airline#extensions#ale#enabled = 1
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 1
"let g:ale_lint_on_enter = 1
"let g:ale_hover_cursor = 1
"let g:ale_set_balloons = 1
"let g:ale_hover_to_preview = 1
"let g:ale_cursor_details =1
"let g:ale_sign_column_always = 1
"let g:ale_sign_error = '✖✖'
"let g:ale_sign_warning = '∙∙'
"let g:ale_open_list = 0
"let g:ale_change_sign_column_color = 1
"let g:ale_list_vertical = 0
"let g:ale_set_quickfix = 0
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)
""let g:ale_enabled = 1
""let g:ale_lint_on_text_changed = 'always'
"
"" # Propreties #  "
"" bold, underline, undercurl, strikethrough, reverse, italic, standout,  nocombine
"highlight ALEError ctermfg=Red cterm=italic
"highlight ALEWarning ctermfg=Yellow cterm=italic
"highlight ALEStyleWarning ctermbg=none cterm=none
"highlight ALEStyleError ctermbg=none cterm=none
"
"function! LinterStatus() abort
"	let l:counts = ale#statusline#Count(bufnr(''))
"	let l:all_errors = l:counts.error + l:counts.style_error
"	let l:all_non_errors = l:counts.total - l:all_errors
"
"	return l:counts.total == 0 ? 'OK' : printf(
"				\   '%dW %dE',
"				\   all_non_errors,
"				\   all_errors
"				\)
"endfunction
"set statusline=%{LinterStatus()}

"################################################ "
"### Minimap ### "
"################################################ "

"let g:minimap_width = 1
"let g:minimap_highlight = 'Keyword'
"let g:minimap_auto_start = 1
"autocmd VimEnter * Minimap
"autocmd VimEnter * wincmd p

"################################################ "
"### WILDMENU  ### "
"################################################ "

"call wilder#enable_cmdline_enter()
"set wildcharm=<Tab>
"cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
"cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
""" only / and ? is enabled by default
"call wilder#set_option('modes', ['/', '?', ':'])

"################################################ "
"### VIMSPECTOR ### "
"################################################ "

"packadd! vimspector
"let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
"let g:vimspector_enable_mappings = 'HUMAN'


"################################################ "
"### PEEKABOO ### "
"################################################ "
"let g:peekaboo_compact=1


"################################################ "
"### SMOOTH SCROLL ### "
"################################################ "
"noremap <silent> <PageUp> 20kzb
"noremap <silent> <PageDown> 20jzb
"inoremap <silent> <PageUp> <ESC> 20kzbi
"inoremap <silent> <PageDown> <ESC> 20jzbi
"inoremap <silent> <PageUp> <ESC>:call smooth_scroll#up(&scroll*2, 1, 4)<CR>i
"inoremap <silent> <PageDown> <ESC>:call smooth_scroll#down(&scroll*2, 1, 4)<CR>i
"let g:comfortable_motion_no_default_key_mappings = 1
"let g:comfortable_motion_no_default_key_mappings = 1
"let g:comfortable_motion_no_default_key_mappings = 1
"let g:comfortable_motion_friction = 100.0
"let g:comfortable_motion_air_interval = 600/60
"let g:comfortable_motion_air_drag = 4.0
"nnoremap <silent> <PageDown> :call comfortable_motion#flick(600)<CR>
"nnoremap <silent> <PageUp> :call comfortable_motion#flick(-600)<CR>
"noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
"noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
"noremap <silent> <PageUp> :call smooth_scroll#up(&scroll, 3, 1)<CR>
"noremap <silent> <PageDown> :call smooth_scroll#down(&scroll, 3, 1)<CR>


"################################################ "
"### SYNTASTIC ### "
"################################################ "

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"################################################ "
"### SCROLLBAR ### "
"################################################ "

"augroup ScrollbarInit
"  autocmd!
"  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
"  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
"  autocmd WinLeave,FocusLost             * silent! lua require('scrollbar').clear()
"augroup end



"################################################ "
"
" SCROLL BAR - not working
"
"func! STL()
"  let stl = '%f [%{(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",B":"")}%M%R%H%W] %y [%l/%L,%v] [%p%%]'
"  let barWidth = &columns - 65 " <-- wild guess
"  let barWidth = barWidth < 3 ? 3 : barWidth
"
"  if line('$') > 1
"    let progress = (line('.')-1) * (barWidth-1) / (line('$')-1)
"  else
"    let progress = barWidth/2
"  endif
"
"  " line + vcol + %
"  let pad = strlen(line('$'))-strlen(line('.')) + 3 - strlen(virtcol('.')) + 3 - strlen(line('.')*100/line('$'))
"  let bar = repeat(' ',pad).' [%1*%'.barWidth.'.'.barWidth.'('
"        \.repeat('-',progress )
"        \.'%2*0%1*'
"        \.repeat('-',barWidth - progress - 1).'%0*%)%<]'
"
"  return stl.bar
"endfun
"
"hi def link User1 DiffAdd
"hi def link User2 DiffDelete
"set stl=%!STL()
"
"
"################################################ "
"### NERDTREE ### "
"################################################ "
"nmap <C-p> :NERDTreeToggle<CR>
"let g:NERDTreeWinSize=15
"let NERDTreeMinimalUI=1
"" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p

"" Exit Vim if NERDTree is the only window remaining in the only tab.
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"" Close the tab if NERDTree is the only window remaining in it.
"autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
			"\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"autoquit if only left is nerdtree
"augroup vimrc_autocmd
"autocmd!
"
""toggle quickfix window
"autocmd BufReadPost quickfix map <buffer> <leader>qq :cclose<cr>|map <buffer> <c-p> <up>|map <buffer> <c-n> <down>
"autocmd FileType unite call s:unite_settings()

"" obliterate unite buffers (marks especially).
"autocmd BufLeave \[unite\]* if "nofile" ==# &buftype | setlocal bufhidden=wipe | endif

"" Jump to the last position when reopening a file
""autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" Start NERDTree
""autocmd VimEnter * NERDTree

"" Go to previous (last accessed) window.
"autocmd VimEnter * wincmd p
"let NERDTreeMapPreviewVSplit="\r"
"let NERDTreeMapCustomOpen="\z"

"" open in new tab
"let NERDTreeMapOpenInTab='<ENTER>'
"augroup END

"################################################ "
"### MINIMAP ###
"################################################ "
"let g:minimap_width = 3
"let g:minimap_auto_start = 1
"let g:minimap_auto_start_win_enter = 1
"let g:minimap_highlight = 'MinimapCurrentLine'
""hi MinimapCurrentLine ctermfg=Green guifg=#fabd2f guibg=#32302f
