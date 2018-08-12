clc
clear all
close all
tic
sr =  44100; %Sampling Rate

for videoNum = [17 26 28 30 34 41 45 46 62 65];%[23 39 42 43 56 64] %[16 17 19 21 23 25 26 28 30 34 37 39 41 42 43 45 46 48 56 58 62 64 65]

outputLoc = ['MFCC_Features/P' num2str(videoNum)];
mkdir(outputLoc);

fid = fopen(strcat('List_',num2str(videoNum),'_Audio.txt')); %Reading Frame List File
tline = fgetl(fid);
while ischar(tline)
        C = strsplit(tline,' ');
        audioLoc = strjoin(C(1));
        aud = load(audioLoc);
        d = aud.samples;
        [mfcc,aspc] = melfcc(d*3.3752, sr, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', ...
            'dcttype', 1, 'usecmp', 1, 'wintime', 0.06, 'hoptime', 0.06, 'preemph', 0, 'dither', 1);
        
        C = strsplit(audioLoc,'/');
        C = strrep(strrep(strjoin(C(3)),'Audio',''),'.mat','');        
        featureFilename = [outputLoc '/MFCCFeatureAudio' C '.mat'];
        save(featureFilename,'mfcc');
        tline = fgetl(fid);
end
fclose(fid);
toc
end