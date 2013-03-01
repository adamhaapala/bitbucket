#!/bin/sh

## Globals ##

# Pull in config file
./config.sh

ATTEMPTS=0 # Number of active attempts
KEY=(())   # Two-dimensional array containing solution to puzzle
CURSOR=""

## Sub-routines ##

sub randomElement (){
    array=$1
    list_length=#$array
    return $[( $RANDOM % $list_length )+1]
}

# This gets the password for this session of the game
sub selectPass(){
   if [ $PASSWORDLIST ] 
   then 
       list_length=#$PASSWORDLIST
       ran_num=randomElement($list_length)
       return $PASSWORDLIST[$ran_num]
   fi
   return -1
}

# Generates a 10x20 field of random characters
sub generateRandomField(){


}

# Inserts a number of words based on difficulty 
sub placePasswords(){

}

# Moves the cursor to the passed grid location
sub moveCursor(){}

# Main loop 
# only ctrl-c or winning/loosing the game will exit
sub play(){

    CURSOR="0,0"
    moveCursor($CURSOR)
    while [ 1 ]
    do
        read -n 1 key
        case "$key" in

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
