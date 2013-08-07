" lzp
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

"syntax .................................................................
"开启语法高亮
syntax enable
syntax on
"颜色主题为desert
colorscheme desert


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
"set foldmethod=indent
"set foldmethod=indent
set nocompatible
set showmode
set tabstop=4
set shiftwidth=4
"colorscheme delek
"colorscheme darkblue

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Taglist
set tags+=/usr/
"let Tlist_Auto_Open=1
let Tlist_WinWidth=25
let Tlist_Auto_Update=1
let Tlist_Auto_Highlight_Tag=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Auto_Highlight_Tag=1
nmap <F10> :TlistToggle<CR>
"let Tlist_Use_Right_Window=1
" End

" File Tree
let treeExplVertical=1
let treeExplWinSize=20
nmap <F11> :VSTreeExplore<CR><C-W>L
" ENd

map <F4> <Esc>:q!<CR>

set fileencodings=ucs-bom,utf-8,gbk,default,latin1

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set nobackup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype on
  filetype plugin on
  filetype indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set smartindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Disable AutoComplPop. 
let g:acp_enableAtStartup = 0
" Use neocomplcache. 
let g:neocomplcache_enable_at_startup = 1 
" Use smartcase. 
let g:neocomplcache_enable_smart_case = 1 
" Use camel case completion. 
let g:neocomplcache_enable_camel_case_completion = 1 
" Use underbar completion. 
let g:neocomplcache_enable_underbar_completion = 1 
" Set minimum syntax keyword length. 
let g:neocomplcache_min_syntax_length = 3 
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*' 

" Define dictionary. 
let g:neocomplcache_dictionary_filetype_lists = { 
    \ 'default' : '', 
    \ 'vimshell' : $HOME.'/.vimshell_hist', 
    \ 'scheme' : $HOME.'/.gosh_completions' 
    \ } 

" Define keyword. 
if !exists('g:neocomplcache_keyword_patterns') 
    let g:neocomplcache_keyword_patterns = {} 
endif 
let g:neocomplcache_keyword_patterns['default'] = '\h\w*' 

" Plugin key-mappings. 
imap <C-k>     <Plug>(neocomplcache_snippets_expand) 
smap <C-k>     <Plug>(neocomplcache_snippets_expand) 
inoremap <expr><C-g>     neocomplcache#undo_completion() 
inoremap <expr><C-l>     neocomplcache#complete_common_string() 

" SuperTab like snippets behavior. 
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>" 

" Recommended key-mappings. 
" <CR>: close popup and save indent. 
""inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>" 
" <TAB>: completion. 
""inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" 
" <C-h>, <BS>: close popup and delete backword char. 
""inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>" 
""inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>" 
""inoremap <expr><C-y>  neocomplcache#close_popup() 
""inoremap <expr><C-e>  neocomplcache#cancel_popup() 

" AutoComplPop like behavior. 
"let g:neocomplcache_enable_auto_select = 1 

" Shell like behavior(not recommended). 
"set completeopt+=longest 
"let g:neocomplcache_enable_auto_select = 1 
"let g:neocomplcache_disable_auto_complete = 1 
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>" 
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>" 

" Enable omni completion. 
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS 
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags 
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS 
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete 
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags 

" Enable heavy omni completion. 
if !exists('g:neocomplcache_omni_patterns') 
let g:neocomplcache_omni_patterns = {} 
endif 
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::' 
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete 
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

""if has("multi_byte") " UTF-8 编码 
""	set encoding=utf-8 
""	set termencoding=utf-8 
""	set formatoptions+=mM
""	set fencs=utf-8,gbk
""	if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
""		set ambiwidth=double
""	endif
	if has("win32")
		source $VIMRUNTIME/delmenu.vim
		source $VIMRUNTIME/menu.vim
		language messages zh_CN.utf-8
	endif
"else
"	echoerr "对不起，此版本 (g)vim在编译时没有指定支持多字节文本！"
"endif

" 显示中文帮助
if version >= 603
	set helplang=cn
"	set encoding=utf-8
endif

"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
"SetTile()函数......
func SetTitle()
    if &filetype == 'sh' 
		call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: luzhiping") 
		call append(line(".")+2, "\# mail: isluzp@gmail.com") 
		call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
		call append(line(".")+4, "\#########################################################################") 
		call append(line(".")+5, "\#!/bin/bash") 
		call append(line(".")+6, "") 
	else 
		call setline(1, "\/*************************************************************************") 
		call append(line("."), "    > File Name: ".expand("%")) 
		call append(line(".")+1, "    > Author: luzhiping") 
		call append(line(".")+2, "    > Mail: isluzp@gmail.com ") 
		call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
""	if &filetype == 'cpp'
""		call append(line(".")+6, "#include<iostream>")
""		call append(line(".")+7, "using namespace std;")
""		call append(line(".")+8, "")
""	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
"新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc


"其他设置~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




"默认情况下， 在 VIM 中当光标移到一行最左边的时候， 我们继续按左键，
"光标不能回到上一行的最右边。
"同样地，光标到了一行最右边的时候，我们不能通过继续按右跳到下一行的最左边。
"但是， 通过设置 whichwrap 我们可以对一部分按键开启这项功能。
set whichwrap=b,s,<,>,[,]

"显示括号配对情况。 打开这个选项后， 当输入后括号 (包括小括号、中括号、大括号)
"的时候， 光标会跳回前括号片刻， 然后跳回来， 以此显示括号的配对情况。
set sm


" 设置当文件被改动时自动载入
set autoread

" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>


"代码补全
set completeopt=preview,menu

"不备份
set nobackup
"make 运行
set makeprg=g++\ -Wall\ \ %


"突出显示当前行
"set cursorline

"自动保存
"set autowrite
"set ruler                   " 打开状态栏标尺
"set magic                   " 设置魔术
"set guioptions-=T           " 隐藏工具栏
"set guioptions-=m           " 隐藏菜单栏


"不使用vi的键盘模式
set nocompatible

" 自动缩进
set autoindent
set cindent

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4


" 显示行号
" set number

" 历史记录数
set history=1000
"禁止生成临时文件
set nobackup
set noswapfile

" 总是显示状态行
set laststatus=2
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 侦测文件类型
filetype on

set nocp

" 搜索时在未完全输入完毕要检索的文本时就开始检索
set is


" 载入文件类型插件
filetype plugin on



" 为特定文件类型载入相关缩进文件
filetype indent on




" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
""set mouse=a
""set selection=exclusive
""set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 为C程序提供自动缩进
set smartindent

" 高亮显示普通txt文件（需要txt.vim脚本）
" au BufRead,BufNewFile *  setfiletype txt



"自动补全
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i
"function! ClosePair(char)
"	if getline('.')[col('.') - 1] == a:char
"		return "\<Right>"
"	else
"		return a:char
"	endif
"endfunction
"filetype plugin indent on 
"打开文件类型检测,加了这句才可以用智能补全
"set completeopt=longest,menu


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags的设定  
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Sort_Type = "name"    " 按照名称排序  
let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  
let Tlist_Compart_Format = 1    " 压缩方式  
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  
let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  
let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  
"autocmd FileType java set tags+=D:\tools\java\tags  
"autocmd FileType h,cpp,cc,c set tags+=D:\tools\cpp\tags  
""let Tlist_Show_One_File=1
"不同时显示多个文件的tag，只显示当前文件的
"设置tags  
set tags=tags  
"set autochdir 
"

"默认开启taglist
let Tlist_Auto_Open=1 


let g:winManagerWindowLayout='FileExplorer'
nmap wm :WMToggle<cr>

"
"" Tag list (ctags) 
"""""""""""""""""""""""""""""""" 
let Tlist_Ctags_Cmd = '/usr/bin/ctags' 
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的 
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
" minibufexpl插件的一般设置
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplModSelTarget = 1 
"
"

" Taglist
set tags+=/usr/
"let Tlist_Auto_Open=1
let Tlist_WinWidth=25
let Tlist_Auto_Update=1
let Tlist_Auto_Highlight_Tag=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Auto_Highlight_Tag=1
nmap <F10> :TlistToggle<CR>
"let Tlist_Use_Right_Window=1
" End
"
"
"
