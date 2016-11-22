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
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない
" ESC2回押してハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"シンタックス
syntax on

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
""バックアップ
set backupdir=$HOME/.vim/backup
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

" NeoComplete
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" echomsg "using neocomplete"
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" use fuzzy comletion
let g:neocomplete#enable_fuzzy_completion = 1
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
  " return neocomplete#close_popup()
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
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
" let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

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
" noremap :: :<C-u>Unite neomru/file<CR>
noremap :ur :<C-u>Unite register -buffer-name=register<CR>
noremap :ub :<C-u>Unite buffer -buffer-name=buffer<CR>

"file current_dir
noremap :ufc :<C-u>Unite file -buffer-name=file<CR>
noremap :ufcr :<C-u>Unite file_rec -buffer-name=file_rec<CR>

"file file_current_dir
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
noremap :@ :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
noremap :uffr :<C-u>UniteWithBufferDir file_rec -buffer-name=file_rec<CR>

"file_rec
noremap :/ :<C-u>Unite file_rec/async:! file/new -buffer-name=file_rec<CR>
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

""---------------------
"" NERD_tree.vim
""---------------------
nnoremap <f2> :NERDTreeToggle<CR>
""最後に残ったウィンドウがNERDTREEのみのときはvimを閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeDirArrows=0
let g:NERDTreeMouseMode=0

""smartchr設定
""inoremap <expr> = smartchr#one_of('=',' = ', ' == ', ' === ')

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
" コメントされていれば、コメントを外し、コメントされてなければコメント化する。
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle

""gist.vim
let g:gist_show_privates = 1
let g:gist_post_private = 1

"" vim-coffee-script
" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

"" easymotion
let g:EasyMotion_leader_key = "<space>"
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
nmap f <Plug>(easymotion-s2)
vmap f <Plug>(easymotion-s2)
omap f <Plug>(easymotion-s2) " surround.vimとかぶるので`z`
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)

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
let g:syntastic_mode_map = { 'mode': 'active', 
              \ 'active_filetypes': ['ruby']}
let g:syntastic_ruby_checkers = ['rubocop']
" let g:syntastic_quiet_messages = {'levels': 'warnings'}
" let g:syntastic_mode_map = { 'mode': 'active',
" \ 'active_filetypes': [],
" \ 'passive_filetypes': ['javascript'] }
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

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

" VimFiler
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

"" vim-json
let g:vim_json_syntax_conceal = 0

"" evervim
" 環境依存や非公開設定ファイルの読み込み
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

"" autoprefixer
" vnoremap ap : <c-u>call PrefixVisualMyCSS()<cr>
" nnoremap ap : <c-u>call PrefixMyCSS()<cr>
" command! Prefix call PrefixMyCSS()

" mustache.vim
let g:mustache_abbreviations = 1

"" python settings
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl expandtab tabstop=2 shiftwidth=2 softtabstop=2

" wildfire
let g:wildfire_objects = ["iw","is", "i'", 'i"', "i)", "i]", "i}", "ip", "it"]

" committia.vim
" You can get the information about the windows with first argument as a dictionary.
"
"   KEY              VALUE                      AVAILABILITY
"-----------------------------------------------------------------------------------
"   vcs            : vcs type (e.g. 'git')   -> all hooks
"   edit_winnr     : winnr of edit window    -> ditto
"   edit_bufnr     : bufnr of edit window    -> ditto
"   diff_winnr     : winnr of diff window    -> ditto
"   diff_bufnr     : bufnr of diff window    -> ditto
"   status_winnr   : winnr of status window  -> all hooks except for 'diff_open' hook
"   status_bufnr   : bufnr of status window  -> ditto

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    end

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)

endfunction

"" seiya.vim 半透明化
" let g:seiya_auto_enable=1

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" * での検索や text-object 等での選択時に - で切らない
setlocal iskeyword& iskeyword+=-
