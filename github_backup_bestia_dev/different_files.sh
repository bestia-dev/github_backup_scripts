# different_files.sh

# Find all files named like the first argument and compare them with a reference file.
# The reference file must be in the working directory and it is the first argument.

# Check if the first argument is provided.
if [[ -z "$1" ]]; then
    printf "Error: First argument missing: reference_file  \n"
    printf "Usage: ./different_files.sh <reference_file>\n"
    exit 1
fi

REFERENCE_FILE="$1"

# Check if the reference file exists.
if [[ ! -f "$REFERENCE_FILE" ]]; then
    printf "Error: Reference file does not exist: $REFERENCE_FILE \n"
    exit 1
fi

# Function to compare files.
compare_files() {
    local file="$1"
    if ! diff -q "$file" "$REFERENCE_FILE" > /dev/null; then
        printf "code --diff \"$REFERENCE_FILE\" \"$file\" \n"
    fi
}

# Export the function and the reference variable so it can be used in find's -exec.
export -f compare_files
export REFERENCE_FILE
export REFERENCE_FILE

printf "Starting search \n"

# Find all files named $REFERENCE_FILE and compare with reference file.
find . -type f -name "$REFERENCE_FILE" -exec bash -c 'compare_files "$0"' {} \;

printf "Search completed. \n"

exit 0
