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


