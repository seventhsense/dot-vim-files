"互換モード解除
set nocompatible
"256色表示
set t_Co=256 
"ステータスライン表示
set laststatus=2
"ステータスライン表示
set showtabline=2
"タブの代わりに空白文字を挿入する
set expandtab
"" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
"インクリメンタルサーチを行う
set incsearch
" 検索結果ハイライト
set hlsearch
" " ESC2回押してハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"行番号を表示する
set number
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"横幅
""set columns=120
"シンタックス
syntax on
"コマンド補完
set wildmenu
set wildmode=list:longest
set completeopt=menu,preview,menuone

"十字キ <Up>
""imap ーの入力を受け付ける
""imap  <Down>
""imap  <Right>
""imap <Left>
"ESCが遅い対策
if !has('gui_running')
    set notimeout
    set ttimeout
    set timeoutlen=100
endif

" タブの画面上での幅
 set tabstop=2
 set shiftwidth=4
 set smarttab
" " タブをスペースに展開しない (expandtab:展開する)
 set expandtab
" " 自動的にインデントする (noautoindent:インデントしない)
 set autoindent
 set smartindent
" " バックスペースでインデントや改行を削除できるようにする
 set backspace=indent,eol,start
 "" ステータスラインにコマンドを表示
set showcmd

"入力モード時、ステータスラインのカラーを変更
""augroup InsertHook
""autocmd!
""autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
""autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
""augroup END
""マウス対応
set mouse=a
set ttymouse=xterm2
""バックアップ
set backupdir=$HOME/.backup
""空行追加
""nnoremap O :<C-u>call append(expand('.'), '')<Cr>j


filetype plugin indent off     " required!

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	call neobundle#rc(expand('~/.vim/bundle/'))
endif
" let NeoBundle manage NeoBundle
" required! 
NeoBundle 'Shougo/neobundle.vim'
" recommended to install
NeoBundle 'Shougo/vimproc'
" after install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'

"Your Bundles here
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'AutoClose'
NeoBundle 'tpope/vim-rails'
NeoBundle 'surround.vim'
NeoBundle 'The-NERD-Commenter'
NeoBundle 'trinity.vim'
NeoBundle 'taglist.vim'
NeoBundle 'ZenCoding.vim'
NeoBundle 'The-NERD-tree'
NeoBundle 'Source-Explorer-srcexpl.vim'
NeoBundle 'vim-scripts/rails.vim'
NeoBundle 'ctags.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'smartchr'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'ruby.vim'
NeoBundle 'vim-coffee-script'
NeoBundle 'Vim-Rspec'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'basyura/unite-rails'
NeoBundle "tomasr/molokai"
NeoBundle "tsaleh/vim-matchit"
NeoBundle 'desert256.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'closetag.vim'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'taka84u9/vim-ref-ri'
NeoBundle 'pasela/unite-webcolorname'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'hallettj/jslint.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'sudo.vim'
" ...
filetype plugin indent on     " required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"

colorscheme desert256

"------------------------------------
" neocomplecache.vim
"------------------------------------
" " AutoComplPopを無効にする
" let g:acp_enableAtStartup = 0
" NeoComplCacheを有効にする
let g:neocomplcache_enable_at_startup = 1
" smarrt case有効化。 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" camel caseを有効化。大文字を区切りとしたワイルドカードのように振る舞う
let g:neocomplcache_enable_camel_case_completion = 1
" _(アンダーバー)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
" シンタックスをキャッシュするときの最小文字長を3に
let g:neocomplcache_min_syntax_length = 3
" neocomplcacheを自動的にロックするバッファ名のパターン
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" -入力による候補番号の表示
let g:neocomplcache_enable_quick_match = 1
" 補完候補の一番先頭を選択状態にする(AutoComplPopと似た動作)
let g:neocomplcache_enable_auto_select = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scala' : $HOME.'/.vim/bundle/vim-scala/dict/scala.dict',
    \ 'java' : $HOME.'/.vim/dict/java.dict',
    \ 'c' : $HOME.'/.vim/dict/c.dict',
    \ 'cpp' : $HOME.'/.vim/dict/cpp.dict',
    \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
    \ 'ocaml' : $HOME.'/.vim/dict/ocaml.dict',
    \ 'perl' : $HOME.'/.vim/dict/perl.dict',
    \ 'php' : $HOME.'/.vim/dict/php.dict',
    \ 'scheme' : $HOME.'/.vim/dict/scheme.dict',
    \ 'vm' : $HOME.'/.vim/dict/vim.dict'
    \ }

" Define keyword.
 if !exists('g:neocomplcache_keyword_patterns')
 let g:neocomplcache_keyword_patterns = {}
 endif
 let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" ユーザー定義スニペット保存ディレクトリ
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'

" スニペット
imap <silent>,, <Plug>(neocomplcache_snippets_expand)
smap <silent>,, <Plug>(neocomplcache_snippets_expand)

" 補完を選択しpopupを閉じる
inoremap <expr><C-y> neocomplcache#close_popup()
" 補完をキャンセルしpopupを閉じる
inoremap <expr><C-e> neocomplcache#cancel_popup()
" TABで補完できるようにする
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" undo
inoremap <expr><C-g>     neocomplcache#undo_completion()
" 補完候補の共通部分までを補完する
inoremap <expr><C-l> neocomplcache#complete_common_string()
" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" C-kを押すと行末まで削除
inoremap <C-k> <C-o>D
" C-nでneocomplcache補完
inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
" 補完候補が出ていたら確定、なければ改行
""inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-x><C-o> &filetype == 'vim' ? "\<C-x><C-v><C-p>" : neocomplcache#manual_omni_complete()

" FileType毎のOmni補完を設定
autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript set omnifunc=jscomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
""autocmd FileType ruby set omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
""let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" for ZenCoding.vim
let g:user_zen_settings = {
\ 'lang': 'ja'
\}
let g:use_zen_complete_tag = 1




"" unite
" 入力モードで開始
let g:unite_enable_start_insert=1

"mru,reg,buf
noremap :um :<C-u>Unite file_mru -buffer-name=file_mru<CR>
noremap :: :<C-u>Unite file_mru -buffer-name=file_mru<CR>
noremap :ur :<C-u>Unite register -buffer-name=register<CR>
noremap :ub :<C-u>Unite buffer -buffer-name=buffer<CR>

"file current_dir
noremap :ufc :<C-u>Unite file -buffer-name=file<CR>
noremap :ufcr :<C-u>Unite file_rec -buffer-name=file_rec<CR>

"file file_current_dir
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
noremap :@ :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
noremap :uffr :<C-u>UniteWithBufferDir file_rec -buffer-name=file_rec<CR>
""line
noremap :ul :<C-u>Unite line<CR>
noremap :; :<C-u>Unite line<CR>

" c-jはescとする
au FileType unite nnoremap <silent> <buffer> <c-j> <esc><CR>

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"" surround
"------------------------------------
" surround.vim
"------------------------------------
" s, ssで選択範囲を指定文字でくくる
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround


"" Source Explorer
"自動でプレビューを表示する。TODO:うざくなってきたら手動にする。またはソースを追う時だけ自動に変更する。
let g:SrcExpl_RefreshTime   = 1
"プレビューウインドウの高さ
let g:SrcExpl_WinHeight     = 9
"tagsは自動で作成する
let g:SrcExpl_UpdateTags    = 1
"マッピング
let g:SrcExpl_RefreshMapKey = "<Space>"
let g:SrcExpl_GoBackMapKey  = "<C-b>"
nmap <F8> :SrcExplToggle<CR>

"" trinity
" Open and close all the three plugins on the same time
nmap <F6>   :TrinityToggleAll<CR>
" Open and close the srcexpl.vim separately
nmap <F4>   :TrinityToggleSourceExplorer<CR>
" Open and close the taglist.vim separately
nmap <F5>  :TrinityToggleTagList<CR>
" Open and close the NERD_tree.vim separately
nmap <F2>  :TrinityToggleNERDTree<CR> 

"NERD_tree.vim
""---------------------
""nnoremap <f2> :NERDTreeToggle<CR>
""最後に残ったウィンドウがNERDTREEのみのときはvimを閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeDirArrows=0
let g:NERDTreeMouseMode=0

""smartchr設定
inoremap <expr> = smartchr#one_of('=',' = ', ' == ', ' === ')

""Powerline設定
"let g:Powerline_symbols  =  'fancy'

"" vim-ref
let $PATH = $PATH . ':/opt/local/bin' 
let g:ref_rubyreference_path = '~/Documents/Reference/rubyrefm'
let g:ref_rubyreference_cmd = 'w3m -dump %s'

"""RSPEC実行
nmap <F11>  :QuickRun 
"quickrunの前設定を初期化する。
let g:quickrun_config = {}

"(ファイル名)_spec.rb このファイルタイプをRSpecファイルと認識する。
augroup QrunRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END 

let rspec_outputter = quickrun#outputter#buffer#new()

function! rspec_outputter.init(session)
  call call(quickrun#outputter#buffer#new().init, [a:session], self)
endfunction

function! rspec_outputter.finish(session)
  highlight default RSpecGreen ctermfg = Green cterm = none
  highlight default RSpecRed    ctermfg = Red   cterm = none
  highlight default RSpecComment ctermfg = Cyan  cterm = none
  highlight default RSpecNormal  ctermfg = White cterm = none
  call matchadd("RSpecGreen", "^[\.F]*\.[\.F]*$")
  call matchadd("RSpecGreen", "^.*, 0 failures$")
  call matchadd("RSpecRed", "F")
  call matchadd("RSpecRed", "^.*, [1-9]* failures.*$")
  call matchadd("RSpecRed", "^.*, 1 failure.*$")
  call matchadd("RSpecRed", "^ *(.*$")
  call matchadd("RSpecRed", "^ *expected.*$")
  call matchadd("RSpecRed", "^ *got.*$")
  call matchadd("RSpecRed", "^ *Failure/Error:.*$")
  call matchadd("RSpecRed", "^.*(FAILED - [0-9]*)$")
  call matchadd("RSpecRed", "^rspec .*:.*$")
  call matchadd("RSpecComment", " # .*$")
  call matchadd("RSpecNormal", "^Failures:")
  call matchadd("RSpecNormal", "^Finished")
  call matchadd("RSpecNormal", "^Failed")

  call call(quickrun#outputter#buffer#new().finish,  [a:session], self)
endfunction

call quickrun#register_outputter("rspec_outputter", rspec_outputter)

"quickrunの動作をvimprocに指定する。
let g:quickrun_config._ = {'runner' : 'vimproc'}

" bundleを利用する設定。
let g:quickrun_config['rspec/bundle'] = {
  \ 'type': 'rspec/bundle',
  \ 'command': 'rspec',
  \ 'exec': 'bundle exec %c %s',
  \ 'outputter': 'rspec_outputter',
  \ 'split': ''
  \}

" 通常で利用する設定。
let g:quickrun_config['rspec/normal'] = {
  \ 'type': 'rspec/normal',
  \ 'command': 'rspec',
  \ 'exec': '%c %s',
  \ 'outputter': 'rspec_outputter',
  \ 'vsplit': ''
  \}

"※重要
"※ここで動作を変更する
"どの場面で使うか（rubyかrailsか）によってコマンドが変わるので
"手動でコメントアウトをつけたり外したりして利用している。
function! RSpecQuickrun()
" 通常の場合。（rubyなど）
""let b:quickrun_config = {'type' : 'rspec/normal'}
" bundle、Gemfileを利用している場合。（railsなど）
let b:quickrun_config = {'type' : 'rspec/bundle'}
endfunction
autocmd BufReadPost *_spec.rb call RSpecQuickrun()

""set autochdir

""unite-outline
noremap :uo :<C-u>Unite outline<CR>
noremap :uov :<C-u>Unite -vertical -winwidth=30 outline<CR>
noremap :] :<C-u>Unite -vertical -winwidth=30 outline<CR>

""unite-rails
noremap :rc :<C-u>Unite rails/controller<CR>
noremap :rm :<C-u>Unite rails/model<CR>
noremap :rv :<C-u>Unite rails/view<CR>
noremap :rh :<C-u>Unite rails/helper<CR>

""unite-ref-ri
noremap :rr :<C-u>Unite ref/ri<CR>

""Align
let g:Align_xstrlen = 3

" yankring_historyのディレクトリ設定
let g:yankring_history_dir = expand('$HOME')
let g:yankring_history_file = '.yankring_history'"

""qfixhowm
"let howm_dir = '~/Dropbox/howm'
"let howm_fileencoding = 'utf-8'
"let howm_fileformat = 'unix'

""gundo.vim 
nnoremap <F3> :GundoToggle<CR>
if has('persistent_undo')
    set undofile
    set undodir=./.vimundo,~/.vim/undo
endif

""NERD-COMMENTER
""コメントした後に挿入するスペースの数
let NERDSpaceDelims = 1
" キーマップの変更。<Leader>=\+cでコメント化と解除を行う。
"コメントされていれば、コメントを外し、コメントされてなければコメント化する。
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle

