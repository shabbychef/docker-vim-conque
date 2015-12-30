# /usr/bin/r
#
# demo code to show off how nice vim-conque is
#
# Created: 2015.12.29
# Copyright: Steven E. Pav, 2015
# Author: Steven E. Pav <shabbychef@gmail.com>

# first, start vim-conque with screen by typing
# <ESC>:RConque
#
# this is a command which starts a split screen window within vim
# (I use screen because you can scroll back within vim; probably
# tmux can be similarly configured, but I have had little luck.)
#
# Startup can take ~2 seconds because screen is slow. This is
# only on initialization.
#
# screen starts a bash terminal. You are in vim, but can interact with
# bash. so type
# R
# to start R. To escape insert mode, type <ESC> as you normally would in
# vim, then return to this split (<CTRL>-w t to get to 'top' split)

# here is some R code. You can execute this in your R-in-screen-in-vim 
# REPL by visually selecting it (<SHIFT>-v, say), then, once you have
# the lines selected, typing <F9>
x <- rnorm(100)
print(x)
sum(x)

# you are now once again in insert mode in the R session. Notice that if
# you escape insert mode, you can scroll back up.

# try that again, come back here, visually select and hit <F9>
set.seed(1234)
adf <- data.frame(x=rnorm(100),y=runif(100),z=exp(rnorm(100)))
mdl <- lm(z ~ x + y,data=adf)
summary(mdl)

# you can also execute all commands in this file by typing
# <F10>  There is a limit on the buffer size, however.

# another nice feature is that you can go into the R window, scroll back up
# in the history, select commands from your R history (again visual select)
# and type <F9> from there as well. Or you can yank data (or commands) from
# your R session into a register, then copy them back into the file you
# are editing.

# when you are done, just :bd the screen window. Because it is running
# in screen, you can come back to it later. 

#for vim modeline: (do not edit)
# vim:fdm=marker:fmr=FOLDUP,UNFOLD:cms=#%s:syn=r:ft=r
