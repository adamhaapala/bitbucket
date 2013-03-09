#!/bin/sh

## Globals ##

# Pull in config file
./config.sh

## Sub-routines ##
./util.sh

# Populate the screen dimensions structure 
# generate the random character fields, 
# password lists, and associations between the two
function initScreen{
  
    # Screen obj population here    

    # Get the password for the session
    PASSWORD=selectPass
    # Should be able to pass combined dimensions of grid1 and grid2
    # so (g1l*g1w)+(g2l*g2w)=num of characters to fill in that field 
    # Keep GRID a 1-dim array 
    GRID=generateRandomField 
    GRID=placePasswords $GRID
    # This way when we place our passwords we're displacing the 
    # same number of chars as their length and obscounding with 
    # their screen coordinate pairings
}

# only ctrl-c or winning/loosing the game will exit
function play {

    # Game's started
    # Assuming screen is drawn begin taking input
    # Cursor should start and stay in the two panels
    # of random elements.  See off-sets for panel
    # definitions

    # Should be starting position in the puzzle grid
    X="0"
    Y="0"

    moveCursor $X $Y  # Move cursor to starting position
    while [ 1 ]
    do
        read -n 1 key
        case "$key" in
	  $UP)
	      arrowUp 1
              checkCell $X $Y 'UP'
              ;;
	  $DOWN)
              arrowDown 1
              checkCell $X $Y 'DOWN'
              ;;
	  $LEFT)
              arrowLeft 1
              checkCell $X $Y 'LEFT'
              ;;
          $RIGHT)
              arrowRight 1
              checkCell $X $Y 'RIGHT'
              ;;
	  $ENTER)
              checkCell $X $Y 'ENTER'
              ;;
          *)  # Catch all and do nothing
	      ;;
        esac
    done
}


## Main ##

initScreen
play

trap 'exit 1' INT TERM
trap 'tput setaf 9; tput cvvis; clear' EXIT

