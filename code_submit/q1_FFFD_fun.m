function [bins, ratio, num_plates] = q1_FFFD_fun(data_ori, width, height)
if isempty(data_ori)
    bins = [];
    ratio = [];
    return
end

%% data pre
data2 = data_ori;
tmp = data2(:, 3);
data2(:, 3) = data2(:, 4);
data2(:, 4) = tmp;
data2(:, 6) = ~data2(:, 6);
data = [data_ori; data2];


[~, index] = sort(data(:, 3), 'descend');
data = data(index, :);

%%
bin.unused_height = height;
bin.width = width;
bin.strips = [];
bins = [];

while ~isempty(data)
    strip.height = 0;
    strip.unused_width = width;
    strip.stacks = [];
    data_flags = false(size(data, 1), 1);
    bin_used_area = 0;
    
    for k = 1:size(data, 1)
        if data_flags(k) == 1
            continue;
        end
        
        if isempty(strip.stacks) && data(k, 3) <= bin.unused_height && data(k, 4) <= strip.unused_width
            stack.width = data(k, 4);
            stack.unused_height = 0;
            stack.items = data(k, :);
            bin_used_area = bin_used_area + data(k,5);
            
            strip.height = data(k, 3);
            strip.unused_width = strip.unused_width - stack.width;
            strip.stacks = [strip.stacks, stack];
            % remove item(k)
            data_flags(data(:, 1) == data(k, 1)) = 1;
        elseif ~isempty(strip.stacks) && data(k, 4) <= strip.unused_width && data(k, 3) <= strip.height
            strip.unused_width = strip.unused_width - data(k, 4);
            stack.width = data(k, 4);
            stack.unused_height = strip.height - data(k, 3);
            stack.items = data(k, :);
            bin_used_area = bin_used_area + data(k,5);
            % remove item(k)
            data_flags(data(:, 1) == data(k, 1)) = 1;
            
            for kk = k + 1:size(data, 1)
                
                if data_flags(k) == 1
                    continue;
                end
                
                if data(kk, 4) == stack.width && data(kk, 3) <= stack.unused_height
                    stack.unused_height = strip.height - data(kk, 3);
                    stack.items = [stack.items; data(kk, :)];
                    bin_used_area = bin_used_area + data(k,5);
                    % remove item(k)
                    data_flags(data(:, 1) == data(kk, 1)) = 1;
                end
            end
            strip.stacks = [strip.stacks, stack];
        end
    end
    
    data(data_flags, :) = [];
    
    if isempty(strip.stacks)
        
        if isempty(bin.strips)
            warning("放不下");
            break
        end
        bins = [bins, bin];
        bin.unused_height = height;
        bin.width = width;
        bin.strips = [];
        bin.ratio = 0;
    else
        bin.strips = [bin.strips, strip];
        bin.unused_height = bin.unused_height - strip.height;
        bin.ratio = bin_used_area / height/width;
    end
end

bins = [bins, bin];
num_plates = size(bins, 2);
ratio = (sum(data_ori(:, 5)) - sum(data(:, 5)) / (consider_rotate + 1)) / width / height / num_plates;
end
