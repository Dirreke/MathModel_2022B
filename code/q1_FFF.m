data = data_pre_fun("../data/dataA/dataA1.csv");
data(:,6) = 1;
data2 = data;
tmp = data2(:,3);
data2(:,3) = data2(:,4);
data2(:,4) = tmp;
data2(:,6) = -1;
data = [data;data2];
[~,index] = sort(data(:,3),'descend');
data = data(index,:);
data_clone = data;
data(:,7) = ones(size(data,1),1);

% height = 1220;
% width = 2440;

height = 2440;
width = 1220;

bin.unused_height = height;
bin.width = width;
bin.strips = [];
bins=[];
while ~isempty(data)
    
    strip.height = 0;
    strip.unused_width = width;
    strip.stacks = [];
    for k = 1:size(data,1)
        if data(k,7) == 0
            continue
        end
        if isempty(strip.stacks) &&  data(k,3) <= bin.unused_height
            stack.width = data(k,4);
            stack.unused_height = 0;
            stack.items = data(k,:);
            
            strip.height = data(k,3);
            strip.unused_width = strip.unused_width - stack.width;
            strip.stacks = [strip.stacks,stack];
            % remove item(k)
            data(data(:,1) == data(k,1),7) = 0;
        elseif ~isempty(strip.stacks) && data(k,4) <= strip.unused_width && data(k,3) <= strip.height
            strip.unused_width = strip.unused_width - data(k,4);
            stack.width = data(k,4);
            stack.unused_height = strip.height-data(k,3);
            stack.items = data(k,:);
            % remove item(k)
            data(data(:,1) == data(k,1),7) = 0;
            for kk = k+1:size(data,1)
                if data(kk,4) == stack.width && data(kk,3) <= stack.unused_height
                    stack.unused_height = strip.height-data(kk,3);
                    stack.items = [stack.items;data(kk,:)];
                    % remove item(k)
                    data(data(:,1) == data(kk,1),7) = 0;
                end
            end
            strip.stacks = [strip.stacks,stack];
        end
    end
    data(data(:,7)==0,:) = [];
    if isempty(strip.stacks)
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

248743608 / 1220/2440/size(bins,2)

%% check
num = 0;
for k = 1:length(bins)
    for kk = 1:length(bins(k).strips)
        for kkk = 1: length(bins(k).strips(kk).stacks)
            num = num + size(bins(k).strips(kk).stacks(kkk).items,1);
        end
    end
end














