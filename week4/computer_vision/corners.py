# Local libs
import namespaceCV
import utils

# Python libs
import cv2
import numpy as np

# Sets namespaceCV.IMG to whatever image name was passed in
utils.parseArgs()

img = cv2.imread(namespaceCV.IMG)
cv2.imshow('image', img)

raw_input("Press any key to continue: ")

gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

gray = np.float32(gray)
dst = cv2.cornerHarris(gray,2,3,0.04)

#result is dilated for marking the corners, not important
dst = cv2.dilate(dst,None)

# Threshold for an optimal value, it may vary depending on the image.
img[dst>0.01*dst.max()]=[0,0,255]

cv2.imshow('dst',img)

raw_input("Press any key to close: ")