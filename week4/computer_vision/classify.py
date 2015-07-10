# Python libs
import cv2
from SimpleCV import *
from sklearn.svm import LinearSVC
from sklearn.linear_model import LogisticRegression
import numpy as np
import os
import shutil

# Local libs
import namespaceCV
import utils

def _setupClasses():
    '''
    Summary:
        Checks to ensure that legitimate classes were provided at the command prompt (and if none, sets default).

    Returns:
        Class names
    '''
    if not namespaceCV.DEFAULTCLASS:
        # Get first class
        class_1 = raw_input("Enter first class name: ")
        while not os.path.isdir(namespaceCV.CALTECH + class_1):
            print "Did not recognize class name:", class_1, "\n"
            class_1 = raw_input("Re-enter first class name: ")

        # Get second class
        class_2 = raw_input("Enter second class name: ")
        while not os.path.isdir(namespaceCV.CALTECH + class_2):
            print "Did not recognize class name:", class_2, "\n" 
            class_2 = raw_input("Re-enter second class name: ")
    else:
        class_1 = "hedgehog"
        class_2 = "accordion"

    return class_1, class_2

def _featurizeDataForClass( class_data ):
    '''
    Args:
        class_data (ImageSet): contains the raw images to be featurized

    Summary:
        Applies high level features to raw images

    Returns:
        (dict): containing the featurized images, where the key is the image number.
    '''

    # Collect features for each class
    temp = []

    # Initiate SIFT detector
    for raw_image in class_data:
        # Apply favorite feature..
        result = np.array(_histograms(raw_image))
        temp.append(result[0])

    featurized_images = np.array(temp).squeeze()
    
    return featurized_images

def _histograms( raw_image ):
    '''
    Args:
        raw_image (Image)

    Returns:
        (list): containing three color histograms in b, g, r order
    '''
    # Convert to numpy
    numpy_image = raw_image.getNumpyCv2()
    color = ['b','g','r']
    histograms = []
    for i,col in enumerate(color):
        histograms.append(cv2.calcHist([numpy_image],[i],None,[256],[0,256]))

        
    return histograms


def _sift(raw_image):
    '''
    Args:
        raw_image (Image)

    Returns:
        (list): containing all sift keypoints
    '''
    orb = cv2.ORB()
    numpy_image = raw_image.getNumpyCv2()

    # APPLY FEATURES HERE
    all_keypoints, des1 = orb.detectAndCompute(numpy_image,None) # Finds sift keypoints
    keypoints = [all_keypoints[i].pt for i in range(len(all_keypoints))]

    return keypoints

def _split_into_labeled_unlabeled( img_class ):
    '''
    Args:
        img_class (str): Specifies which class of images we're dealing with

    Summary:
        Splits the data for the specified class into a training set ('labeled') and holds out a small set ('unlabeled') for evaluation.
    '''
    
    # Grab all images in this class
    files = [ f for f in os.listdir(namespaceCV.CALTECH + img_class + "/") if os.path.isfile(os.path.join(namespaceCV.CALTECH + img_class + "/",f)) ]
    
    # First loop dump images into labeled, second loop dump some labels in unlabeled
    dirs_to_make = ["/labeled", "/unlabeled"]
    itr = 0
    for directory in dirs_to_make:
        if (not os.path.isdir(namespaceCV.CALTECH + img_class + directory)):
            # If the directory didn't exist, make it
            os.mkdir(namespaceCV.CALTECH + img_class + directory)

        if os.listdir(namespaceCV.CALTECH + img_class + directory) == []:
            # If it's empty add stuff
            if itr == 0:
                # Copy files over into the training directory
                for i in range(len(files) - namespaceCV.NUMTEST):
                    shutil.copy(namespaceCV.CALTECH + img_class + "/" + files[i], namespaceCV.CALTECH + img_class + directory)
            else:
                # Copy them over into the evaluation directory
                for i in range(1,namespaceCV.NUMTEST + 1):
                    shutil.copy(namespaceCV.CALTECH + img_class + "/" + files[-i], namespaceCV.CALTECH + img_class + "/unlabeled")
        itr += 1


def main():
    # Basic init
    utils.parseArgs()
    data_path = namespaceCV.CALTECH
    class_1, class_2 = _setupClasses()
    display = Display((800,600)) # Display to show the images
    target_names = [class_1, class_2]

    # Make labeled/unlabeled folders
    _split_into_labeled_unlabeled( class_1 )
    _split_into_labeled_unlabeled( class_2 )

    # Load training data
    class_1_data = ImageSet(data_path + class_1 + "/" + namespaceCV.LABELED)
    class_2_data = ImageSet(data_path + class_2 + "/" + namespaceCV.LABELED)
    
    # Featurize image data, put into the correct format.
    class_1_features = _featurizeDataForClass(class_1_data)
    class_2_features = _featurizeDataForClass(class_2_data)
    
    # Create full data set and labels
    full_data = np.array(np.ndarray.tolist(class_1_features) + np.ndarray.tolist(class_2_features))
    labels = np.array([0 for i in range(len(class_1_features))] + [1 for i in range(len(class_2_features))])

    print 'Training'
    svc = LinearSVC()
    svc = svc.fit(full_data, labels)
    log_reg = LogisticRegression().fit(full_data, labels)

    # ---- PREDICTION ----

    print 'Running prediction on class 1'
    unlabeled_class_1 = ImageSet(data_path + class_1 + "/" + namespaceCV.UNLABELED)
    featurized_class_1_predict = _featurizeDataForClass(unlabeled_class_1)

    predictions_1 = svc.predict(featurized_class_1_predict)
    probabilities_1 = log_reg.predict_proba(featurized_class_1_predict)

    print 'Running prediction on class 2'
    unlabaled_class_2 = ImageSet(data_path + class_2 + "/" + namespaceCV.UNLABELED)
    featurized_class_2_predict = _featurizeDataForClass(unlabaled_class_2)

    predictions_2 = svc.predict(featurized_class_2_predict)
    probabilities_2 = log_reg.predict_proba(featurized_class_2_predict)

    # ---- EVALUATE -----
    total_correct_1 = 0.0
    for item in predictions_1:
        if item == 0:
            total_correct_1 += 1.0

    total_correct_2 = 0.0
    for item in predictions_2:
        if item == 1:
            total_correct_2 += 1.0
    
    print "Accuracy on class 1: ", total_correct_1 / len(predictions_1)
    print "Accuracy on class 2: ", total_correct_2 / len(predictions_2)
    
    # print "Predicted:",name,", Guess:",probability[0], target_names[0],",", probability[1], target_names[1]

if __name__ == "__main__":
    main()