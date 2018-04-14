language ja_JP.UTF-8 " locale 設定
set shell=/bin/sh
set nocompatible     " 互換モード解除
set t_Co=256         " 256色表示
set encoding=utf-8   " エンコーディング
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set laststatus=2     " ステータスライン表示
set showtabline=2    " タブライン表示
set list             " 不可視文字表示
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
set expandtab        " タブの代わりに空白文字を挿入する
set ignorecase       " 検索時に大文字小文字を無視 (noignorecase:無視しない)
set incsearch        " インクリメンタルサーチを行う
set hlsearch         " 検索結果ハイライト
" set nonumber         " 行番号を表示しない
set number           " 行番号を表示する
set clipboard=autoselect
set clipboard+=unnamedplus
set showmatch        "閉じ括弧が入力されたとき、対応する括弧を表示する
set whichwrap=b,s,h,l,<,>,[,] "カーソルを行頭、行末で止まらないようにする
"横幅
"set columns=120
"コマンド補完
set wildmenu
set wildmode=list:longest
set completeopt=menu,preview,menuone
set cursorline "カレント行ハイライト
set cursorcolumn
" タブの画面上での幅
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab " タブをスペースに展開する (expandtab:展開する)
set autoindent " 自動的にインデントする (noautoindent:インデントしない)
set smartindent
set backspace=indent,eol,start " バックスペースでインデントや改行を削除できるようにする
set showcmd " ステータスラインにコマンドを表示
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   " 外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない
" nmap <Esc><Esc> :nohlsearch<CR><Esc> " ESC2回押してハイライトを消す
""set autochdir
" マウス対応
set mouse=a
set ttymouse=xterm2
"
"ESCが遅い対策
if !has('gui_running')
    set notimeout
    set ttimeout
    set timeoutlen=100
endif

" スペースoで現在のバッファ以外を閉じる
nnoremap <Space>o :only<CR>

""貼付け時に自動的にpasteモードにする.putty gdi用
""http://ttssh2.sourceforge.jp/manual/ja/usage/tips/vim.html
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

" 全角スペースの表示
 " highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
 " au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
 " au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')"

" macでescで日本語入力off
if has('mac')
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  augroup MyIMEGroup
    autocmd!
    autocmd InsertLeave * :call system(g:imeoff)
  augroup END
endif

" タブ機能
nnoremap <S-Tab> gt
nnoremap <Tab><Tab> gT
for i in range(1, 9)
  execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

"" ファイルをひらいたとき最後にカーソルがあった場所にカーソルを移動する
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" C-pで0レジスタで貼り付け
vnoremap <silent> <C-p> "0p<CR>

"カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" mkdir & ln
if !isdirectory($HOME."/.vim/undo")
  call mkdir($HOME."/.vim/undo", "p")
endif
if !isdirectory($HOME."/.vim/snippets")
  !ln -s ~/dot-vim-files/snippets ~/.vim/
endif
if !isdirectory($HOME."/.vim/dict")
  !ln -s ~/dot-vim-files/dict ~/.vim/
endif

" dein.vim
source ~/dot-vim-files/plugin_settings/dein_setting.vim


" NERD-COMMENTER
" コメントした後に挿入するスペースの数
let NERDSpaceDelims = 1

"" python settings
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl expandtab tabstop=2 shiftwidth=2 softtabstop=2

" 環境依存や非公開設定ファイルの読み込み
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" インデントオン
filetype plugin indent on
filetype plugin on
syntax on " シンタックス オン
