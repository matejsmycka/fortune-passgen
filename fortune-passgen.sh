#!/bin/env bash

show_help() {
    echo "Usage: $(basename "$0") [options] [num_words]"
    echo ""
    echo "Options:"
    echo "  -h            Show this help message and exit"
    echo "  -u            Keep uppercase letters in the generated words"
    echo "  -p            Include punctuation in the generated words"
    echo "  -n NUM        Generate NUM passwords (default: 1)"
    echo ""
    echo "Arguments:"
    echo "  num_words     Number of words to generate per password (default: 4)"
}

generate_word() {
    while :; do
        local fortune_line word
        fortune_line=$(fortune | head -n1)
        [ "$keep_upper" != "true" ] && fortune_line=$(echo "$fortune_line" | tr '[:upper:]' '[:lower:]')
        [ "$include_punct" != "true" ] && fortune_line=$(echo "$fortune_line" | tr -d '[:punct:]')
        word=$(echo "$fortune_line" | awk '{ for (i=1; i<=NF; i++) if (length($i) >= 5) print $i }' | shuf -n 1)
        [ -z "$word" ] && continue
        echo "$word"
        break
    done
}

generate_special() {
    local special
    special=$(shuf -n 1 -e '=' '!' '@' '#' '$' '%' '^' '&' '*' '-' '_' '+' '?'  '~')
    echo "$special"
}

# Check if fortune is installed
if ! command -v fortune &>/dev/null; then
    echo "Error: 'fortune' is not installed. Please install it and try again."
    exit 1
fi

# Default values
num_words=4
num_passwords=1
keep_upper=false
include_punct=false

# Parse options
while getopts "hupn:" opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        u)
            keep_upper=true
            ;;
        p)
            include_punct=true
            ;;
        n)
            num_passwords=$OPTARG
            ;;
        *)
            show_help
            exit 1
            ;;
    esac
done
shift $((OPTIND - 1))

# Set number of words if provided
if [ -n "$1" ]; then
    num_words=$1
fi

# Generate passwords
for ((j = 1; j <= num_passwords; j++)); do
    for ((i = 1; i <= num_words; i++)); do
        space=$(generate_special)
        if (( i == num_words )); then
            echo -n "$(generate_word)"
        else
            echo -n "$(generate_word)$space"
        fi
    done
    echo ""
done