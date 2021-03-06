"---------------------------------------------------------------------------
" フォント設定:
"
if has('win32')
  " Windows用
  set guifont=Ricty:h18:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=Ricty:h21
  map ¥ <leader>
elseif has('xfontset')
  set guifont=Ricty:h18
elseif has('unix')
  set guifont=Ricty\ 15
endif

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
" ウインドウの幅
set columns=120
" ウインドウの高さ
set lines=40
" コマンドラインの高さ(GUI使用時)
set cmdheight=1

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"

" IME ON時のカーソルの色を設定(設定例:紫)
highlight CursorIM guibg=Purple guifg=NONE
" 挿入モード・検索モードでのデフォルトのIME状態設定
set iminsert=0 imsearch=0
if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
endif

" 挿入モードでのIME状態を記憶させない場合
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

"---------------------------------------------------------------------------
" Menu Setting
"
set guioptions=gei

"---------------------------------------------------------------------------
" Mouse Setting
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a


"MacVim固有設定
if has('gui_macvim')
    set showtabline=1   " only if there at least two tab pages
    set antialias
endif

syntax enable
set background=dark
colorscheme solarized

"let &transparency = 10
"let g:transparency = &transparency
" nnoremap <Esc><Esc> :<C-u>let &transparency = g:transparency<Cr><C-l>
highlight SpecialKey term=underline ctermfg=DarkGreen guifg=DarkGreen

" gitgutterのエリアの背景色をクリア用
highlight clear SignColumn
