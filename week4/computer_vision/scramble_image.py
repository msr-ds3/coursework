# Local libs
import namespaceCV
import utils

# Python libs
import cv2
import PIL
import numpy as np
from matplotlib import pyplot as plt

# Sets namespaceCV.IMG to whatever image name was passed in
utils.parseArgs()

# Color histogram
img = cv2.imread(namespaceCV.IMG)

np.random.shuffle()

color = ('b','g','r')

img_obj = PIL.Image.fromarray(img, 'RGB')

img_obj.show()
