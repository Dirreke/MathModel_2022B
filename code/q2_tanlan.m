function [batches,ratio,num_plates] = q2_tanlan(data_ori,width,height,max_item_number,max_item_area)
%% tanlan
% file = "../data/dataB/dataB1.csv";
% width = 1220;
% height = 2440;
% data_ori = data_pre_fun(file);
% max_item_number = 1000;
% max_item_area = 250e6;
data = data_ori;

%%
is_merge = true;
iter_num = 0;
tic

while is_merge
    [material_data, material_data_order] = q2_materials_data_fun(data, width, height);
    is_merge = false;
    
    for k = 1:size(material_data, 1)
        if material_data(k, 3) == 1
            continue
        end
        
        orders = material_data_order{k};
        
        for kk = 1:length(orders)
            % order_1 的材质k的排版数量
            order_1 = orders(kk);
            index_1 = data(:, 8) == order_1;
            tmp_data_1 = data(index_1, :);
            index_1_2 = tmp_data_1(:, 9) == material_data(k, 1);
            tmp_data_1_2 = tmp_data_1(index_1_2, :);  
            tmp_num_1 = length(q1_FFF_fun(tmp_data_1_2, width, height));

            for kkk = kk + 1:length(orders)
                % order_2 的材质k的排版数量
                order_2 = orders(kkk);
                index_2 = data(:, 8) == order_2;
                tmp_data_2 = data(index_2, :);
                % 判断数量和面积是否满足要求
                if size(tmp_data_1, 1) + size(tmp_data_2, 1) > max_item_number || sum(tmp_data_1(:, 5)) + sum(tmp_data_2(:, 5)) > max_item_area
                    continue
                end
                index_2_2 = tmp_data_2(:, 9) == material_data(k, 1);
                tmp_data_2_2 = tmp_data_2(index_2_2, :);
                tmp_num_2 = length(q1_FFF_fun(tmp_data_2_2, width, height));
                % order_1+2 的材质k的排版数量
                tmp_data_12 = [tmp_data_1_2; tmp_data_2_2];
                tmp_num_12 = length(q1_FFF_fun(tmp_data_12, width, height));
                
                if tmp_num_12 < tmp_num_1 + tmp_num_2
                    data(data(:, 8) == order_2, 8) = order_1;
                    is_merge = true;
                    break
                end
            end
            if is_merge
                break
            end
        end
        if is_merge
            break
        end
    end
    
    iter_num = iter_num + 1;
    if is_merge
        fprintf("No.%d iter merge: %d & %d. time passed %.2f seconds \n", iter_num, order_1, order_2, toc);
    end
end


%% 整理结果
orders_unique = unique(data(:, 8));

batch.id = [];
batch.material_packs = [];
batch.orders_id = [];
batch.ratio = [];
batches = repmat(batch,1,size(orders_unique, 1)); %批次序号，该批次所含的所有订单实际id，材质包
num_plates = 0;
for k = 1:size(orders_unique, 1)
    [material_packs,material_packs_ratio,material_packs_num_plates] = q2_FFF_fun(data, width, height, orders_unique(k));
    
    orders_now_id = orders_unique(k); %此批次对应的订单锁号
    orders_id = unique(data_ori(data(:, 8) == orders_now_id,8))'; %此批次包含的实际订单们
    
    batch.id = k;
    batch.material_packs = material_packs;
    batch.ratio = material_packs_ratio;
    batch.orders_id = orders_id;%该批次所含的所有订单实际id
    batches(k) = batch;
    num_plates = num_plates + material_packs_num_plates;
    
end

ratio = sum(data_ori(:,5))/width/height/num_plates;

end
