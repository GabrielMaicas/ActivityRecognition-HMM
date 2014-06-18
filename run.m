%%Main script to detect behaviour

codebook_vectors=5; %Number of observations
states=5; %number of hidden states

%Read data
data=read_data();
%load 'data.mat';%Comment this line and uncomment previous line to select other random data

%Discretize data
[cluster_index centroids]=find_codebook(data,codebook_vectors);

%once representatives found, compute sequence of observable states for
%trainign data
[left_sequences right_sequences]=find_sequences(data,cluster_index);

%Initialize matrix to train HMM for left door with equal probabilies
left_TRGUESS=zeros(states);
left_TRGUESS=left_TRGUESS+(1/states);%Initialize with equal weights
left_EMITGUESS=zeros(states,codebook_vectors);
left_EMITGUESS=left_EMITGUESS+(1/size(left_EMITGUESS,2));%Initialize with equal weights

%Train Left HMM
[left_ESTTR,left_ESTEMIT] = hmmtrain(left_sequences,left_TRGUESS,left_EMITGUESS,'Tolerance',1e-10);

%Initialize matrices to train HMM for right door
right_TRGUESS=zeros(states);
right_TRGUESS=right_TRGUESS+(1/states);%Initialize with equal weights
right_EMITGUESS=zeros(states,codebook_vectors);
right_EMITGUESS=right_EMITGUESS+(1/size(right_EMITGUESS,2));%Initialize with equal weights

%Train HMM for right door
[right_ESTTR,right_ESTEMIT] = hmmtrain(right_sequences,right_TRGUESS,right_EMITGUESS,'Tolerance',1e-10);

%Find sequence of obseervations for test data
[test_left test_paseante test_right]=recognize_sequences(data,centroids);

%For test data shows probability of sequence for left door HMM and right
%door HMM
for i=1:5
    [PSTATES,logpseq_left] = hmmdecode(test_paseante{i},left_ESTTR,left_ESTEMIT);
    [PSTATES_r,logpseq_right] = hmmdecode(test_paseante{i},right_ESTTR,right_ESTEMIT);
    disp(['Test paseante ', num2str(i), ': Left door: ', num2str(logpseq_left), 'Right door: ', num2str(logpseq_right)]);
end;

for i=1:4
    [PSTATES,logpseq_left] = hmmdecode(test_left{i},left_ESTTR,left_ESTEMIT);
    [PSTATES_r,logpseq_right] = hmmdecode(test_left{i},right_ESTTR,right_ESTEMIT);
    disp(['Test pasillo izquierda ', num2str(i), ': Left door: ', num2str(logpseq_left), 'Right door: ', num2str(logpseq_right)]);
end;

for i=1:4
    [PSTATES,logpseq_left] = hmmdecode(test_right{i},left_ESTTR,left_ESTEMIT);
    [PSTATES_r,logpseq_right] = hmmdecode(test_right{i},right_ESTTR,right_ESTEMIT);
    disp(['Test pasillo derecha ', num2str(i), ': Left door: ', num2str(logpseq_left), ' Right door: ', num2str(logpseq_right)]);
end;
