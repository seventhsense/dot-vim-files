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

