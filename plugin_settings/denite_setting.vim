" filetype
nmap <silent> <C-u><C-t> :<C-u>Denite filetype<CR>
" fileを再帰的に
nmap <silent> <C-u><C-p> :<C-u>Denite file_rec<CR>
" 現在のバッファでfileを再帰的に
noremap ;@ :<C-u>DeniteBufferDir file_rec directory_rec<CR>
" プロジェクトdirectoryからファイルを再帰的に
noremap ;p :<C-u>DeniteProjectDir file_rec directory_rec<CR>
" バッファー内を行で絞り込む
nmap <silent> <C-u><C-j> :<C-u>Denite line<CR>
nmap <silent> ;l :<C-u>Denite line<CR>
" grep(ファイル内容検索)で絞り込む
nmap <silent> <C-u><C-g> :<C-u>Denite grep<CR>
nmap <silent> ;g :<C-u>Denite grep<CR>
" 現在カーソルのあるwordでgrep
nmap <silent> <C-u><C-]> :<C-u>DeniteCursorWord grep<CR>
" 過去の履歴で絞り込む
nmap <silent> <C-u><C-u> :<C-u>Denite file_mru<CR>
nmap <silent> ;; :<C-u>Denite file_mru<CR>
" yank履歴を絞り込む
nmap <silent> <C-u><C-y> :<C-u>Denite neoyank<CR>
nmap <silent> ;y :<C-u>Denite neoyank<CR>
" 前に使ったDeniteをもう１回
" Reuse the previous buffer.  If none exist, a new denite
" buffer gets created.
" Note: Uses |denite-options-buffer-name| to search for
" previous buffers.
nmap <silent> <C-u><C-r> :<C-u>Denite -resume<CR>
nmap <silent> <C-u>; :<C-u>Denite -resume -immediately -select=+1<CR>
nmap <silent> <C-u>- :<C-u>Denite -resume -immediately -select=-1<CR>
" bufferで絞り込む
nmap <silent> ;b :<C-u>Denite buffer<CR>
" commandで絞り込む
nmap <silent> ;<CR> :<C-u>Denite command<CR>
" directoryを再帰的に絞り込む
nmap <silent> ;d :<C-u>Denite directory_rec<CR>
" nmap <silent> ;] :<C-u>Denite -split=vertical -winwidth=30 outline<CR>
