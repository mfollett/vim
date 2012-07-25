" _vimrc
"
" Settings for both terminal and GUI Vim sessions.
" (See _gvimrc for GUI-specific settings.)
"

"pathogen
" http://www.vim.org/scripts/script.php?script_id=2332
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles() 

" Use Vim settings instead of Vi settings. Set this early,
" as it changes many other options as a side effect.
set nocompatible

set shortmess+=I        " Don't show the Vim welcome screen.

set autoindent          " Copy indent from current line for new line
set nosmartindent       " 'smartindent' breaks right-shifting of # lines

set hidden              " Keep changed buffers without requiring saves

set history=500         " Remember this many command lines

set ruler               " Always show the cursor position
set showcmd             " Display incomplete commands
set incsearch           " Do incremental searching
set hlsearch            " Highlight latest search pattern
set number              " Display line numbers
set numberwidth=4       " Minimum number of columns to show for line numbers
set laststatus=2        " Always show a status line
set vb t_vb=            " Use null visual bell (no beeps or flashes)

set scrolloff=3         " Context lines at top and bottom of display
set sidescrolloff=5     " Context columns at left and right
set sidescroll=1        " Number of chars to scroll when scrolling sideways

set nowrap              " Don't wrap the display of long lines
set linebreak           " Wrap at 'breakat' char vs display edge if 'wrap' on
set display=lastline    " Display as much of a window's last line as possible

set expandtab           " Insert spaces for <Tab> press; use spaces to indent
set smarttab            " Tab respects 'shiftwidth', 'tabstop', 'softtabstop'
set tabstop=4           " Set the visible width of tabs
set softtabstop=4       " Edit as if tabs are 4 characters wide
set shiftwidth=4        " Number of spaces to use for indent and unindent
set shiftround          " Round indent to a multiple of 'shiftwidth'

set ignorecase          " Ignore case for pattern matches (\C overrides)
set smartcase           " Override 'ignorecase' if pattern contains uppercase
"set nowrapscan          " Don't allow searches to wrap around EOF

set nocursorline        " Don't highlight the current screen line...
set nocursorcolumn      " ...or column

set virtualedit=block   " Allow virtual editing when in Visual block mode

set foldcolumn=3        " Number of columns to show at left for folds.
set foldnestmax=3       " Only allow 3 levels of folding.
set foldlevelstart=99   " Start with all folds open.

set whichwrap+=<,>,[,]  " Allow left/right arrows to move across lines

set nomodeline          " Ignore modelines
set nojoinspaces        " Don't get fancy with the spaces when joining lines
set textwidth=0         " Don't auto-wrap lines except for specific filetypes

" interferes with linebreak & breakat, set things with listchars if I ever
" want it back
set nolist

set backspace=indent,eol,start  " Backspace over everything in Insert mode

set noshowmatch                 " Don't jump to matching characters
set matchpairs=(:),[:],{:},<:>  " Character pairs for use with %, 'showmatch'

set wildmenu                    " use menu for completion
set wildmode=longest,list       " menu completes to longet common, then lists
"
" Backup files and directories
"

" Keep a backup file for all platforms except VMS. (VMS supports automatic
" versioning.)
"
if has("vms")
    set nobackup
else
    set backup
endif

" Prepend OS-appropriate temporary directories to the backupdir list.
"
if has("unix") " (including OS X)

    " Remove the current directory from the backup directory list.
    set backupdir-=.

    " Save backup files in the current user's ~/tmp directory,
    " or in the system /tmp directory if that's not possible.
    "
    set backupdir^=~/tmp,/tmp

    " Try to put swap files in ~/tmp (using the munged full pathname of
    " the file to ensure uniqueness). Use the same directory
    " as the current file if ~/tmp isn't available.
    "
    set directory=~/tmp//,.
endif

set updatecount=20 " update swap file every 20 characters

" Switch on syntax highlighting when the terminal has colors, or when
" running in the GUI version of Vim. Tell $VIMRUNTIME/menu.vim to expand
" the syntax menu.
"
" Note: This happens before the autocommand section below to give the
" syntax command a chance to trigger loading the menus, vs. letting the
" filetype command do it. If do_syntax_sel_menu isn't set beforehand,
" the syntax menu won't get populated.
"
if &t_Co > 2 || has("gui_running")
    let do_syntax_sel_menu=1
    syntax on
endif


"
" Autocommands
"

if has("autocmd") && !exists("autocommands_loaded")

    " Only load autocommands once. I use this flag instead of just blindly
    " running `autocmd!` (to remove all autocommands from the current group)
    " because `autocmd!` breaks the syntax highlighting / syntax menu
    " expansion logic.
    "
    let autocommands_loaded=1

    " Enable file type detection. Use the default filetype settings, so that
    " mail gets 'tw' set to 72, 'cindent' is on in C files, etc. Also load
    " indent files, to automatically do language-dependent indenting.
    "
    filetype plugin indent on

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    "
    autocmd BufReadPost *
        \   if line("'\"") > 0 && line("'\"") <= line("$") |
        \       exe "normal g`\"" |
        \   endif

    autocmd BufRead *Spec.groovy set cinkeys-=:

endif " has("autocmd")


" Set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for
" Windows-like behavior. `behave mswin` is equivalent to:
"
"     set selection=exclusive
"     set selectmode=mouse,key
"     set mousemodel=popup
"     set keymodel=startsel,stopsel
"
" 'selectmode' and 'keymodel' are important for some of the mappings below.
"
behave mswin


"
" Key mappings
"

" @note if I ever use this on Win32 again I should reference Bill's vimrc
" otherwise the win32 stuff is dead code

" Control+Z is Undo, in Insert mode.
"
inoremap <C-Z>  <C-O>u

" Tab/Shift+Tab indent/unindent the highlighted block (and maintain the
" highlight after changing the indentation). Works for both Visual and Select
" modes.
" 
vmap <Tab>    >gv
vmap <S-Tab>  <gv

" Make arrow keys move by display lines instead of physical lines.
"
inoremap <Up>     <C-O>gk
inoremap <Down>   <C-O>gj
nnoremap <Up>     gk
nnoremap <Down>   gj
xnoremap <Up>     gk
xnoremap <Down>   gj
xnoremap <Left>   h
xnoremap <Right>  l

" Disable paste-on-middle-click.
"
map  <MiddleMouse>    <Nop>
map  <2-MiddleMouse>  <Nop>
map  <3-MiddleMouse>  <Nop>
map  <4-MiddleMouse>  <Nop>
imap <MiddleMouse>    <Nop>
imap <2-MiddleMouse>  <Nop>
imap <3-MiddleMouse>  <Nop>
imap <4-MiddleMouse>  <Nop>

" Control+Backslash toggles search/match highlighting
" 
runtime toggle_highlights.vim
map  <silent> <C-Bslash>  :set nohlsearch<CR>
imap <silent> <C-BSlash>  <Esc><C-BSlash>a
vmap <silent> <C-BSlash>  <Esc><C-BSlash>gv

" Control+Arrows move lines/selections up and down.
" (From a comment found in http://www.vim.org/tips/tip.php?tip_id=646)
"
nmap <C-Up>     :m-2<CR>
nmap <C-Down>   :m+<CR>
imap <C-Up>     <C-O>:m-2<CR><C-O>
imap <C-Down>   <C-O>:m+<CR><C-O>
vmap <C-Up>     :m'<-2<CR>
vmap <C-Down>   :m'>+<CR>

" Enable Human-Interface Guidelines (HIG) command/option/shift movement
" keys in MacVim. (See MacVim.app/Contents/Resources/vim/gvimrc for details.)
"
" Note: It might seem like these flags should go in the user's gvimrc, since
" they're related to the GUI, but that's not correct. They're checked by
" MacVim's system gvimrc, which runs before the user's gvimrc, so if they're
" not here, they don't get set in time.
"
if has("gui_macvim")

    " Enable HIG Command and Option movement mappings.
    " by *not* setting macvim_skip_cmd_opt_movement.
    " (That is, *don't* skip mapping them.)
    "
    unlet! macvim_skip_cmd_opt_movement

    " Enable HIG shift movement settings.
    let macvim_hig_shift_movement=1

endif " has("gui_macvim")

" Control+Hyphen (yes, I know it says underscore) repeats the character above
" the cursor.
"
inoremap <C-_>  <C-Y>

" Center the display line after searches. (This makes it *much* easier to see
" the matched line.)
"
" More info: http://www.vim.org/tips/tip.php?tip_id=528
"
nnoremap n   nzz
nnoremap N   Nzz
nnoremap *   *zz
nnoremap #   #zz
nnoremap g*  g*zz
nnoremap g#  g#zz


" Draw lines of dashes or equal signs based on the length of the line
" immediately above.
"
"   k       Move up 1 line 
"   yy      Yank whole line
"   p       Put line below current line
"   ^       Move to beginning of line
"   v$      Visually highlight to end of line
"   r-      Replace highlighted portion with dashes / equal signs
"   j       Move down one line
"   i       Go to Insert mode
"
" XXX: Convert this to a function and make the symbol a parameter.
" XXX: Consider making mappings for ---<CR> and ===<CR>
"
nnoremap <Leader>h-   kyyp^v$r-ji
nnoremap <Leader>h=   kyyp^v$r=ji

" Comma+SingleQuote toggles single/double quoting of the current string.
" 
runtime switch_quotes.vim
nnoremap <silent> ,'  :call SwitchQuotesOnCurrentString()<CR>

" Set the filetype for the current buffer to JavaScript (for syntax
" highlighting), then format the current buffer as indented JSON.
"
" For visual mode, just format without setting the filetype.
"
" Note: Requires format-json.pl in ~/bin directory.
"
" @TODO get format-json.pl from Bill, this seems useful
"nnoremap ,j  :set filetype=javascript<CR>:%!perl ~/bin/format-json.pl<CR>
"xnoremap ,j  :!perl ~/bin/format-json.pl<CR>

" Edit user's vimrc and gvimrc in new tabs.
nnoremap <Leader>ev  :tabedit $MYGVIMRC<CR>:tabedit $MYVIMRC<CR>

" Make page-forward and page-backward work in insert mode.
"
imap <C-F>  <C-O><C-F>
imap <C-B>  <C-O><C-B>

" Space over to match spacing on first previous non-blank line.
" 
runtime insert_matching_spaces.vim
imap <expr> <S-Tab>  InsertMatchingSpaces()

" Keep the working line in the center of the window. This is a toggle, so you
" can bounce between centered-working-line scrolling and normal scrolling by
" issuing the keystroke again.
" 
" From this message on the MacVim mailing list:
" http://groups.google.com/group/vim_mac/browse_thread/thread/31876ef48063e487/133e06134425bda1?hl=en¿e06134425bda1
"
map <Leader>zz  :let &scrolloff=999-&scrolloff<CR>

" Load the functions used by the literal-search mappings below.
"
runtime search_enhancements.vim

" Map Control+G in command-line mode to allow the user to enter
" a string that, once the user presses Enter, will be automatically
" converted to a 'literal pattern' -- that is, a pattern with
" all metacharacters and slashes and backslashes already escaped.
"
" (See notes in GetLiteralPattern() for an explanation of why this isn't an
" <expr> mapping.)
"
cmap <C-G>  <C-R><C-R>=GetLiteralPattern()<CR>

" Search for the current visually-highlighted text. The text is automatically
" escaped as with the <C-G> cmap above.
"
" Note: This overwrites the @v register.
"
xnoremap /  "vy/<C-R><C-R>=StringToPattern(@v)<CR>
xnoremap ?  "vy?<C-R><C-R>=StringToPattern(@v)<CR>

" Tabularize on <Leader><Tab>, over highlighted text when as shch
vmap <Leader><Tab> <Esc>:'<,'>Tabularize /
noremap <Leader><Tab> <Esc>:Tabularize /

" Abbreviations
"
runtime set_abbreviations.vim


" Colors
"
colorscheme wnodom

" Groovy stuff
let groovy_highlight_all=1
let groovy_space_errors=1
let groovy_highlight_debug=1
let groovy_mark_braces_in_parens_as_errors=1


"
" Syntastic stuff
"
noremap <Leader>s :SyntasticCheck<CR>
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['javascript'] }

"
" fugitive stuff
"
autocmd BufReadPost fugitive://* set bufhidden=delete
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" end _vimrc
