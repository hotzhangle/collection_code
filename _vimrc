""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" 一般设定 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
syntax on           " 语法高亮  
behave mswin
filetype on " 侦测文件类型 
filetype plugin on " 载入文件类型插件 
filetype indent on " 为特定文件类型载入相关缩进文件 
set autochdir " 自动设置目录为正在编辑的文件所在的目录 
set autoindent
set autoread
set autowrite
set background=dark "背景使用黑色 
set backspace=2  
set binary
set bufhidden=hide 
set cindent
set clipboard=unnamed,autoselect,exclude:cons\|linux "set clipboard 
set cmdheight=1     " 命令行（在状态行下）的高度，设置为1  
set completeopt=preview,menu,longest
set confirm " 在处理未保存或只读文件的时候，弹出确认 
set cursorline              " 突出显示当前行
set encoding=utf-8          " 这里是配置vim内部信息的编码方式
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936 "设置编码语言
set ffs=unix,dos,mac " favor unix ff, which behaves good under bot Winz & Linux  
set fileencoding=utf-8
set fileencodings=utf-8,gbk,chinese  "  这是是配置打开文件的编码方式组合
set fillchars=vert:\ ,stl:\ ,stlnc:\  
set formatoptions=tcrqn  
set foldcolumn=0
set foldclose=all
set foldenable      " 允许折叠  
set foldlevel=3 
set foldmethod=indent " 自动折叠
set foldmethod=manual " 手动折叠
if has("gui_running")
    set guioptions+=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions+=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
    set showtabline=0 " 隐藏Tab栏
endif
imap <C-v> <ESC>"+pa 
if (has("gui_running"))  
    colo molokai  
else  
    colo molokai  
endif  
set go=             " 不要图形按钮  
set guifont=Courier_New:h13:cANSI   " 设置字体  
set gdefault
set helplang=eg
set history=100 " history文件中需要记录的行数 
set hlsearch "搜索逐字符高亮
set ignorecase "搜索忽略大小写
set incsearch "行内替换
set iskeyword+=_,$,@,%,#,- " 带有如下符号的单词不要被换行分割 
set langmenu=zh_CN.utf-8  
set laststatus=1    " 启动显示状态行(1),总是显示状态行(2)  
"set laststatus=2
set lines=40 columns=155    " 设定窗口大小  
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$  
set linespace=0  
set magic                   " 设置魔术
set matchtime=5  
set mouse=a  
set nohlsearch  
set noerrorbells  
set novisualbell    " 不要闪烁(不明白)  
set nocompatible "不要使用vi的键盘模式，而是vim自己的 
set noexpandtab " 不要用空格代替制表符
set noeb
set number " 显示行号
set nobackup "禁止生成临时文件
set noswapfile
set report=0  
set ruler                   " 打开状态栏标尺
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)  
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set selection=exclusive  
set selectmode=mouse,key  
set shiftwidth=4
set showcmd         " 输入的命令显示出来，看的清楚些  
set showmatch  
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
set smarttab " 在行和段开始处使用制表符
set smartindent  
set softtabstop=4
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}  "状态行显示的内容  
set laststatus=2 "显示状态栏(默认值为1, 无法显示状态栏) 
set statusline= 
set statusline+=%2*%-3.3n%0*\ " buffer number 
set statusline+=%f\ " file name 
set statusline+=%h%1*%m%r%w%0* " flag 
set statusline+=[ 
if v:version >= 600 
    set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype 
    set statusline+=%{&fileencoding}, " encoding 
endif 
set statusline+=%{&fileformat}] " file format 
set statusline+=%= " right align 
"set statusline+=%2*0x%-8B\ " current char 
set statusline+=0x%-8B\ " current char 
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset 
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim")) 
    set statusline+=\ %{VimBuddy()} " vim buddy 
endif 
"状态行颜色 
highlight StatusLine guifg=SlateBlue guibg=Yellow 
highlight StatusLineNC guifg=Gray guibg=White
set tabstop=4 " 统一缩进为4
set tags=tags  
set tags+=E:\study\code\hqcode\tags
set tags+=E:\study\my\ coding\python\tags
set termencoding=utf-8
set viminfo+=!  " 保存全局变量 
set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
set wildmenu  
set wrap  
autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
autocmd InsertEnter * se cul    " 用浅色高亮当前行  
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
autocmd FileType h,cpp,cc,c,java " quickfix模式
au GUIEnter * simalt ~x " 窗口启动时自动最大化
au BufRead,BufNewFile * setfiletype txt  " 高亮显示普通txt文件（需要txt.vim脚本）  
highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white " 状态行颜色 
highlight StatusLine guifg=SlateBlue guibg=Yellow 
highlight StatusLineNC guifg=Gray guibg=White 
:match OverLength '\%101v.*' " 高亮字符，让其不受100列限制 
let g:mapleader = ";"
let localmapleader = ";"
language messages zh_CN.utf-8  "解决console输出乱码  
let Tlist_Sort_Type = "name"    " 按照名称排序  
let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  
let Tlist_Compart_Format = 1    " 压缩方式  
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  
let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  
let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  
let Tlist_Ctags_Cmd='/usr/bin/ctags'  
let g:winManagerWindowLayout='FileExplorer|TagList'  
let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的
map <M-F2> :tabnew<CR>  "新建标签  
map <C-F3> \be  "打开树状文件目录  
map <F3> :tabnew .<CR>  
map <F6> :call CompileRunGpp()<CR>  
map <F8> :call RunPython()<CR>  
map <CR><o>:browse confirm e<CR>
nmap wm :WMToggle<cr>  
nmap <c-s> :w<CR>  
nnoremap <F2> :g/^\s*$/d<CR> "去空行  
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> 
nnoremap <C-F2> :vert diffsplit "比较文件  
imap <c-s> <Esc>:w<CR>a
setlocal noswapfile 
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
vmap <C-c> "+yi 
vmap <C-x> "+c 
vmap <C-v> c<ESC>"+p 
winpos 5 5          " 设定窗口位置  
"colorscheme murphy
""""""""""""""""""""""""""" 
"定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: zhangle") 
        call append(line(".")+2, "\# mail: hotzhangle@hotmail.com") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "\#########################################################################") 
        call append(line(".")+5, "\#!/bin/bash") 
        call append(line(".")+6, "") 
    elseif &filetype == 'py'
        call setline(1,"\#########################################################################") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author: zhangle") 
        call append(line(".")+2, "    > Mail: hotzhangle@hotmail.com ") 
        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc 
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white 
:match OverLength '\%101v.*' 
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
func! CompileRunGcc()  
    exec "w"  
    exec "!gcc % -o %<"  
    exec "! ./%<"  
endfunc  
" C++的编译和运行  
func! CompileRunGpp()  
    exec "w"  
    exec "!g++ % -o %<"  
    exec "! ./%<"  
endfunction  
" Python的运行  
func! RunPython()   
    let mp = &makeprg   
    let ef = &errorformat   
    let exeFile = expand("%:t")   
    setlocal makeprg=python\ -u   
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m   
    silent make %   
    copen   
    let &makeprg     = mp   
    let &errorformat = ef   
endfunction   
"""""""""""""""""""""""""""""""""""""""NERDTree plugin"""""""""""""""""""""""""""""""""""""""""
"NERDTree plugin
let NERDTreeWinPos = "left" "where NERD tree window is placed on the screen  
let NERDTreeWinSize =  25 "size of the NERD tree  
nmap <F8> <ESC>:NERDTreeToggle<RETURN>" Open and close the NERD_tree.vim separately
"""""""""""""""""""""""""""""""""""""""NERDTree plugin"""""""""""""""""""""""""""""""""""""""""
