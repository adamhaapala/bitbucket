#!/bin/env bash

# Move cursor param N spaces in the listed direction
sub arrowUp(){tput cuu$1}
sub arrowDown(){tput cud$1}
sub arrowLeft(){tput cub$1}
sub arrowRight(){tput cuf$1}

# Highlighting tputs
sub highlightOn(){tput smso}
sub highlightOff(){tput rmso}

#Cursor functions
sub remCursor(){tput sc}
sub restCursor(){tput rc}
sub moveCursor(){ tput cup $1 $2 }

# Clearing functions
sub clearScreen(){tput clear}
sub clearToEOL(){tput el}
sub clearToEOS(){tput ed}

# Write hightlighted text
# Sig: startX, startY, text
sub hightlight(){
    startX=$1
    startY=$2
    txt=$3
    moveCursor($startX,$startY)
    highlightOn()
    echo -n $txt
    highlightOff()
}

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

sub inPlay(){}
sub inPuzzle(){}

# Receive coordinates (probably
# from cursor position) and checks
# game status of location
# i.e. what container is it in,
# is it part of ornimentation
# or puzzle, 
sub checkCell(){
    X=$1
    Y=$2
    KEY=$3

    # Check container
    if [ inPlay($X,$Y)]
    then
        if [ inPuzzle($X,$Y) ]
        then
            contents=getGridCell($X,$Y)
            word=$contents['value']
            range=$contents['range']
            if [ ${#word} > 1 ]  # Check to see if it's a random char or a pass
            then
		# So this is a password.  Lets kick-on the highlighting
		remCursor()
                highlight($range['startX'],$range['startY'],$word)
                restCursor()
                # while keeping state of the cursor
                if [$KEY -eq "ENTER"] 
                then
                    results=passCompare()
                    if [$results == ${#PASSWORD}] 
                    then
		    else
                    fi
                    writeHistSect(getHistSect())
                fi
            else
            fi
        else
            return ""
        fi
    elif [inHist()]
	return ""
    else
        return ""
    fi
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
    remCursor()
    playText=getPlayArea()
    histText=getHistoryArea()
    clearScreen()
    writePlaySect($playText)
    writeHistSect($histText)
    restCursor()
}
