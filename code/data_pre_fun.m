function data = data_pre_fun(file)
% file = "../data/dataA/dataA1.csv";
f = fopen(file);
fgetl(f);
data_ori = textscan(f,'%d %s %d %f %f %s','delimiter',',');
% data(:,1) = str2num(char(replace(data_ori{6},'order',''))); % order
data(:,1) = data_ori{1};    % id
data(:,2) = data_ori{3};    % num
data(:,3) = data_ori{4};    % length 
data(:,4) = data_ori{5};    % width
data(:,5) = data(:,3) .* data(:,4); % area

% change order of length and width£¬let length > width
index = data(:,3) < data(:,4);
tmp = data(index, 3);
data(index, 3) = data(index, 4);
data(index, 4) = tmp;
fclose(f);
end




