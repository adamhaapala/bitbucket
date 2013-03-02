#!/bin/sh

## User Config and Globals
## not likely to change but 
## who knows

PASSWORDLIST=()         # 1-dim array of possible passwords
DIFFICULTY=EASY         # EASY, HARD, VERYHARD, OHFUCKTHIS
NUMBEROFTRIES=4         # Default in the game
HISTORY=""              # Array to contain history 
TERMROW=${tput lines}	# The terminal rows
TERMCOL=${tput cols}    # and cols, good to know...

# Header for hacking game
TERMHEADER= read -d '' TERMHEADER << "EOF"
ROBOCO INDUSTRIES (TM) TERMLINK PROTOCOL
ENTER PASSWORD NOW
EOF

# Keys to match while in game
UP='^[[A'
DOWN='^[[B'
LEFT='^[[D'
RIGHT='^[[C'
ENTER=''
ESC=''

ATTEMPTS=4 # Number of active attempts
Declare -a SOLUTION   # Two-dimensional array containing solution to puzzle
X=""	# Col location of cursor
Y=""    # Row location of cursor

