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

" jedi
NeoBundle 'davidhalter/jedi-vim'
let g:jedi#auto_initialization = 1
let g:jedi#rename_command = "<leader>r"
let g:jedi#popup_on_dot = 1
autocmd FileType python let b:did_ftplugin = 1
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

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

" VimFiler
NeoBundle 'Shougo/vimfiler'
"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1

" NERDTree やめてvimfilerに変更
"NeoBundle 'scrooloose/nerdtree'
"nmap <F9> :NERDTreeToggle

" XMLとかHTMLとかの編集機能を強化する
NeoBundle 'xmledit'

" ソースコード上のメソッド宣言、変数宣言の一覧を表示
NeoBundle 'taglist.vim'
set tags=tags
" macのctagsはhomebrewで入れたやつを使う
if has('mac')
  let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
endif
" 現在表示中のファイルのみのタグしか表示しない
let Tlist_Show_One_File = 1
" 右側にtag listのウインドうを表示する
let Tlist_Use_Right_Window = 1
" taglistのウインドウだけならVimを閉じる
let Tlist_Exit_OnlyWindow = 1
" \lでtaglistウインドウを開いたり閉じたり出来るショートカット
map <silent> <leader>l :TlistToggle<CR>

" ステータスラインをカッコよくする
NeoBundle 'Lokaltog/vim-powerline'

" fで次々移動できるようにする
" http://mba-hack.blogspot.jp/2013/01/vim4.html
NeoBundle 'rhysd/clever-f.vim'

" ; で移動先をハイライトする
" http://blog.remora.cx/2012/08/vim-easymotion.html
" http://d.hatena.ne.jp/osyo-manga/20110614/1308037854
NeoBundle 'Lokaltog/vim-easymotion'
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" Space連打 + w, e, b, ge にマッピング
let g:EasyMotion_leader_key = '<Space><Space>'
" 1 ストローク選択を優先する
" let g:EasyMotion_grouping=1

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
" colorschemeの設定。NoeBundleの最後で設定する
" =================================================

" vim-color-solarized
NeoBundle 'altercation/vim-colors-solarized'

syntax enable
set background=dark
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_termtrans=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

" colorscheme
" NeoBundle 'w0ng/vim-hybrid'
" colorscheme hybrid

" =================================================
" 通常設定
" =================================================
filetype plugin on
set encoding=utf-8

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
" タブと末尾の空白を表示し、改行は表示しない
set listchars=tab:▸\ ,trail:_
" set listchars=eol:¬,tab:▸\ ,trail:_
" highlight SpecialKey term=underline ctermfg=darkgray guifg=darkgray

" 現在の行の色を変える
set cursorline

" ステータスライン関連
set laststatus=2

" エンコーディング関連
set ffs=unix,dos,mac " 改行文字

" 文字コードの自動認識
" 適当な文字コード判別
set termencoding=utf-8
set encoding=utf-8
set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp

if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632') " I couldn't use has('mouse_sgr') :-(
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

" UTF-8の□や○でカーソル位置がずれないようにする
set ambiwidth=double

set showmode
set ruler
set showtabline=2

map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" ハイライトをEscで抜ける
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

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

