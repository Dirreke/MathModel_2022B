% function xs = q1_bins2xs_fun(bins)
bins = load("../data/solution.mat");
%% 
num = 0;
for k = 1:length(bins)
    for kk = 1:length(bins(k).strips)
        for kkk = 1: length(bins(k).strips(kk).stacks)
            bins(k).strips(kk).stacks(kkk).id = stacks
        end
    end
end























% end