#!/bin/env bash

# Move cursor param N spaces in the listed direction
sub arrowUp(){tput cuu$1}
sub arrowDown(){tput cud$1}
sub arrowLeft(){tput cub$1}
sub arrowRight(){tput cuf$1}


# Generate the attempts string
sub getAttemptsString(){
    string=$ATTEMPTS" ATTEMPT\(S\) LEFT:"
    for i in $ATTEMPTS
    do
        string=$STRING" \O219"
    done
    return $string
}

# Given an array, returns a random
# element
sub randomElement (){
    array=$1
    list_length=#$array
    return $[( $RANDOM % $list_length )+1]
}

# Generates a random ascii char
# Will need to be refined but good enough for now
sub getRandomChar(){
    rand=$[($RANDOM%256)+1]
    return "\O"$rand
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

# Generates a field of random characters
sub generateRandomField(){
    for i in $GRIDHEIGHT
    do
       for j in $GRIDWIDTH
       do
         $GRID[$i][$j]=getRandomChar()
       done
    done
    placePasswords()
}

# Inserts a number of words based on difficulty 
sub placePasswords(){

}

# Moves the cursor to the passed grid location
sub moveCursor(){ tput cup $1 $2 }

# Get a snazy hexidecimal # for display
sub getHex(){
    char=`echo $1 | hexdump -x | head -1 | awk '{print $2}' | tr '[:lower:]' '[:upper:]'`
    return "0x"$char
}

# Takes two strings and says how many 
# characters are the same.
sub passCompare(){
    pass1=$1 # Correct pass
    pass2=$2 # Attempt
    matches=0

    for ((i=0;$i<${#pass1} ;$((i++)) ))
    do
        if [ ${pass1:$i} -eq ${pass2:$i}] 
        then
            $((matches++))
	fi
    done

    return $matches
}

# Converts screen location into 
# Grid coordinates and determines
# if selected element is password
# solution
sub checkCell(){
    col=$1
    row=$1
    
}

# Return string of play area
sub getPlayArea(){
    out=$TERMHEADER"\n"
    temp1=getAttemptsString()
    out=$out$temp1
    playCol1=$($GRIDWIDTH/2 | bc )    # width of char cols
    end=$GRIDWIDTH-1
    for i in $GRIDHEIGHT
    do
        prettyHex=getHex($GRID[$i][0])
        out=$out"\n"$prettyHex" "
        
        for j in `seq $playCol1`
        do
           out=$out" "$GRID[$i][$j]$
        done
        playCol2=$playCol1+1
        prettyHex2=getHex($GRID[$i][$playCol2])
        out=$out" "$prettyHex2" "
        for t in `seq $playCol2 $end`
        do
            out=$out$GRID[$i][$t]
        done
    done
    return $out
}

# Get string to print in history area
# History length is managed when 
# that list is written to
sub getHistoryArea(){
    hist_size=$(#HISTORY)
    out=""
    for i in $hist_size
    do
        line=$HISTORY[$i]
        out=$OUT$line"\n"
    done
    return $out
}


# Redraw both puzzle and history sides of screen
sub refresh(){
    playText=getPlayArea()
    histText=getHistoryArea()

    
}
