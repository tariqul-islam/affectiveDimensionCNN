function [newFeatures] = getmRMRFeatures(trainDataX, trainDatay, K)
	features_matrix = trainDataX;
	features_matrix_cat = categorize_features_matrix(features_matrix);

	rating_array = trainDatay;
	rating_array_cat = categorize_rating_XX(rating_array);

	d = features_matrix_cat;
	f = rating_array_cat;
	nd = size(d,2);
	nc = size(d,1);

	addpath('mi');
	%t1=cputime;
	%for i=1:nd, 
   	%	t(i) = mutualinfo(d(:,i), f);
	%end; 
	rmpath('mi');
	%[tmp, idxs] = sort(-t);
	%K = 500; %Keep K Lower than 1000

	mRMRindex = mrmr_mid_d(d,f',K); %Gives mRMR Index (Power Feature Index)

	newFeatures = trainDataX(:,mRMRindex);
end