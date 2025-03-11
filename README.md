# Reduce PDF Size Script 📉📄

## Overview 🌟
This script converts a given PDF file into a series of JPEG images using Ghostscript and then reassembles them into a new, compressed PDF using `img2pdf`. The result is a lower-sized PDF while maintaining reasonable quality.

#VISA 🛂 #IRCC 🇨🇦 #SCHENGEN 🏰

## Features ✨
- Converts a PDF into high-quality JPEG images 🖼️
- Reassembles the JPEG images into a new, compressed PDF 📑
- Allows setting custom resolution for better control over quality and size ⚙️
- Works via command-line arguments 💻
- Super useful for official online applications such as Visa Applications 🎟️


## Prerequisites
Before running this script, ensure you have the following dependencies installed:

### Install Ghostscript
Ghostscript is required for PDF-to-JPEG conversion. Install it using:

**Ubuntu/Debian:**
```sh
sudo apt install ghostscript
```

**Mac (using Homebrew):**
```sh
brew install ghostscript
```

**Windows:**
Download and install from [Ghostscript's official website](https://www.ghostscript.com/download.html).

### Install img2pdf
`img2pdf` is used to reassemble JPEG images back into a PDF. Install it using:

```sh
pip3 install img2pdf
```

## Usage
Run the script with the following options:

```sh
./reducepdfsize.sh -f "path/to/input.pdf" -r resolution
```

### Parameters:
- `-f, --file`: Specifies the input PDF file (required)
- `-r, --resolution`: Defines the image resolution in DPI (default is 150, higher values increase quality but also size)
- `-h, --help`: Displays usage information

### Example Usage
```sh
./reducepdfsize.sh -f "./documents/sample.pdf" -r 100
```
This will reduce the size of `sample.pdf` using a resolution of 100 DPI and save the output in the same directory with a prefixed filename.

## How It Works
1. The script extracts the input PDF file's name and directory.
2. It creates a temporary directory `.pdf2jpeg` for storing intermediate JPEG images.
3. The script uses Ghostscript to convert the PDF into JPEG images based on the specified resolution.
4. The `img2pdf` tool is used to combine the JPEG images back into a single PDF.
5. The temporary files are deleted, and the new PDF is saved with a modified name (`NEW_r{resolution}_original.pdf`).

## Adding a Convenient Alias for Quick Access

You can add an alias to your `~/.zshrc` (or `~/.bashrc`) file so you can run `reducepdfsize.sh` from anywhere without typing the full path.  

### **1. Open your `~/.zshrc` file**  
Run this command to edit it:  
```sh
nano ~/.zshrc
```

---

### **2. Add the Alias**  
Scroll to the bottom and add this line:  
```sh
alias reducepdf="~/path/to/reducepdfsize.sh"
```
👉 **Replace** `~/path/to/reducepdfsize.sh` with the actual path to your script.  
For example, if it’s in your `Documents` folder:  
```sh
alias reducepdf="~/Documents/reducepdfsize.sh"
```

---

### **3. Save and Exit**  
- Press **CTRL + X** to exit.  
- Press **Y** to confirm changes.  
- Press **Enter** to save.

---

### **4. Apply Changes**  
Run:  
```sh
source ~/.zshrc
```

---

### **5. Test Your Alias**  
Now, you can simply type:  
```sh
reducepdf -f "path/to/file.pdf" -r 100
```
instead of  
```sh
~/Documents/reducepdfsize.sh -f "path/to/file.pdf" -r 100
```

🚀 **Now, your script is super easy to run!** 😃

## Notes
- Ensure you provide the correct file path, wrapped in double quotes if it contains spaces.
- Higher resolutions improve quality but may increase file size.
- The script automatically cleans up temporary files after execution.

---
## License
This script is provided "as-is" without warranty. You are free to use, modify, and distribute it as needed.
