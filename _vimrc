""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" 一般设定 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
syntax on           " 语法高亮
syntax enable "open syntax highlight  
filetype off " 侦测文件类型 
"=======for add plugin youcompleteme=========
set rtp+=$VIM\vimfiles\bundle\vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'OnSyntaxChange'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-rails.git'
Plugin 'rstacruz/sparkup',{'rtp':'vim/'}
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'gcmt/wildfire.vim'
Plugin 'Mizuchi/STL-Syntax.git'
Plugin 'nathanaelkane/vim-indent-guides.git'
Plugin 'yegappan/grep.git'
Plugin 'mileszs/ack.vim'
Plugin 'dyng/ctrlsf.vim.git'
Bundle 'ctrlp.vim'
Bundle 'AutoClose'
Bundle 'ZenCoding.vim'
Bundle 'matchit.zip'
Bundle '_jsbeautify'
Bundle 'EasyMotion'
Bundle 'FencView.vim'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
Plugin 'scrooloose/nerdcommenter'
call vundle#end()
behave mswin
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
set cursorcolumn "突出显示当前列
set so=7
set encoding=utf-8          " 这里是配置vim内部信息的编码方式
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936 "设置编码语言
set noundofile "noundofile
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
    set showtabline=2 " 隐藏Tab栏
endif
"imap <C-v> <ESC>"+pa 
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
set relativenumber "显示相对行号
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
set showmode 
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
nnoremap <C-F2> :vert diffsplit "比较文件  
setlocal noswapfile 
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
winpos 5 5          " 设定窗口位置  
" --------------mapping-----------------------------
"Set mapleader set mapleader must be ahead of all mapping action
let mapleader = ";"
let g:mapleader = ";"
"Fast reloading of the .vimrc
nmap <leader>ss :w!<cr>:source ~/.vimrc<cr>
"Fast editing of .vimrc
nmap <leader>ee :e! ~/.vimrc<cr>
nmap <silent> <Leader>i <Plug>IndentGuidesToggle
nmap <leader>s :,s///g
nmap <leader>p : set paste<CR>
nmap <leader>pp :set nopaste<CR>
map <silent> <leader><cr> :noh<cr>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" Tab操作快捷方式!
nnoremap <C-TAB> :tabnext<CR>
nnoremap <C-S-TAB> :tabprev<CR>
"关于tab的快捷键
 map tn :tabnext<cr>
 map tp :tabprevious<cr>
 map td :tabnew .<cr>
 map te :tabedit
map tc :tabclose<cr>
" F3 NERDTree 切换
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>
" plugin - matchit.vim 对%命令进行扩展使得能在嵌套标签和语句之间跳转" % 正向匹配 g% 反向匹配
"窗口分割时,进行切换的按键热键需要连接两次,比如从下方窗口移动"光标到上方窗口,需要<c-w><c-w>k,非常麻烦,现在重映射为<c-k>,切换的"时候会变得非常方便.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent><F4> :TlistToggle<CR>
"一些不错的映射转换语法（如果在一个文件中混合了不同语言时有用）
nnoremap <leader>1 :set filetype=xhtml<CR>
nnoremap <leader>2 :set filetype=css<CR>
nnoremap <leader>3 :set filetype=javascript<CR>
nnoremap <leader>4 :set filetype=php<CR>
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
map <leader>da :DoxAuthor<CR>
map <leader>df :Dox<CR>
map <leader>db :DoxBlock<CR>
map <leader>dc a /* */<LEFT><LEFT><LEFT>
set fileformats=unix,dos,mac
" nmap <leader>fd :se fileformat=dos<CR>
" nmap <leader>fu :se fileformat=unix<CR>
" use Ctrl+[l|n|p|cc] to list|next|previous|jump to count the result
 map <C-x>l <ESC>:cl<CR>
 map <C-x>n <ESC>:cn<CR>
 map <C-x>p <ESC>:cp<CR>
 map <C-x>c <ESC>:cc<CR>
 "[% 定位块首 ]% 定位块尾
" --------------mapping-----------------------------
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
