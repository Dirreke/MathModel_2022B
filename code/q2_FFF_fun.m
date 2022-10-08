function num_plates = q2_FFF_fun(data_ori,width,height,alpha)


% data_ori = data_pre_fun("../data/dataB/dataB1.csv");
% height = 1220;
% width = 2440;
% %     alpha = {[6,7]};
% alpha = false(3,length(unique(data_ori(:,8))));
% alpha(2:end,6) = 1;
% alpha(2:end,7) = 1;

%     if max(alpha) == 1 && size(alpha,2) ~= 1

num = size(alpha,1);
batches = cell(num,1);
num_plates = zeros(num,1);

if ~iscell(alpha)
    for k = 1:num
        tmp_index = find(alpha(k,:) == 1);
        batches(k) = {tmp_index};
    end
else 
    batches = alpha;
end

for k = 1:num
    
    num_plates(k) = 0;
    tmp_orders = batches{k};
    if isempty(tmp_orders)
        continue
    end
    tmp_items = [];
    for tmp_order = tmp_orders
        tmp_items = [tmp_items;data_ori(data_ori(:,8) == tmp_order,:)];
    end
    tmp_materials = unique(tmp_items(:,9))';
    for tmp_material = tmp_materials
        data_new = tmp_items(tmp_items(:,9) == tmp_material,:);
        tmp_bins = q1_FFF_fun(data_new,width,height);
        num_plates(k) = num_plates(k) + length(tmp_bins);
    end

end


end