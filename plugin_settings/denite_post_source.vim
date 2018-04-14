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
if executable('rg')
  call denite#custom#var('file_rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
""  call denite#custom#var('grep', 'command', ['rg'])
endif

call denite#custom#var('grep', 'default_opts', [])
call denite#custom#var('grep', 'recursive_opts', [])

call denite#custom#option('default', 'prompt', '>')

" denite/insert モードのときは，UpDownで移動できるようにする
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>')

call denite#custom#map('insert', '<Right>', '<denite:assign_next_matched_text>')
call denite#custom#map('insert', '<Left>', '<denite:assign_previous_matched_text>')

" tabopen や vsplit のキーバインドを割り当て
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>')
call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>')

" jj で denite/insert を抜けるようにする
call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>')


