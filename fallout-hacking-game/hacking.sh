#!/bin/sh

## Globals ##

# Pull in config file
./config.sh

## Sub-routines ##
./util.sh

# only ctrl-c or winning/loosing the game will exit
sub play(){

    # Game's started
    # Assuming screen is drawn begin taking input
    # Cursor should start and stay in the two panels
    # of random elements.  See off-sets for panel
    # definitions
    X="0"
    Y="0"
    moveCursor($X,$Y)
    while [ 1 ]
    do
        read -n 1 key
        case "$key" in
	  $UP)arrowUp(1);;
	  $DOWN)arrowDown(1);;
	  $LEFT)arrowLeft(1);;
          $RIGHT)arrowRight(1);;
	  $ENTER)checkCell();
          *)	# Catch all
		;;
        esac
    done
}


## Main ##

# Get the password for the session
PASSWORD=selectPass()
GRID=generateRandomField()
play($GRID)

trap 'exit 1' INT TERM
trap 'tput setaf 9; tput cvvis; clear' EXIT

