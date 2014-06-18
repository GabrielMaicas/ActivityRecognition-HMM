function [left_sequences right_sequences]=find_sequences(data,cluster_index)
%Computes the sequence of observations once the we know each the cluster
%(codebook vector) each point belongs to

pos_ini=1;
for i=1:length(data.training_left)
    features=data.training_left{i};
    number=size(features,1);%Number of elements
    pos_end=pos_ini+number-1;
    states=cluster_index(pos_ini:pos_end);
    pos_ini=pos_end+1;       
    left_sequences{i}=states';
end;

for i=1:length(data.training_right)
    features=data.training_right{i};
    number=size(features,1);%Number of elements
    pos_end=pos_ini+number-1;
    states=cluster_index(pos_ini:pos_end);
    pos_ini=pos_end+1;       
    right_sequences{i}=states';
end;