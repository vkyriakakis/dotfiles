#!/usr/bin/env bash

# To do:

# theming me split se bg/fg
# config keys


print_calendar(){
	reset="\e[0m"
    row=$(( ($(tput lines) - 8) / 2))

    # Center calendar vertically (cal's output is always 8 lines)
    cols=$((($(tput cols) - 22) / 2))
    tput cup $row $cols

    line=$(echo "$calendar" | head -c 20)
    printf "%b\n" "${months_color}${line}${reset}"

    # Print the day names
    let row++
    tput cup $row $cols

    line=$(echo "$calendar" | tail -n +2 | head -c 20)

    printf "%b\n" "${weekday_color}${line}${reset}"

    # Print the days of the month
    echo "$calendar" | tail -n +3 | while IFS= read -r line; do
    	# Center horizontally
    	let row++
    	tput cup $row $cols

    	if [ $year = $cur_year ] && [ $month = $cur_month ]; then
	    	# If the line contains today's date, add the highlight
	    	if echo "$line" | grep -qw $cur_day; then
	    		highlight_expr=s/"$cur_day"/"\\${highlight_color}${cur_day}\\${reset}"/
	    		line=$(echo "$line" | sed -e "$highlight_expr")
	        fi
	    fi

        # Output the line
        printf "%b\n" "$line"
    done
}

# ----------------------- User Configuration -----------------------#
highlight_color='\e[0;43;1;30m'
months_color='\e[0;43;1;30m'
weekday_color='\e[0;43;30m'

prev_year='w'
next_year='s'
prev_month='a'
next_month='d'
quit='q'
#-------------------------------------------------------------------#

# Print the current month's calendar
cur_year=$(date +%Y)
cur_month=$(date +%-m)
cur_day=$(date +%-d)

year=$cur_year
month=$cur_month

calendar=$(ncal -bh -m $cur_month $cur_year)
print_calendar

# The user can change the current month/year with the arrow keys
while read -n1 -s opt;
do
	case $opt in
		$prev_year )
			let year=year-1
			;;
		$next_year )
			let year=year+1
			;;
		$prev_month )
			let month=month-1
			if (($month == 0)); then
				month=12
			fi
			;;
		$next_month )
			let month=month+1
			if (($month == 13)); then
				month=1
			fi
			;;
		$quit )
			break 2
	esac

	calendar=$(ncal -bh -m $month $year)
	print_calendar

done
