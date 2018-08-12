tic
addpath('svr_lbptop_support_files');

disp('Preparing Train Data')
fTrainAV = fopen('za_AudioVideo_Train.txt','r');

c = 0;
tlineAV = fgetl(fTrainAV);

%Getting Train Features
while ischar(tlineAV)
	c = c + 1;
    fileInfoAV = strsplit(['D:/Thesis/RECOLA_Rbf_Arousal/ArousalFeaturesRecola/' tlineAV]);
    matfilenameAV = strjoin(fileInfoAV(1));
    ratingAV = str2double(fileInfoAV(2)) ;
    
    fAV = load(matfilenameAV);
    prdAV = fAV.predicted_value;
    featureAV = fAV.feature_array;
    actAV = ratingAV; 
    trainDataX(c,:) = featureAV;
    trainDatay(c) = actAV;
    
    tlineAV = fgetl(fTrainAV);
end
fclose(fTrainAV);


disp('Preparing Model')
size(trainDataX)
size(trainDatay')
%Obtaining the model
load 'mRMRindex.mat'
trainDataX = trainDataX(:,mRMRindex);

model = giveSVRmodel(double(trainDataX), double(trainDatay'));

disp('Preparing Test Data')
fTestAV = fopen('zb_AudioVideo_Test.txt'); %fTestV = fopen('FinalVideoTest.txt');

c = 0;
tlineAV = fgetl(fTestAV); %tlineV = fgetl(fTestV);

%Getting Test Features
while ischar(tlineAV)
	c = c + 1;
    fileInfoAV = strsplit(['D:/Thesis/RECOLA_Rbf_Arousal/ArousalFeaturesRecola/' tlineAV]);
    matfilenameAV = strjoin(fileInfoAV(1));
    ratingAV = str2double(fileInfoAV(2));
    
    fAV = load(matfilenameAV);
    prdAV = fAV.predicted_value;
    featureAV = fAV.feature_array;
    actAV = ratingAV; % fAV.actual_value;
    
%     featureAV = [featureAV, featureV];
    testDataX(c,:) = featureAV;
    testDatay(c) = actAV; %or actA same 
    
    tlineAV = fgetl(fTestAV); %tlineV = fgetl(fTestV);
end
fclose(fTestAV); %fclose(fTestV);



disp('Predicting...')
testDataX = testDataX(:,mRMRindex);
testData.X = double(testDataX);    testData.y = double(testDatay');

[testData, junk1, junk2] = scaleSVM(testData, testData, testData, 0, 1); %Normalizing

[valence_predicted, accuracy, prob_estimates] = svmpredict(testData.y, testData.X, model);
toc
    %total_predicted = cat(1,total_predicted,valence_predicted);
    %actual_value = cat(1,actual_value,testData.y);

smooth_degree = 0.05;
valence_predicted = smooth(valence_predicted,smooth_degree,'rloess');

actual = testData.y;
predictedAV = valence_predicted;

q_AV = corrcoef(actual,predictedAV);
q_AV = q_AV(1,2);
m = mean(actual);
m_AV = mean(predictedAV);
v = var(actual);
v_AV = var(predictedAV);

ccc_AV = 2 * q_AV * v * v_AV / ( v^2 + v_AV ^ 2 + ( m - m_AV ) ^ 2 );

q = q_AV
ccc = ccc_AV
    
mse = mean((actual-predictedAV).^2)

plot(valence_predicted)
hold on
plot(testData.y,'r')

predicted = predictedAV;

rmpath('svr_lbptop_support_files');

