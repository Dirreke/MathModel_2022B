function [bins,rate] = q1_FFF_fun(data_ori,width,height,consider_rotate,create_random)
if nargin < 4
    consider_rotate = 1;
end
if nargin < 5
    create_random = 0;
end
% data_ori = data_pre_fun("../data/dataA/dataA1.csv");
% % height = 1220;
% % width = 2440;
% 
% height = 2440;
% width = 1220;
if isempty(data_ori)
    bins = [];
    rate = [];
    return
end
%% data pre
if consider_rotate
    data2 = data_ori;
    tmp = data2(:,3);
    data2(:,3) = data2(:,4);
    data2(:,4) = tmp;
    data2(:,6) = ~data2(:,6);
else
    data2 = [];
end
data = [data_ori;data2];
if ~create_random
    [~,index] = sort(data(:,3),'descend');
else
    index = randperm(size(data,1));
end
data = data(index,:);
% data_clone = data;
% data_flags = ones(size(data,1),1);

%% 
bin.unused_height = height;
bin.width = width;
bin.strips = [];
bins=[];
while ~isempty(data)
    
    strip.height = 0;
    strip.unused_width = width;
    strip.stacks = [];
    data_flags = false(size(data,1),1);
    for k = 1:size(data,1)
        if data_flags(k) == 1
            continue;
        end
        if isempty(strip.stacks) &&  data(k,3) <= bin.unused_height
            stack.width = data(k,4);
            stack.unused_height = 0;
            stack.items = data(k,:);
            
            strip.height = data(k,3);
            strip.unused_width = strip.unused_width - stack.width;
            strip.stacks = [strip.stacks,stack];
            % remove item(k)
            data_flags(data(:,1) == data(k,1)) = 1;
        elseif ~isempty(strip.stacks) && data(k,4) <= strip.unused_width && data(k,3) <= strip.height
            strip.unused_width = strip.unused_width - data(k,4);
            stack.width = data(k,4);
            stack.unused_height = strip.height-data(k,3);
            stack.items = data(k,:);
            % remove item(k)
            data_flags(data(:,1) == data(k,1)) = 1;
            for kk = k+1:size(data,1)
                if data_flags(k) == 1
                    continue;
                end
                if data(kk,4) == stack.width && data(kk,3) <= stack.unused_height
                    stack.unused_height = strip.height-data(kk,3);
                    stack.items = [stack.items;data(kk,:)];
                    % remove item(k)
                    data_flags(data(:,1) == data(kk,1)) = 1;
                end
            end
            strip.stacks = [strip.stacks,stack];
        end
    end
    data(data_flags,:) = [];
    if isempty(strip.stacks)
        if isempty(bin.strips)
            warning("·Å²»ÏÂ");
            break
        end
        bins = [bins,bin];
        bin.unused_height = height;
        bin.width = width;
        bin.strips = [];
    else
        bin.strips = [bin.strips,strip];
        bin.unused_height = bin.unused_height - strip.height;
    end
end
bins = [bins,bin];

rate = (sum(data_ori(:,5))- sum(data(:,5))/(consider_rotate+1))/ width/height/size(bins,2);
% fprintf("FFF rate %.2f \n",rate*100);


%% check
% num = 0;
% for k = 1:length(bins)
%     for kk = 1:length(bins(k).strips)
%         for kkk = 1: length(bins(k).strips(kk).stacks)
%             num = num + size(bins(k).strips(kk).stacks(kkk).items,1);
%         end
%     end
% end
% 
% num


end













