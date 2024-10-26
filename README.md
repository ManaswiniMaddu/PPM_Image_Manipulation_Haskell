# PPM_Image_Manipulation_Haskell
A simple Haskell program for reading, transforming, and writing PPM images. Includes functionality to flip images, convert to greyscale, and manipulate color channels using functional programming techniques. Ideal for learning Haskell and image manipulation. 

# Program Description
This Haskell program manipulates images in the PPM (Portable Pixmap) format. It reads a PPM image, performs various transformations, and outputs the manipulated image in PPM format. The program provides operations including:
1. Horizontal and vertical flipping
2. Conversion to grayscale
3. Inversion of colors
4. Flattening of the red, green, or blue color channels
Each manipulation has a dedicated function, and the program uses custom types to specify data types for Pixel and Image structures.

# Features
Flip Horizontally - Reverses the pixels in each row.
Flip Vertically - Reverses the order of rows in the image.
Convert to Grayscale - Averages the RGB values to create a grayscale image.
Invert Colors - Inverts RGB values for each pixel.
Flatten Colors - Removes either the red, green, or blue component from each pixel.

# Program Structure

1. Libraries
System.IO - For file input and output.
Data.List.Split - For splitting lists.

2. Types Defined
Pixel: Represents a pixel with RGB values in a tuple: (Int, Int, Int).
Image: Represents an image as a tuple: (Width, Height, Max Color Value, [[Pixel]]).

3. Main Function Workflow
Reads a hardcoded PPM image file (e.g., cake.ppm) and converts it to a string.
Parses the string to obtain the image data as an Image tuple.
Calls each manipulation function to apply transformations and writes each output to a new PPM file.

4. Manipulation Functions
parsePPM: Converts PPM formatted string to an Image tuple.
ppmToString: Converts an Image tuple back to a PPM formatted string.
flipImageHorizontally and flipImageVertically: Flip the image pixels accordingly.
greyscaleImage: Converts an image to grayscale.
invertImage: Inverts the RGB values of each pixel.
noRedImage, noGreenImage, noBlueImage: Remove the specified color channel from the image.

# Example File Paths
To adjust the input image file, modify the file path in main. The output files are saved in the program's directory with the following names:
program2_hflip.ppm
program2_vflip.ppm
program2_greyscale.ppm
program2_inverted.ppm
program2_nored.ppm
program2_nogreen.ppm
program2_noblue.ppm

# Usage
Ensure the input file (e.g., cake.ppm) exists at the specified path.
Run the program. The manipulated images will be saved as separate files.
