#!/usr/bin/env python
"""Plot range data as collected by dumpranges.py

This script can be run from the command-line without using ROS. It
expects a single argument, the name of the file saved by
dumpranges.py. E.g.,

    ./rplotter.py savedranges.txt

SCL; 11 Mar 2015
"""
from __future__ import print_function
import sys
import numpy as np
import matplotlib.pyplot as plt


def plot_scan(range_row):
    x, y, theta = range_row[:3]
    angle_min, angle_max, angle_inc = range_row[3], range_row[4], range_row[5]
    range_min, range_max = range_row[6], range_row[7]
    ranges = np.array(range_row[8:])
    angles = np.array([i*angle_inc + angle_min for i in range(len(ranges))])

    # Ignore measurements that are outside the valid range
    valid_indices = []
    for i, r in enumerate(ranges):
        if r < range_max and r > range_min:
            valid_indices.append(i)

    ranges_in_rect = np.array([x+ranges[valid_indices]*np.cos(angles[valid_indices]+theta),
                               y+ranges[valid_indices]*np.sin(angles[valid_indices]+theta)])
    plt.plot(ranges_in_rect[0], ranges_in_rect[1], '.')


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print('Usage: rplotter.py FILE')
        sys.exit(1)

    range_data = np.loadtxt(sys.argv[1])

    plt.hold(True)
    for i, range_row in enumerate(range_data):
        plot_scan(range_row)
    plt.plot(range_data.T[0], range_data.T[1], 'b.-')
    plt.show()
