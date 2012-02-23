" _gvimrc
"
" GUI-only Vim settings.
"

set guioptions-=b      " de-activate the bottom scrollbar
set guioptions-=r      " de-activate the right scrollbar
set guioptions-=T      " de-activate the toolbar

set guicursor+=v:ver35 " Keep the cursor from obscuring visual selections

set guitablabel=%t\ %m " GUI tab labels to show filename and modified flag
set guitabtooltip=%F   " GUI tab tooltips to show the full pathname

set showtabline=1      " Sometimes show the tab line
set tabpagemax=100     " Allow many more files to be opened in tabs

" Note: If you want to control the width of the tabs in MacVim (the OS X
" Cocoa GUI version of Vim), then use these commands from the Terminal:
"
"   defaults write org.vim.MacVim MMTabMinWidth     250
"   defaults write org.vim.MacVim MMTabOptimumWidth 350
"   defaults write org.vim.MacVim MMTabMaxWidth     500
"
" The values are in pixels. Adjust as necessary for your environment.
"

" Avoid all beeping and flashing by turning on the visual bell, and then
" setting the visual bell to nothing.
"
" Note: Even if t_vb is set in vimrc, it has to be set again here, as it's
" reset when the GUI starts.
"
set vb t_vb=


"
" Fonts, window size/position
"

if has("gui_mac")

    " Workaround to improve text drawing under OS X. (Applicable to Carbon
    " gVim, but not MacVim.) See :h macatsui for details.
    "
    if exists('&macatsui')
        set nomacatsui
    endif
endif

if has("gui_macvim")
    " Set the antialias, linespace, and guifont together, since different
    " fonts look better with different settings. (These can be set separately,
    " but it's just more convenient to keep them together like this.)
    " 
    set antialias linespace=0 guifont=Consolas:h15
    "set antialias linespace=1 guifont=Inconsolata:h16
    "set antialias linespace=2 guifont=Monaco:h13
    "set antialias guifont=Andale_Mono:h14
    "set noantialias guifont=Fixedsys_True_Type_Font:h15

    set lines=45 columns=100

    set fuoptions=maxvert,maxhorz

endif


" end _gvimrc
