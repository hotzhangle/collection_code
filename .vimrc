set nocompatible " 关闭 vi 兼容模式
filetype off
syntax on "	auto syntax on
syntax enable "open syntax highlight
"=======for add plugin youcompleteme=========
set rtp+=~/.vim/bundle/Vundle.vim
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
filetype plugin indent on "require
set undofile
"Set to auto read when a file is changed from the outside
if exists("&autoread")
	set autoread " auto reload file
endif
"Have the mouse enable all the time:
set mouse=v
set t_Co=256 "set terminal support 256 colors
set background=dark
"colorscheme molokai " 设定配色方案
colorscheme solarized
"colorscheme phd
set relativenumber " 显示相对行号
set number "显示行号
set showcmd "命令行显示输入的命令
set showmode "命令行显示vim当前模式
set ruler " Always show current position
set cmdheight=2 " The commandbar is 2 high
set cursorline " 突出显示当前行
set cursorcolumn "突出显示当前列
set so=7 " Set 7 lines to the curors-when moving vertical
set shiftwidth=4 " 设定\<\<和\>\>命令移动时的宽度为 4
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4 " 设定 tab 长度为 4
set nobackup " 覆盖文件时不备份
set nowb " may means no white blank
set guioptions=aAce "hide toolbar and scrollbar
setlocal noswapfile " maybe means no need to generate swap file
set autochdir " 自动切换当前目录为当前文件所在的目录
set autowrite "设置自动写入
set backupcopy=yes " 设置备份时的行为为覆盖
set ignorecase "ignore case in searches
set smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan " 禁止在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果
set hlsearch " 搜索时高亮显示被找到的文本
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码
set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
set matchtime=2 " 短暂跳转到匹配括号的时间
set magic " 设置魔术
set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set guioptions-=T " 隐藏工具栏
set guioptions-=m " 隐藏菜单栏
set report=0 "通过commands命令，告诉我们文件哪一行被改变过
set smartindent " 开启新行时使用智能自动缩进
set backspace=indent,eol,start " 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1 " 设定命令行的行数为 1
set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\  ""设置在状态行显示的信息
set foldenable " 开始折叠
set foldmethod=syntax " 设置语法折叠
set foldcolumn=0 " 设置折叠区域的宽度
au BufRead,BufNewFile \* setfiletype txt " 高亮显示普通txt文件
setlocal foldlevel=1 " 设置折叠层数为1
set viminfo+=! " save global viraberant
" set foldclose=all " 设置为自动关闭折叠
command W w !sudo tee % > /dev/null  " :W sudo saves the file (useful for handling the permission-denied)
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
"Enable filetype plugin
if has("eval") && v:version>=600
	filetype plugin on
	filetype indent on
endif
set iskeyword+=_,$,@,%,#,- " keyword chararacter will not split
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White
"Visual mode pressing * or # searches for the current selection Super useful!From an idea by Michael Naumann " return OS type, eg: windows, or linux, mac, et.st..
function! MySys()
if has("win16") || has("win32") || has("win64") || has("win95")
return "windows"
elseif has("unix")
return "linux"
endif
endfunction
" 用户目录变量$VIMFILES
if MySys() == "windows"
let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
let $VIMFILES = $HOME.'/.vim'
endif
" 设定doc文档目录
let helptags=$VIMFILES.'/doc'
" 设置字体 以及中文支持
if has("win32")
set guifont=Inconsolata:h12:cANSI
endif
" 配置多语言环境
if has("multi_byte")
" UTF-8 编码
set encoding=utf-8
set termencoding=utf-8
set formatoptions+=mM
set fenc=utf-8
set fencs=utf-8,gbk
set clipboard+=unnamed
if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
set ambiwidth=double
endif
if has("win32")
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8
endif
else
echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif
" 让 Tohtml 产生有 CSS 语法的 html " syntax/2html.vim，可以用:runtime! syntax/2html.vim
let html_use_css=1
"hilight function name
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cfunctions ctermfg=100
" Python 文件的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python map <F12> :!python %<CR>
" 打开javascript折叠
let b:javascript_fold=1
" 打开javascript对dom、html和css的支持
let javascript_enable_domhtmlcss=1
"设置字典 ~/.vim/dict/文件的路径
autocmd filetype javascript set dictionary=$VIMFILES/dict/javascript.dict
autocmd filetype css set dictionary=$VIMFILES/dict/css.dict
autocmd filetype php set dictionary=$VIMFILES/dict/php.dict
"-----------------------------------------------------------------
" plugin - bufexplorer.vim Buffers切换
let g:bufExplorerDefaultHelp=0 " Do not show default help.
let g:bufExplorerShowRelativePath=1 " Show relative paths.
let g:bufExplorerSortBy='mru' " Sort by most recently used.
let g:bufExplorerSplitRight=0 " Split left.
let g:bufExplorerSplitVertical=1 " Split vertically.
let g:bufExplorerSplitVertSize = 30 " Split width
let g:bufExplorerUseCurrentWindow=1 " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber"
"-----------------------------------------------------------------
" plugin - taglist.vim 查看函数列表，需要ctags程序 F4 打开隐藏taglist窗口
"-----------------------------------------------------------------
if MySys() == "windows" " 设定windows系统中ctags程序的位置
let Tlist_Ctags_Cmd = '"'.$VIMRUNTIME.'/ctags.exe"'
elseif MySys() == "linux" " 设定windows系统中ctags程序的位置
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
let Tlist_Show_One_File = 1 " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1 " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1 " 在右侧窗口中显示taglist窗口
let Tlist_File_Fold_Auto_Close=1 " 自动折叠当前非编辑文件的方法列表
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1
"-----------------------------------------------------------------
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" press <F3> to enable NERD_tree,then you can press key '?' to referece more " key help
" [count],cc/cu 光标以下count行逐行添加/取消注释(7,cc/cu)"[count],cm块注释(7,cm)" ,cA 在行尾插入 /* */,并且进入插入模式。" 注：count参数可选，无则默认为选中行或当前行
"-----------------------------------------------------------------
let NERDSpaceDelims=1 " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1 " 多行注释时样子更好看
"-----------------------------------------------------------------
" plugin - DoxygenToolkit.vim 由注释生成文档，并且能够快速生成函数标准注释
"-----------------------------------------------------------------
let g:DoxygenToolkit_authorName="Asins - asinsimple AT gmail DOT com"
let g:DoxygenToolkit_briefTag_funcName="yes"
"-----------------------------------------------------------------
" plugin – ZenCoding.vim 很酷的插件，HTML代码生成
"-----------------------------------------------------------------
" plugin – checksyntax.vim JavaScript常见语法错误检查" 默认快捷方式为 F5
"-----------------------------------------------------------------
let g:checksyntax_auto = 0 " 不自动检查
"-----------------------------------------------------------------
" plugin - NeoComplCache.vim 自动补全插件
"-----------------------------------------------------------------
let g:AutoComplPop_NotEnableAtStartup = 1
let g:NeoComplCache_EnableAtStartup = 1
let g:NeoComplCache_SmartCase = 1
let g:NeoComplCache_TagsAutoUpdate = 1
let g:NeoComplCache_EnableInfo = 1
let g:NeoComplCache_EnableCamelCaseCompletion = 1
let g:NeoComplCache_MinSyntaxLength = 3
let g:NeoComplCache_EnableSkipCompletion = 1
let g:NeoComplCache_SkipInputTime = '0.5'
let g:NeoComplCache_SnippetsDir = $VIMFILES.'/snippets'
" <TAB> completion.
"-----------------------------------------------------------------
" plugin - vcscommand.vim 对%命令进行扩展使得能在嵌套标签和语句之间跳转
" SVN/git管理工具
"-----------------------------------------------------------------
" plugin – a.vim
"-----------------------------------------------------------------
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
