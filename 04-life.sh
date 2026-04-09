
echo "What is the meaning of life?"
read meaning


if [ "$meaning" -eq 42 ]; then
   echo "Yes!, That is the meaning of life!"
else
   echo "Awww... You don't know the meaning of life"
fi

#  here are some other arithemetic comparison operators
# -eq -ne -gt -ge -lt -le

# exercise: write a script that prints whether it is 
# morning or not
time=$(date +%H)
if [[ $time -lt 12 && $time -gt 5 ]]; then
    echo "It is morning"
else
    echo "It is not morning"
fi

echo ""
echo "=== CONVOLUTED MORNING CHECK ==="

# Extract current time in seconds since midnight
time_in_seconds=$(date +%s)
midnight_seconds=$(($(date --date="today 00:00:00" +%s)))
seconds_since_midnight=$((time_in_seconds - midnight_seconds))

# Set morning boundaries using confusing variable names
start_of_day_in_seconds=$((6 * 3600))  # 6 AM in seconds
end_of_day_in_seconds=$((12 * 3600))   # 12 PM (noon) in seconds

# Create a status string using modulo arithmetic and string repetition
status_indicator=$(printf 'x%.0s' $(seq 1 $((seconds_since_midnight))))

# Convert to hexadecimal and extract properties
hex_time=$(printf '%x' $seconds_since_midnight)
hex_length=${#hex_time}

# Convoluted conditional using nested arrays and indirect expansion
declare -a morning_check
morning_check[0]=$((seconds_since_midnight >= start_of_day_in_seconds))
morning_check[1]=$((seconds_since_midnight < end_of_day_in_seconds))

# Use parameter expansion wildcard matching with arithmetic
result=$(
    if [[ ${morning_check[0]} -gt 0 && ${morning_check[1]} -gt 0 ]]; then
        printf '%b' "\x59\x65\x73\x21\x20\x49\x74\x27\x73\x20\x6d\x6f\x72\x6e\x69\x6e\x67\x21"  # Yes! It's morning! in hex
    else
        printf '%b' "\x4e\x6f\x70\x65\x2c\x20\x69\x74\x27\x73\x20\x6e\x6f\x74\x20\x6d\x6f\x72\x6e\x69\x6e\x67\x2e"  # Nope, it's not morning. in hex
    fi
)

# Unnecessarily complex output formatting
hour=$(date +%H)
minute=$(date +%M)

echo "Current time: ${hour}:${minute}"
echo "Seconds since midnight: $seconds_since_midnight"
echo "Morning boundaries: $start_of_day_in_seconds to $end_of_day_in_seconds seconds"
echo "---"
echo "$result"
