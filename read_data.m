function data=read_data()
%%Reads training and test data returning them  in data

addpath Data/Train/;
addpath Data/Test/;

number_elements=100;%Number of observations per data sample

%Read training data PasilloDerecha
for i=1:9
    aux=load(sprintf('PasilloDerecha%d.txt',i-1));
    data.training_right{i}=adjust_data(aux,number_elements);
end;

%Read training data PasilloIzquuierda
for i=1:9
    aux=load(sprintf('PasilloIzquierda%d.txt',i-1));
    data.training_left{i}=adjust_data(aux,number_elements);
end;

%Read test data Paseante
for i=1:5
    aux=load(sprintf('Paseante%d.txt',i-1));
    data.test_paseante{i}=adjust_data(aux,number_elements);
end;

%Read test data PasilloDerecha
for i=1:4
    aux=load(sprintf('PasilloDerecha%d.txt',i+8));
    data.test_right{i}=adjust_data(aux,number_elements);
end;


%Read test data PasilloIzquierda
for i=1:4
    aux=load(sprintf('PasilloIzquierda%d.txt',i+8));
    data.test_left{i}=adjust_data(aux,number_elements);
end;

end

%%%Makes a data sample have number_elements observations
function data=adjust_data(data,number_elements)
    dividing=floor(size(data,1)/number_elements);
    if dividing>1
        data=data(1:dividing:end,:);
    end
    permu=randperm(size(data,1),number_elements);
    permu=sort(permu);
    data=data(permu,:);
end
