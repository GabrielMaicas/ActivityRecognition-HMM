function [test_left test_paseante test_right]=recognize_sequences(data,centroids)
%%%Computes sequence of observable states for test data given centroids

for i=1:length(data.test_left)%for every data seq
    s=data.test_left{i};
    sequence=zeros(1,size(s,1));
    for j=1:size(s,1)%for every data point
        point=s(j,:);
        sequence(j)=find_best_centroid(point,centroids);
        
    end;
    test_left{i}=sequence;
end;

for i=1:length(data.test_right)%for every data seq
    s=data.test_right{i};
    sequence=zeros(1,size(s,1));
    for j=1:size(s,1)%for every data point
        point=s(j,:);
        sequence=find_best_centroid(point,centroids);
    end;
    test_right{i}=sequence;
end;

for i=1:length(data.test_paseante)%for every data seq
    s=data.test_paseante{i};
    sequence=zeros(1,size(s,1));
    for j=1:size(s,1)%for every data point
        point=s(j,:);
        sequence(j)=find_best_centroid(point,centroids);
    end;
    test_paseante{i}=sequence;
    
end;


end

%Computes which centroid is closest to a point
function pos=find_best_centroid(point,centroids)

    dist=repmat(point,[size(centroids,1),1])-centroids;
    dist=sum((dist.^2),2);
    [mini pos]=min(dist);
    
end

