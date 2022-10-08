function orders_BP_info = q3_FFF_fun(data_ori,width,height,orders,materials)


% data_ori = data_pre_fun("../data/dataB/dataB1.csv");
% height = 1220;
% width = 2440;
% orders = [458];


num = length(orders);
orders_BP_info = zeros(num,4);% materials num_plates ratio_all ratio_last
%% convert input type

if nargin == 5
    special_materials = 1;
else
    special_materials = 0;
end

%% into_iter

% orders_BP_info(k) = 0;

tmp_items = [];
for tmp_order = orders
    tmp_items = [tmp_items;data_ori(data_ori(:,8) == tmp_order,:)];
end
if special_materials
    tmp_materials = materials;
else
    tmp_materials = unique(tmp_items(:,9))';
end
for k = 1:length(tmp_materials)
    tmp_material = tmp_materials(k);
    data_new = tmp_items(tmp_items(:,9) == tmp_material,:);
    tmp_bins = q1_FFF_fun(data_new,width,height);
    orders_BP_info(k,1) = tmp_material;
    orders_BP_info(k,2) = length(tmp_bins);
    orders_BP_info(k,3) = sum(data_new(:,5))/width/height/orders_BP_info(k,2);
    S_last = 0;
    for kk = 1:length(tmp_bins(end).strips)
        for kkk = 1:length(tmp_bins(end).strips(kk).stacks)
            S_last =S_last + sum(tmp_bins(end).strips(kk).stacks(kkk).items(:,5));
        end
    end
   	orders_BP_info(k,4) = S_last /width/height;
    
    
end



end