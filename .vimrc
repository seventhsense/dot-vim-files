"互換モード解除
set nocompatible
"256色表示
set t_Co=256 
"エンコーディング
set encoding=utf-8
" set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
"locale 設定
language ja_JP.UTF-8
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
"行番号を表示しない
" set nonumber
set number
set clipboard=autoselect
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
"カレント行ハイライト
set cursorline

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
 set shiftwidth=2
 set smarttab
" タブをスペースに展開する (expandtab:展開する)
 set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
 set autoindent
 set smartindent
" バックスペースでインデントや改行を削除できるようにする
 set backspace=indent,eol,start
" ステータスラインにコマンドを表示
set showcmd

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

"入力モード時、ステータスラインのカラーを変更
" augroup InsertHook
" autocmd!
" autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
" autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
" augroup END
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
"
""バックアップ
set backupdir=$HOME/.vim/backup
""空行追加
""nnoremap O :<C-u>call append(expand('.'), '')<Cr>j
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
" タブ番号表示
" set tabline=%!MyTabLine()
 
" function! MyTabLine()
  " let s = ''
  " for i in range(tabpagenr('$'))
    " " select the highlighting
    " if i + 1 == tabpagenr()
      " let s .= '%#TabLineSel#'
    " else
      " let s .= '%#TabLine#'
    " endif
 
    " " set the tab page number (for mouse clicks)
    " let s .= '%' . (i + 1) . 'T'
 
    " " the label is made by MyTabLabel()
    " let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  " endfor
 
  " " after the last tab fill with TabLineFill and reset tab page nr
  " let s .= '%#TabLineFill#%T'
 
  " " right-align the label to close the current tab page
  " if tabpagenr('$') > 1
    " let s .= '%=%#TabLine#%999XClose'
  " endif
 
  " return s
" endfunction
 
" let g:use_Powerline_dividers = 1
 
" function! MyTabLabel(n)
    " let buflist = tabpagebuflist(a:n)
    " let winnr = tabpagewinnr(a:n)
    " let altbuf = bufname(buflist[winnr - 1])
 
    " " $HOME を消す
    " let altbuf = substitute(altbuf, expand('$HOME/'), '', '')
 
    " " カレントタブ以外はパスを短くする
    " if tabpagenr() != a:n
        " let altbuf = substitute(altbuf, '^.*/', '', '')
        " let altbuf = substitute(altbuf, '^.\zs.*\ze\.[^.]\+$', '', '')
    " endif
 
    " " vim-powerline のグリフを使う
    " if g:use_Powerline_dividers
        " let dividers = g:Pl#Parser#Symbols[g:Powerline_symbols].dividers
        " let left_div = nr2char(get(dividers[3], 0, 124))
        " let right_div = nr2char(get(dividers[1], 0, 124))
        " let altbuf = left_div . altbuf . right_div
    " else
        " let altbuf = '|' . altbuf . '|'
    " endif
 
    " " タブ番号を付加
    " let altbuf = a:n . ':' . altbuf
 
    " return altbuf
" endfunction
"
"" ファイルをひらいたとき最後にカーソルがあった場所にカーソルを移動する
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" NeoBundle

filetype plugin indent off     " required!

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	call neobundle#rc(expand('~/.vim/bundle/'))
endif
" let NeoBundle manage NeoBundle
" required! 
NeoBundle 'Shougo/neobundle.vim'
" recommended to install
""vimproc auto compile
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" after install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'

"Your Bundles here
" NeoBundle 'Shougo/neocomplcache'
function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
  endfunction

if s:meet_neocomplete_requirements()
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundleFetch 'Shougo/neocomplcache.vim'
else
    NeoBundleFetch 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neocomplcache.vim'
endif



NeoBundle 'Shougo/neosnippet'
" NeoBundle 'thinca/vim-ref'
NeoBundleLazy 'thinca/vim-ref', {'autoload': {'unite_sources': ['ref'], 'mappings': [['sxn', '<Plug>(ref-keyword)']], 'commands': [{'complete': 'customlist,ref#complete', 'name': 'Ref'}, 'RefHistory']}}
" NeoBundle 'thinca/vim-quickrun'
NeoBundleLazy 'thinca/vim-quickrun', {'autoload': {'mappings': [['sxn', '<Plug>(quickrun']], 'commands': [{'complete': 'customlist,quickrun#complete', 'name': 'QuickRun'}]}}
NeoBundle 'AutoClose'
NeoBundle 'tpope/vim-surround'
" NeoBundleLazy 'tpope/vim-surround', {'autoload': {'mappings': ['<Plug>Ysurround', '<Plug>YSsurround', '<Plug>YSurround', '<Plug>Dsurround', ['i', '<Plug>ISurround'], ['sx', '<Plug>VgSurround'], '<Plug>Yssurround', '<Plug>SurroundRepeat', '<Plug>Csurround', ['i', '<Plug>Isurround'], ['sx', '<Plug>VSurround']]}}
NeoBundle 'The-NERD-Commenter'
" NeoBundle 'taglist.vim'
NeoBundleLazy 'taglist.vim', {'augroup': 'END', 'autoload': {'commands': [{'complete': 'file', 'name': 'TlistDebug'}, {'complete': 'file', 'name': 'TlistAddFiles'}, 'TlistUndebug', {'complete': 'dir', 'name': 'TlistAddFilesRecursive'}, 'TlistLock', 'TlistOpen', {'complete': 'buffer', 'name': 'TlistShowPrototype'}, 'TlistUnlock', 'TlistHighlightTag', 'Tlist', 'TlistClose', {'complete': 'file', 'name': 'TlistSessionSave'}, {'complete': 'buffer', 'name': 'TlistShowTag'}, 'TlistToggle', 'TlistUpdate', 'TlistMessages', 'TlistSync', {'complete': 'file', 'name': 'TlistSessionLoad'}]}}
NeoBundle 'mattn/emmet-vim'
" NeoBundleLazy 'mattn/emmet-vim', {'autoload': {'commands': ['Emmet', 'EmmetInstall']}}
" NeoBundle 'Source-Explorer-srcexpl.vim'
NeoBundleLazy 'Source-Explorer-srcexpl.vim', {}
NeoBundle 'ctags.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'smartchr'
NeoBundle "itchyny/lightline.vim"
NeoBundle "tsaleh/vim-matchit"
NeoBundle 'closetag.vim'
" NeoBundle 'vim-scripts/YankRing.vim'
NeoBundleLazy 'vim-scripts/YankRing.vim', {'augroup': 'YankRing', 'autoload': {'commands': ['YRGetElem', 'YRPush', 'YRToggle', 'YRPaste', 'YRShow', 'YRMapsCreate', 'YRGetMultiple', 'YRPop', 'YRMapsDelete', 'YRSearch', 'YRYankCount', 'YRReplace', 'YRYankRange', 'YRCheckClipboard', 'YRDeleteRange', 'YRMapsMacro', 'YRClear']}}
NeoBundle 'vim-jp/vimdoc-ja'
" NeoBundleLazy 'vim-jp/vimdoc-ja', {'autoload': {'commands': ['help']}}
" NeoBundle 'h1mesuke/vim-alignta'
NeoBundleLazy 'h1mesuke/vim-alignta', {'autoload': {'unite_sources': ['alignta'], 'commands': [{'complete': 'customlist,s:complete_command_option', 'name': 'Alignta'}, {'complete': 'customlist,s:complete_command_option', 'name': 'Align'}]}}
" NeoBundle 'taka84u9/vim-ref-ri'
NeoBundleLazy 'taka84u9/vim-ref-ri', {'autoload': {'commands': ['HtmlHiLink']}}
" NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'haya14busa/vim-easymotion'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'Shougo/vimfiler'
NeoBundleLazy 'Shougo/vimfiler', {'augroup': 'vimfiler', 'autoload': {'unite_sources': ['vimfiler_drive', 'vimfiler_execute', 'vimfiler_history', 'vimfiler_mask', 'vimfiler_popd', 'vimfiler_sort'], 'mappings': [['n', '<Plug>(vimfiler_']], 'commands': [{'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerCurrentDir'}, {'complete': 'customlist,vimfiler#complete', 'name': 'Read'}, {'complete': 'customlist,vimfiler#complete', 'name': 'VimFiler'}, {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerBufferDir'}, {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerSimple'}, {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerTab'}, {'complete': 'customlist,vimfiler#complete', 'name': 'Edit'}, {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerExplorer'}, 'VimFilerClose', {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerCreate'}, {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerSplit'}, {'complete': 'customlist,vimfiler#complete', 'name': 'Write'}, {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerDouble'}, {'complete': 'customlist,vimfiler#complete', 'name': 'Source'}]}}
NeoBundle 'sudo.vim'
" NeoBundleLazy 'sudo.vim', {'autoload': {'commands': ['SudoRead', 'SudoWrite']}}
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
" NeoBundle 'vim-scripts/VOoM'
NeoBundleLazy 'vim-scripts/VOoM', {'autoload': {'commands': ['VoomReloadVim', 'VoomFoldingCleanup', {'complete': 'custom,voom#Complete', 'name': 'Voom'}, 'Voominfo', {'complete': 'custom,voom#Complete', 'name': 'VoomToggle'}, 'Voomquit', 'Voomtoggle', 'VoomFoldingSave', 'VoomReloadAll', 'Voomexec', 'VoomSort', 'Voomhelp', 'VoomFoldingRestore', 'Voomgrep', 'Voomlog', 'Voomunl', 'VoomQuitAll']}}
NeoBundle 'bkad/CamelCaseMotion'
" NeoBundle 'rhysd/clever-f.vim'
NeoBundleLazy 'rhysd/clever-f.vim', {'autoload': {'mappings': [['sxno', '<Plug>(clever-f-']]}}
" NeoBundle 'lilydjwg/colorizer'
NeoBundleLazy 'lilydjwg/colorizer', {'augroup': 'Colorizer', 'autoload': {'mappings': [['n', '<Plug>Colorizer']], 'commands': ['ColorToggle', 'ColorHighlight', 'ColorClear']}}
" NeoBundle 'Shougo/neocomplcache-rsense', {
      " \ 'depends': 'Shougo/neocomplcache',
      " \ 'autoload': { 'filetypes': 'ruby' }}
" NeoBundleLazy 'taichouchou2/rsense-0.3', {
      " \ 'build' : {
      " \    'mac': 'ruby etc/config.rb > ~/.rsense',
      " \    'unix': 'ruby etc/config.rb > ~/.rsense',
      " \ } }
" indentの深さに色を付ける
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'sgur/vim-gitgutter'
NeoBundle 'honza/vim-snippets'
" NeoBundle 'seventhsense/nerdtree', 'development'
NeoBundleLazy 'seventhsense/nerdtree', {'augroup': 'NERDTreeHijackNetrw', 'autoload': {'commands': ['NERDTreeMirror', 'NERDTreeClose', {'complete': 'dir', 'name': 'NERDTree'}, 'NERDTreeFocus', {'complete': 'customlist,nerdtree#completeBookmarks', 'name': 'NERDTreeFromBookmark'}, {'complete': 'dir', 'name': 'NERDTreeToggle'}, 'NERDTreeCWD', 'NERDTreeFind']}}
" NeoBundle 'LeafCage/nebula.vim'
NeoBundleLazy 'LeafCage/nebula.vim', {'autoload': {'commands': ['NebulaPutLazy', 'NebulaPutFromClipboard', 'NebulaYankOptions', 'NebulaYankConfig', 'NebulaPutConfig', 'NebulaYankTap']}}
" Unite source
" NeoBundle 'ujihisa/unite-gem'
NeoBundleLazy 'ujihisa/unite-gem', {'autoload': {'unite_sources': ['gem']}}
NeoBundle 'pasela/unite-webcolorname'
NeoBundle 'pekepeke/unite-fileline'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'koron/codic-vim'
NeoBundle 'rhysd/unite-codic.vim'
""Language
" ruby
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-rails'
NeoBundle 'basyura/unite-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'skwp/vim-rspec'
NeoBundle 'tpope/vim-cucumber'
" javascript/coffeescript
NeoBundle 'pekepeke/titanium-vim'
NeoBundle 'heavenshell/vim-jsdoc'
NeoBundle 'claco/jasmine.vim'
NeoBundle 'mklabs/vim-backbone'
NeoBundle 'AndrewRadev/vim-eco'
NeoBundle 'vim-coffee-script'
" stylesheet
NeoBundle 'groenewege/vim-less'
" other
NeoBundle 'tpope/vim-markdown'
""Theme
" NeoBundle 'tomasr/molokai'
NeoBundle 'desert256.vim'
" NeoBundle 'jpo/vim-railscasts-theme'
" NeoBundle 'vim-scripts/pyte'
" NeoBundle 'davidkariuki/sexy-railscasts-256-theme'

" New Plugin
NeoBundleLazy 'itchyny/calendar.vim', {'autoload': {'commands': [{'complete': 'customlist,calendar#argument#complete', 'name': 'Calendar'}]}}
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'renamer.vim'
NeoBundle 'mattn/jscomplete-vim'
NeoBundle 'igetgames/vim-backbone-jscomplete'
NeoBundle 'rking/ag.vim'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 't9md/vim-textmanip'
NeoBundle "kana/vim-textobj-user"
NeoBundle "osyo-manga/vim-textobj-multiblock"
NeoBundle 'othree/html5.vim'
NeoBundle 'hron84/vim-Cheffile'
NeoBundle 'elzr/vim-json'
NeoBundle 'osyo-manga/vim-over'

" NeoBundleLast...
" NeoBundleEnd...
filetype plugin indent on     " required!
"
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" colorscheme sexy-railscasts-256
colorscheme desert256
" colorscheme railscasts

if s:meet_neocomplete_requirements()
  " 新しく追加した neocomplete の設定
  "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
  " Disable AutoComplPop.
  " let g:acp_enableAtStartup = 0
  " echomsg "using neocomplete"
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  " rails.vimとの競合
  let g:neocomplete#force_overwrite_completefunc=1

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'ruby' : $HOME.'/.ruby.dict',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    " return neocomplete#close_popup() . "\<CR>"
    " return neocomplete#close_popup()
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  " inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplete#enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplete#enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  let g:neocomplete#enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplete#enable_auto_select = 1
  "let g:neocomplete#disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  autocmd FileType javascript,coffee set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType javascript,coffee set omnifunc=jscomplete#CompleteJS

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  " let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
else
  " 今までの neocomplcache の設定
  "------------------------------------
  " neocomplecache.vim
  "------------------------------------
  " echomsg "using neocomplecache"
  " 補完・履歴
  set infercase
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
  " cache skip
  let g:neocomplcache_skip_auto_completion_time = '0.3'

  " neocomplcacheを自動的にロックするバッファ名のパターン
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
  " -入力による候補番号の表示
  let g:neocomplcache_enable_quick_match = 1
  " 補完候補の一番先頭を選択状態にする(AutoComplPopと似た動作)
  let g:neocomplcache_enable_auto_select = 1

  ""avoid rails.vim
  let g:neocomplcache_force_overwrite_completefunc=1

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
        \ 'ruby' : $HOME.'/.vim/dict/ruby.dict',
        \ 'vm' : $HOME.'/.vim/dict/vim.dict'
        \ }

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

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
  autocmd FileType javascript,coffee set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType javascript,coffee set omnifunc=jscomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c set omnifunc=ccomplete#Complete
  autocmd FileType ruby set omnifunc=rubycomplete#Complete

  " Enable heavy omni completion.
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

  let g:neocomplcache_enable_fuzzy_completion = 0

  let g:neocomplcache_source_rank = {
        \ 'snippets_complete' : 5,
        \ 'dictionary_complete' : 8,
        \ 'jscomplete' : 500,
        \ }

  " domも含める
  let g:jscomplete_use = ['dom']

  imap <C-q> <Plug>(neocomplcache_start_unite_quick_match)

  " NeoComplCache-rsense
  let g:neocomplcache#sources#rsense#home_directory = expand('~/.bundle/rsense-0.3')

endif

" スニペット
imap <silent>,, <Plug>(neosnippet_expand_or_jump)
smap <silent>,, <Plug>(neosnippet_expand_or_jump))

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" ほかのスニペットをつかう
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
" ユーザー定義スニペット保存ディレクトリ
let g:neosnippet#snippets_directory=$HOME.'/.vim/snippets'

" for emmet
let g:user_emmet_settings = {
      \  'lang' : 'ja',
      \  'html' : {
      \    'filters' : 'html',
      \    'indentation' : ' '
      \  },
      \  'perl' : {
      \    'indentation' : '  ',
      \    'aliases' : {
      \      'req' : "require '|'"
      \    },
      \    'snippets' : {
      \      'use' : "use strict\nuse warnings\n\n",
      \      'w' : "warn \"${cursor}\";",
      \    },
      \  },
      \  'php' : {
      \    'extends' : 'html',
      \    'filters' : 'html,c',
      \  },
      \  'css' : {
      \    'filters' : 'fc',
      \  },
      \  'javascript' : {
      \    'snippets' : {
      \      'jq' : "$(function() {\n\t${cursor}${child}\n});",
      \      'jq:each' : "$.each(arr, function(index, item)\n\t${child}\n});",
      \      'fn' : "(function() {\n\t${cursor}\n})();",
      \      'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
      \    },
      \  },
      \ 'java' : {
      \  'indentation' : '    ',
      \  'snippets' : {
      \   'main': "public static void main(String[] args) {\n\t|\n}",
      \   'println': "System.out.println(\"|\");",
      \   'class': "public class | {\n}\n",
      \  }
      \ },
      \ 'custom_expands1' : {
      \    '^\%(lorem\|lipsum\)\(\d*\)$' : function('emmet#lorem#ja#expand'),
      \  }
      \}
let g:use_emmet_complete_tag = 1

"" unite
" 入力モードで開始
let g:unite_enable_start_insert = 1

"大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

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
noremap :@ :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
noremap :uffr :<C-u>UniteWithBufferDir file_rec -buffer-name=file_rec<CR>

let g:unite_source_history_yank_file=$HOME.'/.vim/yankring.txt'
let g:unite_source_history_yank_enable =1  "history/yankの有効化
nnoremap <silent> :[ :<C-u>Unite history/yank<CR>

""line
noremap :ul :<C-u>Unite line<CR>
noremap :; :<C-u>Unite line<CR>

""grep
noremap :g :<C-u>Unite grep -buffer-name=search-buffern<CR>
"agを使えたら使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

""file
noremap :f :<C-u>Unite file_rec<CR>

"" vim command 一覧
noremap :<CR> :<C-u>Unite command mapping<CR>

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
autocmd FileType php let b:surround_{char2nr("?")} = "<?php \r ?>"
autocmd FileType ruby let b:surround_{char2nr("i")} = "if \1condition: \1 \r end"
autocmd FileType ruby let b:surround_{char2nr("d")} = "def \1method: \1 \r end"
autocmd FileType ruby let b:surround_{char2nr("w")} = "while \1condition: \1 do \r end"
autocmd FileType ruby let b:surround_{char2nr("t")} = "\1times: \1.times do \r end"
autocmd FileType ruby let b:surround_{char2nr("g")} = "group \1group: \1 do \r end"
autocmd FileType ruby let b:surround_{char2nr("l")} = "logger.debug \r"
autocmd FileType ruby let b:surround_{char2nr("L")} = "logger.debug '--------------------------------------------------'\nlogger.debug '--------------------------------------------------'\nlogger.debug '--------------------------------------------------'\nlogger.debug '--------------------------------------------------'\nlogger.debug '--------------------------------------------------'\nlogger.debug '--------------------------------------------------'\nlogger.debug \r"
autocmd FileType ruby.rspec let b:surround_{char2nr("I")} = "it \"\1sentense: \1\" do \r end"
autocmd FileType ruby.rspec let b:surround_{char2nr("D")} = "describe \"\1sentense: \1\" do \r end"
autocmd FileType coffee let b:surround_{char2nr("I")} = "it \"\1sentense: \1\" do \r"
autocmd FileType coffee let b:surround_{char2nr("D")} = "describe \"\1sentense: \1\" do \r"

autocmd FileType eruby let b:surround_{char2nr("i")} = "<% if \1confition: \1 %> \r <% end %>"
autocmd FileType eruby let b:surround_{char2nr("e")} = "<% \1valiable: \1.each do |\2local: \2| %> \r <% end %>"
autocmd FileType coffee let b:surround_{char2nr("i")} = "if \1condition: \1 \r"
autocmd FileType coffee let b:surround_{char2nr("l")} = "console.log \r"
autocmd FileType javascript let b:surround_{char2nr("f")} = "function(\1locals: \1)({\r})"
autocmd FileType javascript let b:surround_{char2nr("l")} = "console.log(\r)"

"ビジュアルモード時kで「」の囲い込み
let g:surround_107 = "「\r」" " 107 = k

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


"NERD_tree.vim
""---------------------
nnoremap <f2> :NERDTreeToggle<CR>
""最後に残ったウィンドウがNERDTREEのみのときはvimを閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeDirArrows=0
let g:NERDTreeMouseMode=0

""smartchr設定
""inoremap <expr> = smartchr#one_of('=',' = ', ' == ', ' === ')

""Powerline設定
""python from powerline.ext.vim import source_plugin; source_plugin()
""let g:Powerline_symbols  =  'fancy'
" let g:Powerline_colorscheme = 'skwp'

"""RSPEC実行
nmap <F10>  :QuickRun 
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
noremap :rs :<C-u>Unite rails/stylesheet<CR>
noremap :rj :<C-u>Unite rails/javascript<CR>
noremap :rr :<C-u>Unite rails/route<CR>
noremap :rg :<C-u>Unite rails/gemfile<CR>
noremap :rt :<C-u>Unite rails/spec<CR>

""unite-ref-ri
" noremap :rr :<C-u>Unite ref/ri<CR>

""Align
let g:Align_xstrlen = 3

" yankring_historyのディレクトリ設定
let g:yankring_history_dir = expand('$HOME')
let g:yankring_history_file = '/.vim/yankring_history'"

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

""gist.vim
let g:gist_show_privates = 1
let g:gist_post_private = 1

"" vim-coffee-script
" au BufRead,BufNewFile *.coffee            set filetype=coffee
" au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

"" easymotion
let g:EasyMotion_leader_key = "<space>"
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
nmap f <Plug>(easymotion-s)
vmap f <Plug>(easymotion-s)
omap f <Plug>(easymotion-s) " surround.vimとかぶるので`z`
let g:EasyMotion_startofline=0


" let $XIKI_DIR = "~/.rvm/gems/ruby-1.9.3-p194/gems/xiki-0.6.5/"
" source ~/.rvm/gems/ruby-1.9.3-p194/gems/xiki-0.6.5/etc/vim/xiki.vim

"" vim-less
au BufRead,BufNewFile *.less		set filetype=less

"" vim-ref
" let $PATH = $PATH . ':/opt/local/bin' 
" let g:ref_rubyreference_path = '~/Documents/Reference/rubyrefm'
" let g:ref_rubyreference_cmd = 'w3m -dump %s'
let g:ref_use_vimproc=1
let g:ref_refe_version=2
nmap ,rr :<C-u>Ref refe<Space>

"webdictサイトの設定
let g:ref_source_webdict_sites = {
      \   'je': {
      \     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
      \   },
      \   'ej': {
      \     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
      \   },
      \   'wiki': {
      \     'url': 'http://ja.wikipedia.org/wiki/%s',
      \   },
      \ }

"デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'

"出力に対するフィルタ。最初の数行を削除
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction

nmap <Leader>rj :<C-u>Ref webdict je<Space>
nmap <Leader>re :<C-u>Ref webdict ej<Space>

au FileType ruby,eruby setl tags+=~/gtags

""syntastic
let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_mode_map = { 'mode': 'active',
" \ 'active_filetypes': [],
" \ 'passive_filetypes': ['javascript'] }

""vim-eco
autocmd BufNewFile,BufRead *.eco set filetype=eco

""CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

" endtagcomment.vim
" https://gist.github.com/hokaccha/4118281
" こういうHTMLがあったときに
" <div id="hoge" class="fuga">
" ...
" </div>
"
" 実行するとこうなる
" <div id="hoge" class="fuga">
" ...
" <!-- /div#hoge.fuga --></div>

function! Endtagcomment()
  let reg_save = @@

  try
    silent normal vaty
  catch
    execute "normal \<Esc>"
    echohl ErrorMsg
    echo 'no match html tags'
    echohl None
    return
  endtry

  let html = @@

  let start_tag = matchstr(html, '\v(\<.{-}\>)')
  let tag_name  = matchstr(start_tag, '\v([a-zA-Z]+)')

  let id = ''
  let id_match = matchlist(start_tag, '\vid\=["'']([^"'']+)["'']')
  if exists('id_match[1]')
    let id = '#' . id_match[1]
  endif

  let class = ''
  let class_match = matchlist(start_tag, '\vclass\=["'']([^"'']+)["'']')
  if exists('class_match[1]')
    let class = '.' . join(split(class_match[1], '\v\s+'), '.')
  endif

  execute "normal `>va<\<Esc>`<"

  let comment = g:endtagcommentFormat
  let comment = substitute(comment, '%tag_name', tag_name, 'g')
  let comment = substitute(comment, '%id', id, 'g')
  let comment = substitute(comment, '%class', class, 'g')
  let @@ = comment

  normal ""P

  let @@ = reg_save
endfunction

let g:endtagcommentFormat = '<!-- /%tag_name%id%class -->'
nnoremap ,t :<C-u>call Endtagcomment()<CR>

""filetype cucumber
au BufRead,BufNewFile *_steps.rb            set filetype=cucumber.ruby

""filetype snippet
au BufRead,BufNewFile,BufReadPre *.snip set filetype=snippet

""filetype Gemfile
" au BufRead,BufNewFile Gemfile            setfiletype Gemfile

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j
inoremap <silent> kk <ESC>
inoremap <silent> <C-k> k

" vimdoc-ja
" helptags ~/.vim/bundle/vimdoc-ja/doc
set helplang=ja,en

"tags
"ctrl + [のとき選択できるようにする
" tagsジャンプの時に複数ある時は一覧表示                                        
nnoremap <C-]> g<C-]> 

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

"------------------------------------
" indent_guides
"------------------------------------
" インデントの深さに色を付ける
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_color_change_percent=20
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1

hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=237
au FileType coffee,ruby,javascript,python IndentGuidesEnable
nmap <silent><Leader>ig <Plug>IndentGuidesToggle


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

"VimFiler"
" let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
" Edit file by tabedit.
let g:vimfiler_edit_action = 'edit'
" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
" nmap <F2> :VimFiler -split -horizontal -project -toggle -quit<CR> 
autocmd FileType vimfiler nnoremap <buffer><silent>/  :<C-u>Unite file -default-action=vimfiler<CR>
autocmd FileType vimfiler nnoremap <silent><buffer> e :call <SID>vimfiler_tree_edit('open')<CR>

function! s:vimfiler_tree_edit(method) "{{{4
  " let file = vimfiler#get_file()
  " if empty(file) || empty(a:method) | return | endif
  " let path = file.action__path
  " wincmd p
  " execute a:method
  " exe 'edit' path
  if empty(a:method) | return | endif
  let linenr = line('.')
  let context = s:vimfiler_create_action_context(a:method, linenr)
  wincmd p
  " call vimfiler#mappings#do_action(a:method, linenr)
  call context.execute()
  unlet context
endfunction

function! s:vimfiler_create_action_context(action, ...) " {{{4
  let cursor_linenr = get(a:000, 0, line('.'))
  let vimfiler = vimfiler#get_current_vimfiler()
  let marked_files = vimfiler#get_marked_files()
  if empty(marked_files)
    let marked_files = [ vimfiler#get_file(cursor_linenr) ]
  endif

  let context = s:vimfiler_context.new({
        \ 'action' : a:action,
        \ 'files' : marked_files,
        \ 'current_dir' : vimfiler.current_dir,
        \ })
  return context
endfunction

let s:vimfiler_context = {} " {{{4
function! s:vimfiler_context.new(...)
  let dict = get(a:000, 0, {})
  return extend(dict, self)
endfunction

function! s:vimfiler_context.execute()
  call unite#mappings#do_action(self.action, self.files, {
        \ 'vimfiler__current_directory' : self.current_dir,
        \ })
endfunction

"" C-pで0レジスタで貼り付け
vnoremap <silent> <C-p> "0p<CR>

"" textmanip
xmap <Space>d <Plug>(textmanip-duplicate-down)
nmap <Space>d <Plug>(textmanip-duplicate-down)
xmap <Space>D <Plug>(textmanip-duplicate-up)
nmap <Space>D <Plug>(textmanip-duplicate-up)

xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

" toggle insert/replace with <F9>
nmap <F9> <Plug>(textmanip-toggle-mode)
xmap <F9> <Plug>(textmanip-toggle-mode)

"" textobj-multiblock
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
vmap ab <Plug>(textobj-multiblock-a)
vmap ib <Plug>(textobj-multiblock-i)
