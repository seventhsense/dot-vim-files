" call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])

call denite#custom#var('file_rec', 'command',
\ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
    \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" use rg"
" if executable('rg')
  " call denite#custom#var('file_rec', 'command',
        " \ ['rg', '--files', '--glob', '!.git'])
  " call denite#custom#var('grep', 'command', ['rg'])
" endif

call denite#custom#var('grep', 'default_opts', [])
call denite#custom#var('grep', 'recursive_opts', [])

call denite#custom#option('default', 'prompt', '>')

" denite/insert モードのときは，UpDownで移動できるようにする
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>')
" denite/insert モードのときは、RightLeftで過去の履歴
call denite#custom#map('insert', '<Right>', '<denite:assign_next_matched_text>')
call denite#custom#map('insert', '<Left>', '<denite:assign_previous_matched_text>')

" tabopen や vsplit のキーバインドを割り当て
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>')
call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>')

" customize ignore globs
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy','matcher_ignore_globs'])
call denite#custom#source('directory_rec', 'matchers', ['matcher_fuzzy','matcher_ignore_globs'])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [
      \ '.git/', 'build/', '__pycache__/',
      \ 'images/', '*.o', '*.make',
      \ '*.min.*',
      \ 'img/', 'fonts/'])

" Change sorters.
"
" Uses the scoring algorithm from this article and its implementation:
" https://bit.ly/reverse-engineering-sublime-text-s-fuzzy-match
" call denite#custom#source(
" \ 'file_rec', 'sorters', ['sorter/sublime'])
