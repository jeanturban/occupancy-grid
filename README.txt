Jean-Alexandre Turban
ME/CS 132

**Homework 7 (Mini Projet)**

**=======================**
Included Files
**=======================**
In the zip folder you will find, 5 Images, 3 sets of .txt data, and the matlab file Occupancy_grid.m.

**IMAGES**

Included in the images are the Occupancy Maps for the LAB data with no obstacles, the LAB data WITH obstacles, and the simulation data. Each image has three parts to it: an image of the occupancy map halfway through the algorithm, an image of the map before converting the log odds, and a finalized version of the occupancy map.

These images are clearly title.

Additionally, you will find an image containing the results of rplotter.py using the simulation data. This is simply for comparison the occupancy map I produced for the simulation data.

The last image you will find is simply a photo of the lab the day the data was collected.


**FILES**

The data files included are the simulation data (savedranges.txt), the LAB data with no obstacles (savedranges_one.txt), and the LAB data WITH obstacles (savedranges_three.txt).

The other file included is ‘occupancy_grid.m’ - a matlab file which makes an occupancy map given a .txt data file and displays the result.
This file was modeled using the Bayes filter suggested in the guidelines. It can be run by opening Matlab and typing “occupancy_grid(‘datafile.txt’)”. It will show you a real time update on the occupancy map and in the end show you the final occupancy map.


**IMPORTANT NOTES**
First off, please note that the scale in my pictures is slightly off… I assume this doesn’t matter but we can see this just by looking at the axis labeling of the pictures. The end result is still the same, just a little stretched out… THIS IS NOT A PRODUCT OF THE ALGORITHM, rather a product of me trying to fit the image into my computer screen…… Regardless, I DO NOT see why I would be marked off for this so please contact me if you would like less-stretched pictures

Also, I lost all of my LAB data when my computer crashed and had to use Esther Du’s. These files are savedranges_one.txt and savedranges_three.txt


**ROS**
I installed ROS on Ubuntu 14.04 and simply followed instructions from Piazza and the Homework to run and get the simulation data and plotter.py… This was covered extensively in Piazza 