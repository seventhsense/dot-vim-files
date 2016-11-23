" Neosnippet
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


