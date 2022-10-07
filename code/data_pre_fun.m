function data = data_pre_fun(file,is_sorted)
if nargin == 1
    is_sorted = false;
end
% file = "../data/dataA/dataA1.csv";
f = fopen(file);
fgetl(f);
data_ori = textscan(f,'%d %s %d %f %f %s','delimiter',',');

num = size(data_ori{1},1);

data(:,1) = 1:num;    % id
data(:,2) = data_ori{3};    % num
data(:,3) = data_ori{4};    % length 
data(:,4) = data_ori{5};    % width
data(:,5) = data(:,3) .* data(:,4); % area
data(:,6) = ones(size(data,1),1); % 1表示正向
data(:,7) = data_ori{1};    % id
data(:,8) = str2num(char(replace(data_ori{6},'order',''))); % order
if is_sorted
    [~,index] = sort(data(:,3),'descend');
    data = data(index,:);
    data(:,1) = 1:num;
end

% change order of length and width，let length > width
% index = data(:,3) < data(:,4);
% tmp = data(index, 3);
% data(index, 3) = data(index, 4);
% data(index, 4) = tmp;
fclose(f);
end




