function xs = q1_bins2xs_fun(bins)
% data_ori = data_pre_fun("../data/dataA/dataA1.csv");
% height = 2440;
% width = 1220;
% bins = q1_FFF_fun(data_ori,width,height);

%% get ID
num = 0;
for k = 1:length(bins)
    bin_id = Inf;
    for kk = 1:length(bins(k).strips)
        strip_id = Inf;
        for kkk = 1: length(bins(k).strips(kk).stacks)
            num = num + size(bins(k).strips(kk).stacks(kkk).items,1);
            stack_id = min(bins(k).strips(kk).stacks(kkk).items(:,1));
            bins(k).strips(kk).stacks(kkk).id = stack_id;
            if strip_id > stack_id 
                strip_id = stack_id;
            end
        end
        bins(k).strips(kk).id = strip_id;
        if bin_id > strip_id
            bin_id = strip_id;
        end
    end
    bins(k).id = bin_id;
end

%% build xs
alpha = zeros(num);
beta = zeros(num);
gamma = zeros(num);

for k = 1:length(bins)
    tmp_l = bins(k).id;
    for kk = 1:length(bins(k).strips)
        tmp_k = bins(k).strips(kk).id;
        gamma(tmp_l,tmp_k) = 1;
        for kkk = 1: length(bins(k).strips(kk).stacks)
            tmp_j = bins(k).strips(kk).stacks(kkk).id;
            beta(tmp_k,tmp_j) = 1;
            tmp_is = bins(k).strips(kk).stacks(kkk).items(:,1);
            alpha(tmp_j,tmp_is) = 1;
        end
    end
end

alpha = reshape(alpha',1,num^2);
beta = reshape(beta',1,num^2);
gamma = reshape(gamma',1,num^2);

xs.alpha = alpha;
xs.beta = beta;
xs.gamma = gamma;















% end