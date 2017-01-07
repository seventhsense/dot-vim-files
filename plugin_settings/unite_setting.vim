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
" noremap :f :<C-u>Unite file_rec<CR>

"" vim command 一覧
noremap :<CR> :<C-u>Unite command mapping<CR>

" c-jはescとする
au FileType unite nnoremap <silent> <buffer> <c-j> <esc><CR>

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
