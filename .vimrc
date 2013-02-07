" =================================================
" NeoBundleでの初期設定"
" =================================================
" NeoBundleの初期設定
" mkdir ~/.bundle
" NeoBundleは git clone git://github.com/Shougo/neobundle.vim.git ~/.vim/neobundle.vim しておく
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

let OSTYPE = system("uname")

" NeoBundle
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'

" neocomplcacehe
NeoBundle 'Shougo/neocomplcache'
" neocomplcaceheを有効にする
let g:neocomplcache_enable_at_startup = 1
" 辞書補完
let g:neocomplcache_dictionary_filetype_lists = {
   \ 'default' : '',
   \ 'css' : $HOME.'/.vim/dict/css.dict',
   \ 'less' : $HOME.'/.vim/dict/css.dict',
   \ 'sass' : $HOME.'/.vim/dict/css.dict',
   \ }
" neocomplcacheのオムニ補完
autocmd FileType css,less,sass setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"Python は jedi を使う autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" neocomplcache
" ネオコンのスニペット展開
NeoBundle 'Shougo/neosnippet'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" ()[]{}""''などを挿入したら自動的に中へ
NeoBundle 'kana/vim-smartinput'
inoremap << <><LEFT>
inoremap {% {%<Space><Space>%}<LEFT><LEFT><LEFT>

" template
autocmd BufNewFile *.py 0r $HOME/.vim/templates/template.py

" coffeescript
NeoBundle 'kchmck/vim-coffee-script'
autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!

" JScomplete
NeoBundle 'teramako/jscomplete-vim'
autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
let g:jscomplete_use = ['dom']

" vim-color-solarized
NeoBundle 'altercation/vim-colors-solarized'
set background=dark
let g:solarized_termcolors=16
colorscheme solarized

" jedi
NeoBundle 'davidhalter/jedi-vim'
let g:jedi#auto_initialization = 1
let g:jedi#rename_command = "<leader>r"
let g:jedi#popup_on_dot = 1
autocmd FileType python let b:did_ftplugin = 1
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" NERDTree
NeoBundle 'scrooloose/nerdtree'
nmap <F9> :NERDTreeToggle

" unite.vim
NeoBundle 'Shougo/unite.vim'
" 入力モードで開始する
let g:unite_enable_start_insert=0
" バッファ一覧
noremap <C-U><C-B> :Unite buffer<CR>
" ファイル一覧
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
" 最近使ったファイルの一覧
noremap <C-U><C-R> :Unite file_mru<CR>
" レジスタ一覧
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
" ファイルとバッファ
noremap <C-U><C-U> :Unite buffer file_mru<CR>
" 全部
noremap <C-U><C-A> :UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'kana/vim-fakeclip'

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

" =================================================
" 通常設定
" =================================================
syntax on
filetype plugin on
set encoding=utf-8
" 256色モード
set t_Co=256

set viminfo='20,<50,s10,h,! " YankRing用に!を追加
set shellslash              " Windowsでディレクトリパスの区切り文字に / を使えるようにする
set lazyredraw              " マクロなどを実行中は描画を中断
set clipboard=unnamed,autoselect  " OSのクリップボードを使う。

" タブ周り
" tabstopはTab文字を画面上で何文字分に展開するか
" shiftwidthはcindentやautoindent時に挿入されるインデントの幅
" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=4 shiftwidth=4 softtabstop=0
set expandtab              " タブを空白文字に展開
set autoindent smartindent " 自動インデント，スマートインデント

" 入力補助
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set formatoptions+=m           " 整形オプション，マルチバイト系を追加

" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

" コマンド補完
set wildmenu           " コマンド補完を強化
set wildmode=list:full " リスト表示，最長マッチ

" 検索関連
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

" ファイル関連
"set nobackup   " バックアップを取らない
"set autoread   " 他で書き換えられたら自動で読み直す
"set noswapfile " スワップファイル作らない
set directory=/tmp
set hidden     " 編集中でも他のファイルを開けるようにする

" 表示関連
set showmatch         " 括弧の対応をハイライト
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
set wrap              " 画面幅で折り返す
set notitle           " タイトル書き換えない
set scrolloff=5       " 行送り

" 不可視文字表示
set list                    " 不可視文字表示
" タブと末尾の空白を表示し、開業は表示しない
set listchars=tab:▸\ ,trail:_
" ステータスライン関連
set laststatus=2

" エンコーディング関連
set ffs=unix,dos,mac " 改行文字

" 文字コードの自動認識
" 適当な文字コード判別
set termencoding=utf-8
set encoding=utf-8
set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp

" UTF-8の□や○でカーソル位置がずれないようにする
set ambiwidth=double

set showmode
set ruler
set showtabline=2

map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" ハイライトをEscで抜ける
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" shift-tab で次のタブ
nnoremap <S-Tab> gt
" tab-tab で前のタブ
nnoremap <Tab><Tab> gT
" tab-数字 でそのタブ
for i in range(1, 9)
    execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

" メモ
" see: 秒速でvimでメモを書く条件 http://tekkoc.tumblr.com/post/41943190314/vim
" TODOファイル
command! Todo edit ~/Dropbox/memo/todo.txt
" 一時ファイル
command! -nargs=1 -complete=filetype Tmp edit ~/.vim_tmp/tmp.<args>
command! -nargs=1 -complete=filetype Temp edit ~/.vim_tmp/tmp.<args>
