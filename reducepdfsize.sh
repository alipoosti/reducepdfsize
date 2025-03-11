#!/bin/bash

#### FUNCTIONS

# Function to display usage instructions
usage()
{
    echo "usage: ./reducepdfsize.sh [[[-f \"filepath\" ] [-r resolution]] | [-h]]"
}

#### MAIN

# Parse command-line arguments
while [ "$1" != "" ]; do
    case $1 in
        -f | --file )           # Specify the input PDF file
                shift
                INPUT_FILE="$1"
                                ;;
        -r | --resolution )     # Set the resolution for output images
                shift
                RESOLUTION="$1"
                                ;;
        -h | --help )           # Display help message and exit
                usage
                exit
                                ;;
        * )                     # Handle incorrect arguments
                usage
                exit 1
    esac
    shift
done

# Check if the specified file exists
if [ ! -f "$INPUT_FILE" ]; then
  echo "File not found: $INPUT_FILE"
  echo "Make sure to double quote the file path, and use the format ./path/to/the/file/name.pdf"
  exit 1
fi

# Extract the file name and directory path
filename=$(basename "${INPUT_FILE}")
directory=$(dirname "${INPUT_FILE}")

# Generate the new file name with a resolution prefix
new_filename="NEW_r${RESOLUTION}_${filename}"

# Define the destination file path
OUTPUT_FILE="${directory}/${new_filename}"

# Prepare a temporary directory for image extraction
mkdir -p .pdf2jpeg
rm -r .pdf2jpeg
mkdir .pdf2jpeg
OUTPUT_PATH="./.pdf2jpeg/%09d.jpeg"

# Convert the PDF to JPEG images using Ghostscript
# -dSAFER: Restricts file operations for security
# -dQUIET: Suppresses unnecessary output
# -dNOPAUSE: Avoids pausing between pages
# -dBATCH: Ensures the process runs without interaction
# -sOutputFile: Defines the JPEG output format
# -sDEVICE=jpeg: Specifies JPEG as the output format
# -r$RESOLUTION: Sets the image resolution
# -dTextAlphaBits=4 and -dGraphicsAlphaBits=4: Improve text and graphics rendering
# -dUseCIEColor and -dUseTrimBox: Improve color management and trimming
# -dFirstPage=1: Starts conversion from the first page

gs -dSAFER -dQUIET -dNOPAUSE -dBATCH -sOutputFile=$OUTPUT_PATH -sDEVICE=jpeg -r$RESOLUTION -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dUseCIEColor -dUseTrimBox -dFirstPage=1 "${INPUT_FILE}"

# Convert the generated JPEG images back into a PDF
img2pdf ./.pdf2jpeg/*.jpeg -o "${OUTPUT_FILE}"

# Cleanup the temporary directory
rm -r .pdf2jpeg

# Output the result path to the user
echo "Done! Check out the output file at: ${OUTPUT_FILE}"

#### NOTES

# Dependencies:
# Install `img2pdf` before using this script:
# Run: `pip3 install img2pdf`

# Sources:
# - https://superuser.com/questions/1469592/how-can-i-convert-a-pdf-into-a-series-of-images-jpgs-or-pngs-via-the-terminal
# - https://gitlab.mister-muffin.de/josch/img2pdf
