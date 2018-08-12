# Instantaneous Estimation of Affetctive Dimensions Using Selected CNN Features


For CNN Training and Testing:
The prototxt file contains the architecture and setting parameters for training.
Training is run by using startTrain.sh
For prediction and output generation 'z_PredictionAudio.ipynb' is used.

For Extracting Features:
LBPTOP_main.m
MFCC_main.m
GaborEnergy_main.m

LBPTOP_main.m:
Features are extracted from a list of images [28x28], a list needs to be created containing names of all image files. From the list the feature data is stored as mat files in LBPTOP_Features/PXX folder and a file containing list of the mat filenames is also generated.

MFCC_main.m
This also takes a text file containing all audio input segmensts from tha audio text file containing names of all audio files, and stores the extracted features as mat files and stores them in FCC_Features/PXX folder and a file containing list of the mat filenames is also generated. 

GaborEnergy_main.m
This is same as LBPTOP_main.m Output features are stored in GaborEnergy_Features/PXX folder and a file containing list of the mat filenames is also generated.

Training testing SVR
We separate the data as training and testing data.

Mutual Information is extracted from training data using 'test_Index_Extract_v.m' for video features and 'test_Index_Extract.m' for audio features. Obtained indexes are saved as 'mRMRindexVideo.mat' and 'mRMRindex.mat'

xa_trainTestSVR_AV_main.m
SVR Training and Testing is done using this file by concatenating different features and output values MSE,CC, CCC etc are calculated.
