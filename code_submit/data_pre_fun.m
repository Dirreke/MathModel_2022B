function [data, material_index] = data_pre_fun(file)
f = fopen(file);
fgetl(f);
data_ori = textscan(f, '%d %s %d %f %f %s', 'delimiter', ',');

num = size(data_ori{1}, 1);

data(:, 1) = 1:num; % id
data(:, 2) = data_ori{3}; % num
data(:, 3) = data_ori{4}; % length
data(:, 4) = data_ori{5}; % width
data(:, 5) = data(:, 3) .* data(:, 4); % area
data(:, 6) = ones(size(data, 1), 1); % 1表示正向
data(:, 7) = data_ori{1}; % id
data(:, 8) = str2num(char(replace(data_ori{6}, 'order', ''))); % order
data(:, 9) = zeros(num, 1);

material = string(data_ori{2});
material_index = unique(material);

for k = 1:num
    [index, ~] = find(material_index(:, 1) == material{k});
    data(k, 9) = index;
end
fclose(f);
end
