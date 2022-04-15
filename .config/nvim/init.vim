" Change mapleader
let mapleader = ","
let maplocalleader = "\\"

set nocompatible

"Visual Settings
set cursorline " Highlight current line
set number " Enable line numbers
set showtabline=2 " Always show tab bar at top of screen
set showmode " Always show the editing mode
set relativenumber " User relative line numbers. Current line is still in status bar
set title " Show the filename in the window titlebar
set nowrap " Do not wrap lines
set laststatus=2 " Always show status line
call matchadd('ColorColumn', '\%81v', 100) " only display columnwidth marker where exceeded
" set list lcs=trail:·,tab:»
set list lcs=trail:·,tab:\|\ 
set hlsearch " Highligh search results
set autowrite " autosave when calling :make (ie :GoBuild)
set encoding=utf8
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set mouse=n
set termguicolors

" Set Font
if has('gui_running')
	set guifont=DejaVu\ Sans\ Mono
endif

" Automatically Install vim-plug if not already on system
" see: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')
" Make sure you use single quotes

" Plug 'junegunn/vim-easy-align'
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'tomasr/molokai', { 'as': 'molokai' }
" Plug 'romainl/flattened'
" Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'tomasiser/vim-code-dark'

Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'posva/vim-vue'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'cakebaker/scss-syntax.vim'
Plug 'delphinus/vim-firestore'
Plug 'OmniSharp/omnisharp-vim'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'ternjs/tern_for_vim', {'do': 'yarn install'}
Plug 'nvie/vim-flake8'
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Initialize plugin system
call plug#end()

" NERDTree Settings
map <C-\> :NERDTreeToggle<CR>

" map fzf to ctrl-p
map <C-p> :FZF<CR>

" clear the last search pattern (highlight) with ctrl+/
nnoremap <silent> <C-_> :let @/ = ""<CR>

" ack.vim Settings
" `!` prevents jumping to first result
" press `?` for help in quickfix window 
cnoreabbrev Ack Ack!
nnoremap <leader>/ :Ack!<Space>

" Tagbar Settings (see https://snapcraft.io/universal-ctags)
" required installation: `sudo snap install universal-ctags` 
"   && `sudo snap connect universal-ctags:dot-ctags`
nmap <leader>\ :TagbarToggle<CR>
" https://github.com/majutsushi/tagbar/wiki#typescript
let g:tagbar_type_typescript = {
	\ 'ctagsbin' : 'tstags',
	\ 'ctagsargs' : '-f-',
	\ 'kinds': [
		\ 'e:enums:0:1',
		\ 'f:function:0:1',
		\ 't:typealias:0:1',
		\ 'M:Module:0:1',
		\ 'I:import:0:1',
		\ 'i:interface:0:1',
		\ 'C:class:0:1',
		\ 'm:method:0:1',
		\ 'p:property:0:1',
		\ 'v:variable:0:1',
		\ 'c:const:0:1',
	\ ],
	\ 'sort' : 0
\ }
" tagbar/ctags is interfering with ctrl+] (go back from def)
" see https://stackoverflow.com/questions/5017500/vim-difficulty-setting-up-ctags-source-in-subdirectories-dont-see-tags-file-i
set tags=./tags,./TAGS,tags;~,TAGS;~

let g:vim_svelte_plugin_use_sass = 1
let g:vim_svelte_plugin_use_typescript = 1

" vim-go see https://github.com/golang/tools/blob/master/gopls/doc/vim.md
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
" autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports" " this may be slow on large codebases, disalbe and call :GoImports
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)>
autocmd FileType go nmap <leader>ga <Plug>(go-alternate-edit)
autocmd FileType go nmap <leader>gah <Plug>(go-alternate-split)
autocmd FileType go nmap <leader>gav <Plug>(go-alternate-vertical)

" Debugging 
" autocmd FileType go nmap <leader>db :GoDebugBreakpoint<CR>
autocmd FileType go nmap <F9> :GoDebugBreakpoint<CR>
autocmd FileType go nmap <leader>ds :GoDebugStart<CR>
autocmd FileType go nmap <leader>dt :GoDebugTest<CR>
autocmd FileType go nmap <leader>dn :GoDebugNext<CR>
autocmd FileType go nmap <leader>dq :GoDebugStop<CR>

" go syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_methods = 1
let g:go_highlight_method_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_def_mapping_enabled = 0 " delegate to CoC
let g:go_auto_type_info = 1

" OmniSharp Settings
filetype indent plugin on
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" autocmd FileType python nmap <leader>p :CocCommand python.runLinting<CR>
let g:flake8_show_in_gutter = 1
let g:flake8_show_in_file = 1

autocmd FileType python nmap <buffer> <leader>p :call flake8#Flake8()<CR>

" vim-airline settings
let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 1

" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif

" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.whitespace = 'Ξ'

" vim-graphql enable support for prisma
au BufNewFile,BufRead *.prisma setfiletype graphql

" vim-jsx-typescript Settins
" set filetypes as typescript.tsx
" autocmd BufNewFile,BufRead *.tsx,*.jsx,*.ts set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" dark red
hi tsxTagName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575
hi typescriptDecorators guifg=#D08770

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic

" light-grey
hi tsxTypeBraces guifg=#999999
" dark-grey
hi tsxTypes guifg=#666666

" Theme / Syntax highlighting
set t_Co=256
set background=dark

if !exists("g:syntax_on")
	syntax enable
endif


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Onedark Theme
" colorscheme onedark
" let g:airline_theme='onedark'

" Nord Vim Theme
colorscheme nord

" Iceberg Theme
" colorscheme iceberg

" VS Code Theme
" colorscheme codedark

" Dracula Theme
" colorscheme dracula
" let g:dracula_colorterm=0

" colorscheme solarized

" hi CursorLine cterm=NONE ctermbg=black guibg=black

"-------------------------------------------------------------------------------
" inoremap jk <ESC>

" nmap <C-n> :NERDTreeToggle<CR>
" vmap ++ <plug>NERDCommenterToggle
" nmap ++ <plug>NERDCommenterToggle

" open NERDTree automatically
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
" let g:NERDTreeIgnore = ['^node_modules$']

" vim-prettier
" prettier command for coc
" command! -nargs=0 Prettier :CocCommand prettier.formatFile

" j/k will move virtual lines (lines that wrap)
" noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
" noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

"-------------------------------------------------------------------------------
" coc config
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-snippets',
  \ 'coc-svelte',
  \ 'coc-pyright',
  \ ]

  " \ 'coc-eslint',
  " \ 'coc-prettier',

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:airline#extensions#coc#enabled = 1

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : \<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" markdown preview
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
" let g:mkdp_browser = 'safari'
let g:mkdp_browser = 'Google Chrome'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {'theme': 'simple'},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" jsonc comment highlighting
" autocmd FileType json syntax match Comment +\/\/.\+$
autocmd FileType javascript,typescript setlocal ts=4 sts=4 sw=4 expandtab
