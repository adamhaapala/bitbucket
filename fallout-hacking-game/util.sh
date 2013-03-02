#!/bin/env bash

# Move cursor param 1's spaces in the listed direction
sub arrowUp(){tput cuu$1}
sub arrowDown(){tput }
sub arrowLeft(){tput cub$1}
sub arrowRight(){tput cuf$1}

# Given an array, returns a random
# element
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
sub moveCursor(){ tput cup $1 $2 }

# Get a snazy hexidecimal # for display
sub getHex(){

}

# Takes two strings and says how many 
# characters are the same.
sub passCompare(){

}

# Converts screen location into 
# Grid coordinates and determines
# if selected element is password
# solution
sub checkCell(){
    col=$1
    row=$1
    
}
