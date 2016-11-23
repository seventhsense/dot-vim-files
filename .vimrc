language ja_JP.UTF-8 " locale 設定
set shell=/bin/sh
set nocompatible     " 互換モード解除
set t_Co=256         " 256色表示
set encoding=utf-8   " エンコーディング
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set laststatus=2     " ステータスライン表示
set showtabline=2    " ステータスライン表示
set list             " 不可視文字表示
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
set expandtab        " タブの代わりに空白文字を挿入する
set ignorecase       " 検索時に大文字小文字を無視 (noignorecase:無視しない)
set incsearch        " インクリメンタルサーチを行う
set hlsearch         " 検索結果ハイライト
" set nonumber         " 行番号を表示しない
set number           " 行番号を表示する
set clipboard=autoselect
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
set backupdir=$HOME/.vim/backup "バックアップ
" ESC2回押してハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"シンタックス
syntax on

" mkdir
if !isdirectory("~/.vim/backup")
  call mkdir("~/.vim/backup", "p")
endif

if !isdirectory("~/.vim/undo")
  call mkdir("~/.vim/undo", "p")
endif

"ESCが遅い対策
if !has('gui_running')
    set notimeout
    set ttimeout
    set timeoutlen=100
endif
" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j
inoremap <silent> kk <ESC>
inoremap <silent> <C-k> k

"Emacs風移動
noremap <C-a> <Home>
noremap <C-e> <End>
noremap <C-d> <Del>

"emacs風移動
"単語単位移動（行末で止まる必要がない場合）
inoremap <silent> <C-b> <S-Left>
inoremap <silent> <C-w> <S-Right>
"行頭へ
inoremap <silent> <C-a> <C-r>=MyJumptoBol('　。、．，／！？「」')<CR>
"行末へ
inoremap <silent> <C-e> <C-r>=MyJumptoEol('　。、．，／！？「」')<CR>
"現在行をインデント
inoremap <silent> <Tab>   <C-g>u<C-t>
inoremap <silent> <S-Tab> <C-g>u<C-d>

"undo
inoremap <silent> <C-u> <C-g>u<C-r>=MyExecExCommand('undo', 'onemore')<CR>

"新行挿入
inoremap <silent> <C-o> <C-g>u<C-r>=MyExecExCommand("call cursor(line('.'), col('$'))")<CR><CR>

"スペースoで現在のバッファ以外を閉じる
nnoremap <Space>o :only<CR>
""マウス対応
set mouse=a
set ttymouse=xterm2

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
 highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
 au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
 au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')"

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

"" dein.vim
" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/dot-vim-files')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

""smartchr設定
""inoremap <expr> = smartchr#one_of('=',' = ', ' == ', ' === ')

""set autochdir

""unite-ref-ri
" noremap :rr :<C-u>Unite ref/ri<CR>

" yankring_historyのディレクトリ設定
"let g:yankring_history_dir = expand('$HOME')
"let g:yankring_history_file = '/.vim/yankring_history'

" NERD-COMMENTER
""コメントした後に挿入するスペースの数
let NERDSpaceDelims = 1

"" vim-coffee-script
" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

"" vim-less
au BufRead,BufNewFile *.less		set filetype=less

au FileType ruby,eruby setl tags+=~/gtags

""vim-eco
autocmd BufNewFile,BufRead *.eco set filetype=eco

""filetype cucumber
au BufRead,BufNewFile *_steps.rb            set filetype=cucumber.ruby

""filetype snippet
au BufRead,BufNewFile,BufReadPre *.snip set filetype=snippet

"tags
"ctrl + [のとき選択できるようにする
" tagsジャンプの時に複数ある時は一覧表示                                        
" nnoremap <C-]> g<C-]> 

""保存時にtagsを実行
" autocmd BufWrite * :TagsGenerate

"------------------------------------
" jasmine.vim
"------------------------------------
" ファイルタイプを変更
function! JasmineSetting()
  au BufRead,BufNewFile *Helper.js,*Spec.js  set filetype=jasmine.javascript
  au BufRead,BufNewFile *Helper.coffee,*Spec.coffee  set filetype=jasmine.coffee
  au BufRead,BufNewFile,BufReadPre *Helper.coffee,*Spec.coffee  let b:quickrun_config = {'type' : 'coffee'}
  call jasmine#load_snippets()
  map <buffer> <leader>m :JasmineRedGreen<CR>
  command! JasmineRedGreen :call jasmine#redgreen()
  command! JasmineMake :call jasmine#make()
endfunction
au BufRead,BufNewFile,BufReadPre *.coffee,*.js call JasmineSetting()

""""""""""""""""""""""""""""""
"sepが空でなければ、sepをセパレータとしてジャンプ。
"見つからなければ見かけの行頭へ。
"カーソル位置が見かけの行頭の場合は真の行頭へ。
""""""""""""""""""""""""""""""
function! MyJumptoBol(sep)
  if col('.') == 1
    call cursor(line('.')-1, col('$'))
    call cursor(line('.'), col('$'))
    return ''
  endif
  if matchend(strpart(getline('.'), 0, col('.')), '[[:blank:]]\+') >= col('.')-1
    silent exec 'normal! 0'
    return ''
  endif
  if a:sep != ''
    call search('[^'.a:sep.']\+', 'bW', line("."))
    if col('.') == 1
      silent exec 'normal! ^'
    endif
    return ''
  endif
  exec 'normal! ^'
  return ''
endfunction

""""""""""""""""""""""""""""""
"sepが空でなければ、sepをセパレータとしてジャンプ。
"見つからなければ行末へ。
""""""""""""""""""""""""""""""
function! MyJumptoEol(sep)
  if col('.') == col('$')
    silent exec 'normal! w'
    return ''
  endif

  if a:sep != ''
    let prevcol = col('.')
    call search('['.a:sep.']\+[^'.a:sep.']', 'eW', line("."))
    if col('.') != prevcol
      return ''
    endif
  endif
  call cursor(line('.'), col('$'))
  return ''
endfunction

""""""""""""""""""""""""""""""
"IMEの状態とカーソル位置保存のため<C-r>を使用してコマンドを実行。
""""""""""""""""""""""""""""""
function! MyExecExCommand(cmd, ...)
  let saved_ve = &virtualedit
  let index = 1
  while index <= a:0
    if a:{index} == 'onemore'
      silent setlocal virtualedit+=onemore
    endif
    let index = index + 1
  endwhile

  silent exec a:cmd
  if a:0 > 0
    silent exec 'setlocal virtualedit='.saved_ve
  endif
  return ''
endfunction

"" C-pで0レジスタで貼り付け
vnoremap <silent> <C-p> "0p<CR>

" 環境依存や非公開設定ファイルの読み込み
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

"" autoprefixer
" vnoremap ap : <c-u>call PrefixVisualMyCSS()<cr>
" nnoremap ap : <c-u>call PrefixMyCSS()<cr>
" command! Prefix call PrefixMyCSS()

"" python settings
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl expandtab tabstop=2 shiftwidth=2 softtabstop=2

" * での検索や text-object 等での選択時に - で切らない
setlocal iskeyword& iskeyword+=-
