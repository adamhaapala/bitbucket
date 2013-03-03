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

GRIDHEIGHT=$TERMROW-$HEADERSIZE # Height of play area
GRIDWIDTH=($TERMCOL-$SPLITCOL)-($HEXWIDTH*2) # Number of columns
			# The grid takes in total minus the 
			# decoration places and history bar

# Keys to match while in game
UP='^[[A'
DOWN='^[[B'
LEFT='^[[D'
RIGHT='^[[C'
ENTER=''
ESC=''

declare -a PASSLOC=()   

# Color/Environment Settings
BGCOLOR=""
FGCOLOR=""
X=""	                 # Col location of cursor
Y=""                     # Row location of cursor

NUMSECT=2     # Number of sectors to split the screen into
declare -a MYSCREEN=()  # This is for layout meta data not actual cell/location mappings
MYSCREEN['PLAY']=('orientation:TLR' '')
MYSCREEN['HISTORY']=('orientation:BLR' '')
