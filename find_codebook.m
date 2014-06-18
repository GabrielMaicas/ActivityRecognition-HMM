function [cluster_index centroids]=find_codebook(data,k)
%%From a set of data samples, computes its k cluster centroids that will be
%%the representatives

feature=[];

%Make matrix with all data
for i=1:length(data.training_left);
    feature=[feature;data.training_left{i}];
end;

%Make matrix with all data
for i=1:length(data.training_right)
    feature=[feature;data.training_right{i}];
end;

[cluster_index centroids] = kmeans(feature,k);


