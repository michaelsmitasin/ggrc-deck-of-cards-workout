#! /bin/sh
# 2020-06-06
# Simple shell script to generate a "Deck of Cards" workout
# Shuffle a deck of cards (inc. jokers), split it in half, and for each suit, do a given activity for the first half
# where the number of reps is the number on the card. Repeat for the second half, but with different activities.

SUITS="hearts clubs diamonds spades"
RANKS="1x 2x 3x 4x 5x 6x 7x 8x 9x 10x 10x 10x 10x"
SETNUM="54"

# Build the deck of SUITS x RANKS
MAKEFULLDECK(){
	for SUIT in $SUITS
	do
		for RANK in $RANKS
		do
			echo "$RANK-$SUIT"
		done
	done
}

DECK=$(MAKEFULLDECK)

# Add in jokers
FULLDECK="$DECK 50x-jumping-jacks 10x-burpees"

# Shuffle the deck
SHUFFLEDDECK=$(echo $FULLDECK | tr " " "\n" | sort -R)

# Split the deck in half and assign activities to each suit
FIRSTHALF=$(echo "$SHUFFLEDDECK" | head -27 | sort -R | sed 's/hearts/squat-thrusts/g;s/clubs/push-ups/g;s/diamonds/calf-raise-squats/g;s/spades/sit-ups/g')
SECONDHALF=$(echo "$SHUFFLEDDECK" | tail -27 | sort -R | sed 's/hearts/jumping-jacks/g;s/clubs/standing-dumbbell-presses/g;s/diamonds/lunges/g;s/spades/standing-side-crunches/g')

# Recombine the halves
ALLSETS="$FIRSTHALF $SECONDHALF"

# Loop through the set for each activity
for SET in $ALLSETS
do
	clear
	echo "Sets to go: $SETNUM"
	echo ""
	echo "$SET" | tr "-" " "
	echo ""
	SETNUM=$(echo "$SETNUM - 1" | bc)
	read -p "Press any key..." -n1 -s
	echo ""
done

clear
echo "Good work! That's it!"
echo ""
