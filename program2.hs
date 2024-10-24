{- 
Name    : Manaswini Maddu
Anumber : A25319278
Date    : 04/21/2023
Class   : CS524-01

Program Description:
This program manipulates the image in PPM format. 
The image in ppm is converted to string and then manipulations are performed then again converted to ppm format to write to output file.
The input image fileis hardcoded and we can change the file path for different input images.
In this program, the image can be flipped Horizontally, Vertically, converted to GreyScle, Invert image colors and flatten red, green or blue.
For every operation, separate functions are called.
To specify the kind of data that variable hold type is used and defined for Pixel and Image.
This program takes img as one particular block having red, green and blue after parsed from input.
To flip image horizontally, each pixel or each value in img is reversed.
To flip image vertically, just pixel is reversed. Similarly that manipulations are implemented.
Finally after manipulations it is again converted to ppm format then written to separate output files.
-}


--------------------------------------------------- Importing Required Libraries ------------------------------------------------------

import System.IO                           -- For performing input and output operations (read and write files)
import Data.List.Split                     -- For splitting list into sub lists


--------------------------------------------------- Defining the type for variable ----------------------------------------------------
-- To specify the kind of data that variable holds throught program
type Pixel = (Int, Int, Int)                -- Defined pixel as red, green, blue format (RGB)
type Image = (Int, Int, Int, [[Pixel]])     -- Each image is defined as width, heigh, max color value, and pixel

----------------------------------------------------- Main Function -------------------------------------------------------------------

main :: IO ()                                -- To perfrom I/O actions (printing to console or reading from file) and retuns no value
main = do
    -- Reading the input from a file using readFile command
    content <- readFile "/Users/manaswinimaddu/Downloads/sampleinputs/cake.ppm"


    -- Converting the PPM input to string and storing in img variable
    -- All the manipulations are performed on this variable
    let img = parsePPM content


    -- To flip the image Horizontally calling flipImageHorizontally function for manipulation
    -- And storing the result in horizontallyflippedImg
    let horizontallyflippedImg = flipImageHorizontally img
    -- Converting string to ppm format then writing the output to file
    writeFile "program2_hflip.ppm" (ppmToString horizontallyflippedImg)


    -- To flip the image Vertically calling verticallyflippedImg function for manipulation
    -- And storing the result in verticallyflippedImg
    let verticallyflippedImg = flipImageVertically img
    -- Converting string to ppm format then writing the output to file
    writeFile "program2_vflip.ppm" (ppmToString verticallyflippedImg)


    -- To convert the image to grey scale greyscaleImage function is called for manipulating img
    -- And storing the result in greyedImg
    let greyedImg = greyscaleImage img
    -- Converting string to ppm format then writing the output to file
    writeFile "program2_greyscale.ppm" (ppmToString greyedImg)


    -- To invert the image colors invertImage function is called to manipulate img
    -- And the result is stored in invertedImg variable
    let invertedImg = invertImage img
    -- Converting string to ppm format then writing the output to file
    writeFile "program2_inverted.ppm" (ppmToString invertedImg)
    

    -- To flatten the image red calling the noRedImage function for manipulating img
    -- And the result is stored in noRedImg variable
    let noRedImg = noRedImage img
    -- Converting string to ppm format then writing the output to file
    writeFile "program2_nored.ppm" (ppmToString noRedImg)

    -- To flatten the image green calling the noGreenImage function for manipulating img
    -- And the result is stored in noGreenImg variable
    let noGreenImg = noGreenImage img
    -- Converting string to ppm format then writing the output to file
    writeFile "program2_nogreen.ppm" (ppmToString noGreenImg)

    -- To flatten the image blue calling the noBlueImage function for manipulating img
    -- And the result is stored in noBlueImg variable
    let noBlueImg = noBlueImage img
    -- Converting string to ppm format then writing the output to file
    writeFile "program2_noblue.ppm" (ppmToString noBlueImg)
    
--------------------------------------------------------- Functions -----------------------------------------------------------

------------------------------------------------------- PPM to String ---------------------------------------------------------
-- To convert Input Image in PPM format to Tuples
parsePPM :: String -> Image

-- Takes a string of PPM image file and parses the data into tuple containg 
-- width, height, maximum color value and list of pixel tuples
parsePPM content = (width, height, maxColorValue, groupedPixels)
  where
    allLines = lines content                                  -- Splits the string into list of lines
    -- Splits the header (first 3 lines) and the pixel data (rest of the lines (body))
    (headerLines, pixelData) = splitAt 3 allLines

    -- Flattens the header into list of words and extracts the width, height, maximum color value
    header = concatMap words headerLines
    [_, widthStr, heightStr, maxColorValueStr] = take 4 header
    -- Convertes the string to integer values for the header part
    width = read widthStr :: Int
    height = read heightStr :: Int
    maxColorValue = read maxColorValueStr :: Int
    
    -- Flattens the pixel data (body) into list of words
    pixelStrings = concatMap words pixelData
    -- Converts the each value in list of words into a list of integers using map
    pixelInts = map read pixelStrings :: [Int]
    -- Divides the list of integers into groups of 3 for RGB of each pixel
    pixelTuples = divvy 3 3 pixelInts
    -- Converts each group of 3 integers into a tuple representing the pixel
    pixels = map (\[r, g, b] -> (r, g, b)) pixelTuples
    -- Groups the list of pixel into sub-lists representing the rows of the image with width pixels per row
    groupedPixels = chunksOf width pixels


------------------------------------------------------ String to PPM -----------------------------------------------------------
-- To convert tuple to PPM image file string in ASCII format with header followed by body (pixel data)
ppmToString :: Image -> String
-- The image tuple is unpacked into its components
ppmToString (width, height, maxColorValue, pixels) = unlines (header ++ pixelData)
  where
    -- Creates the header lines of the PPM image file
    header = ["P3", show width, show height, show maxColorValue]

    -- Flattens the list of pixel rows into a single list of pixels
    flatPixels = concat pixels
    -- Converts each pixel tuple into space separated string of its RGB components
    pixelStrings = map (\(r, g, b) -> unwords [show r, show g, show b]) flatPixels
    -- Groups the pixel strings into sub lists representing the rows of image with width pixels per row
    -- And converts each sub list to space separated string of the pixels in that row.
    pixelData = map unwords (chunksOf width pixelStrings)


--------------------------------------------- Flip Image Horizontally ------------------------------------------------------------
-- Flips the image horizontally by taking the tuple of width, height, maximum color value and list if pixel tuples as input
flipImageHorizontally :: Image -> Image
-- It unpacks the image tuple into its components and creates a new image tuple with horizontally flipped pixel data
flipImageHorizontally (width, height, maxColorValue, pixels) = (width, height, maxColorValue, horizontallyflippedPixels)
  where
    -- Flips the list of pixel tuples in each row of image horizontally using reverse
    horizontallyflippedPixels = map reverse pixels


------------------------------------------------ Flip Image Vertically ------------------------------------------------------------
-- Flips the image vertically by taking the tuple of width, height, maximum color value and list if pixel tuples as input
flipImageVertically :: Image -> Image
-- It unpacks the image tuple into its components and creates a new image tuple with verticalluy flipped pixel data
flipImageVertically (width, height, maxColorValue, pixels) = (width, height, maxColorValue, verticallyflippedPixels)
  where
    -- It flips the order of pixel rows in the image using reverse function.
    verticallyflippedPixels = reverse pixels


------------------------------------------------- Convert to Greyscale ------------------------------------------------------------
-- Manipulating the input r,g,b to grey scale of r,g,b
toGray :: (Int, Int, Int) -> (Int, Int, Int)
-- First it unpacks the RGB to three components then computes the average of 3 color channels for each component
-- Then creates a new tuple with grey scale for each channel resulting to greyscale tuple.
toGray (r, g, b) = ((r + g + b) `div` 3, (r + g + b) `div` 3, (r + g + b) `div` 3)

-- Helper function that takes RGB tuple and returns a greyscale tuple with same value for each channel (r,g,b)
toGrayscale :: [(Int, Int, Int)] -> [(Int, Int, Int)]
-- Called the manipulating function to perform on each component
toGrayscale pixels = map toGray pixels

-- Converts the pixels to greyscale by taking the tuple of width, height, maximum color value and list if pixel tuples as input
greyscaleImage :: Image -> Image
-- It unpacks the image tuple into its components and creates a new image tuple with greyed pixel data
greyscaleImage (width, height, maxColorValue, pixels) = (width, height, maxColorValue, greyedPixels)
  where 
    -- Called the helper function to perform manipulation on each component to change to grey scale
    greyedPixels = map toGrayscale pixels


------------------------------------------------------ Invert Image Colors --------------------------------------------------------
-- Manipulating all the components to invert the image
invert :: (Int, Int, Int) -> (Int, Int, Int)
-- Inverted the colors  by negating them (subtracting each value from 255)
invert (r, g, b) = (r-255, g-255, b-255)

-- Helper function that takes RGB tuple and returns the inverted image with same value for each channel (RGB)
invertList :: [(Int, Int, Int)] -> [(Int, Int, Int)]
-- Called the manipulating function to perform on each component
invertList pixels = map invert pixels

-- Converts the image to inverted image by taking the tuple of width, height, maximum color value and list if pixel tuples as input
invertImage :: Image -> Image
-- It unpacks the image tuple into its components and creates a new image tuple with inverted pixel data
invertImage (width, height, maxColorValue, pixels) = (width, height, maxColorValue, invertedPixels)
  where 
    -- Called the helper function to perform manipulation on each component to invert the colors 
    invertedPixels = map invertList pixels


------------------------------------------------------ Flatten Red ------------------------------------------------------------------
-- Remove the red color channel by setting the red channel of each list to 0.
removeRed :: [(Int, Int, Int)] -> [(Int, Int, Int)]
removeRed pixels = [(0, g, b) | (r, g, b) <- pixels]

-- Converts to flatten red image by taking the tuple of width, height, maximum color value and list if pixel tuples as input
noRedImage :: Image -> Image
-- It unpacks the image tuple into its components and creates a new image tuple with no red pixel data
noRedImage (width, height, maxColorValue, pixels) = (width, height, maxColorValue, noRedPixels)
  where 
    -- Called the helper function to perform manipulation on each component of the list to remove red component
    noRedPixels = map removeRed pixels


------------------------------------------------------ Flatten Green ------------------------------------------------------------------
-- Remove the green color channel by setting the green channel of each list to 0.
removeGreen:: [(Int, Int, Int)] -> [(Int, Int, Int)]
removeGreen pixels = [(r, 0, b) | (r, g, b) <- pixels]

-- Converts to flatten green image by taking the tuple of width, height, maximum color value and list if pixel tuples as input
noGreenImage :: Image -> Image
-- It unpacks the image tuple into its components and creates a new image tuple with no green pixel data
noGreenImage (width, height, maxColorValue, pixels) = (width, height, maxColorValue, noGreenPixels)
  where 
    -- Called the helper function to perform manipulation on each component of the list to remove green component
    noGreenPixels = map removeGreen pixels


------------------------------------------------------ Flatten Blue --------------------------------------------------------------------
-- Remove the blue color channel by setting the blue channel of each list to 0.
removeBlue:: [(Int, Int, Int)] -> [(Int, Int, Int)]
removeBlue pixels = [(r, g, 0) | (r, g, b) <- pixels]

-- Converts to flatten blue image by taking the tuple of width, height, maximum color value and list if pixel tuples as input
noBlueImage :: Image -> Image
-- It unpacks the image tuple into its components and creates a new image tuple with no blue pixel data
noBlueImage (width, height, maxColorValue, pixels) = (width, height, maxColorValue, noBluePixels)
  where
    -- Called the helper function to perform manipulation on each component of the list to remove blue component 
    noBluePixels = map removeBlue pixels