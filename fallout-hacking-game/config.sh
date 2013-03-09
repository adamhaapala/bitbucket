#!/bin/sh

## User Config and Globals
## not likely to change but 
## who knows

## Game settings ##

declare -a PASSWORDLIST=('TEST0' 'TEST1' 'TEST2' 'TEST3' 'TEST4' 'TEST5' 'TEST6')         
			# 1-dim array of possible passwords
			# Makes it easier if all passwords 
                        # are the same length
DIFFICULTY=EASY         # EASY, HARD, H4X0RZ, OHFUCKTHIS
ATTEMPTS=4 	        # Number of active attempts

## Game Internals ##

declare -a GRID=()

# Header for hacking game
TERMHEADER= read -d '' TERMHEADER << "EOF"
ROBOCO INDUSTRIES (TM) TERMLINK PROTOCOL
ENTER PASSWORD NOW
EOF

declare -a HISTORY=()   # Array to contain attempt history , array of strings
TERMROW=${tput lines}	# The terminal rows
TERMCOL=${tput cols}    # and cols, good to know...
SPLITCOL=$TERMCOL/3     # History bar is % of screen width, 
HEADERSIZE=5		# Number of rows header and attempts
			# take up
HEXWIDTH=7		# How many spaces each hex decoration 
			# takes up w/ white space

# Need to review need/use of these ###
GRIDHEIGHT=$TERMROW-$HEADERSIZE # Height of play area
GRIDWIDTH=($TERMCOL-$SPLITCOL)-($HEXWIDTH*2) # Number of columns
			# The grid takes in total minus the 
			# decoration places and history bar
######################################


# Keys to match while in game
UP='^[[A'
DOWN='^[[B'
LEFT='^[[D'
RIGHT='^[[C'
ENTER=''
ESC=''

# Color/Environment Settings
BGCOLOR=""
FGCOLOR=""
X=""	                 # Col location of cursor
Y=""                     # Row location of cursor

declare -a MYSCREEN=()  # This is for layout meta data not actual cell/location mappings
# dimStartX -> upper left hand corner, X screen coordinate of panel
# dimStartY -> upper left hand corner, Y screen coordinate
# dimStop X -> lower right hand corner, x screen coordinate
# dimStop Y -> lower right hand corner, Y screen coordinate
# If a coordinate is >= its equivalent start coordinate and <= it's stop coordinate then the 
# coordinate falls into the panel.  We can also use the coordinates of grid1 and grid2 to
# size/seed our random field of characters onto which the passwords will be placed.  That
# way we can establish coordinate->game-signifigance by checking the data-structure housing the 
# generated random/password chars.

# So.. 1) Need screen/game initialization routines
# 2) Hash out random char/solution structure & difficulty setting
# 3) finalize attempt verification and screen update
# 4) Test and polish code
MYSCREEN['PLAY']=('orientation:TLR' 'dimStartX:0','dimStartY:0','dimStopX:','dimStopY:')
MYSCREEN['HISTORY']=('orientation:BLR' 'dimStartX:','dimStartY:','dimStopX:','dimStopY:')
MYSCREEN['GRID1']=('orientation:TLR' 'dimStartX:0','dimStartY:0','dimStopX:','dimStopY:')
MYSCREEN['GRID2']=('orientation:TLR' 'dimStartX:0','dimStartY:0','dimStopX:','dimStopY:')
