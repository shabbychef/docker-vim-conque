" * Tue Dec 29 2015 08:48:11 PM Steven E. Pav shabbychef@gmail.com
"
" demo vimrc for conque
"

" basic stuff"{{{
set splitbelow
set splitright
set showcmd
set showmatch
set showmode
set shell=bash
set lazyredraw
set ttyfast
set nocompatible
set modeline
set modelines=1
"}}}

" for conque:"{{{

let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_Syntax = 'r'

let g:color_stack_colors_name = exists('g:colors_name')? g:colors_name : 'default'

fun! ColorStack(newColor)
	let g:color_stack_colors_name = exists('g:colors_name')? g:colors_name : 'default'
	try
		execute 'colorscheme ' . a:newColor
	catch
		"echo 'problem w/ colorscheming?'
	endtry
endfun

fun! PopColorStack()
	" this essentially toggles the current color with the one last
	" saved to g:color_stack_colors_name
	if exists('g:color_stack_colors_name')
		:call ColorStack(g:color_stack_colors_name)
	endif
endfun
	
fun! MyConqueBufferEnter(term)
	try
		" line numbers
		setlocal nonu
		setlocal ft=matlab
		" do this via ConqueTerm_Syntax
		" setlocal syntax=matlab
		if has('gui_running')
			:call ColorStack('sep_python')
		else
			":call ColorStack('simpleandfriendly')
			:call ColorStack('autumnleaf')
		endif
	catch
		echo "some problem with buffer enter"
		"noop
	endtry
endfun

fun! MyConqueAfterStartup(term)
	:call MyConqueBufferEnter(a:term)
endfun

fun! MyConqueBufferLeave(term)
	:call PopColorStack()
endfun

try
	!call conque_term#register_function('after_startup','MyConqueAfterStartup')
	!call conque_term#register_function('buffer_enter','MyConqueBufferEnter')
	!call conque_term#register_function('buffer_leave','MyConqueBufferLeave')
catch
	" echo 'vimrc needs resourcing?'
	"noop
endtry

function! s:ExecuteInConqueTerm(command)
	let command = join(map(split(a:command), 'expand(v:val)'))
	let g:ConqueTerm_FastMode = 1
	let g:ConqueTerm_ReadUnfocused = 1
	let g:ConqueTerm_CloseOnEnd = 1
	" weird that I have to do this; bleah;
	call conque_term#register_function('after_startup','MyConqueAfterStartup')
	call conque_term#register_function('buffer_enter','MyConqueBufferEnter')
	call conque_term#register_function('buffer_leave','MyConqueBufferLeave')
	"let my_term = conque_term#open(command, ['split', 'resize 10'], 1)
	let s:my_term = conque_term#open(command, ['split'], 1)
endfunction

command! -complete=shellcmd RConque call s:ExecuteInConqueTerm('screen -D -R -S r')
command! -complete=shellcmd -nargs=1 ScreenConque call s:ExecuteInConqueTerm('screen -D -R -S ' . <f-args>)
"}}}

" modelines
" vim:ts=2:sw=2:fdm=marker:cms=\"%s:syn=vim:ft=vim:ai:cin:nu:fo=croql:cino=p0t0c5(0:
