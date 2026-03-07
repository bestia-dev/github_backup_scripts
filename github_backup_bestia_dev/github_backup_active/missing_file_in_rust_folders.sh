# missing_file_in_rust_folders.sh

NEAR_FILE="build_lib_mod.rs"
# Find all folders containing the file NEAR_FILE and warn if rustfmt.toml is missing.
# The first argument is the file to check for.

# Check if the first argument is provided.
if [[ -z "$1" ]]; then
    printf "Error: First argument missing: reference_file  \n"
    printf "Usage: ./missing_file_in_rust_folders.sh <reference_file> \n"
    exit 1
fi

REFERENCE_FILE="$1"

# Function to check for required files
check_files() {
    local dir="$1"
    if [[ ! -f "${dir}/${REFERENCE_FILE}" ]]; then
        #printf "#Warning: ${REFERENCE_FILE} is missing in ${dir} \n"
        printf "cp ${REFERENCE_FILE} ${dir} \n"
    fi
}


printf "Starting search \n"
printf "Check the copy commands to copy the missing files \n"

# Find all directories containing NEAR_FILE and check for REFERENCE_FILE
find . -type f -name "${NEAR_FILE}" | while read -r NEAR_PATH; do
    DIR="$(dirname "${NEAR_PATH}")"
    check_files "${DIR}" "${REFERENCE_FILE}"
done

printf "Search completed. \n"

exit 0