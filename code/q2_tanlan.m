%% tanlan

% material_num;
q2_materials_data;



batch.orders=[];
batch.items=[];
batch.materials=[];

num_bins_calculate = @(x_alpha,x_material)q2_FFF_fun(data_ori,width,height,x_alpha,x_material);

for k = 1:material_num
    if material_data(k,3) == 1
        continue
    end
    orders = material_data_order{k};
    tmp_num_bins = material_data(k,4);
    while ~isempty(orders)
        for kk = 1:length(orders)   % 将order1 单独存放在plate中，验证其他是否可以放如剩余plate
            tmp_used_num = num_bins_calculate({orders(kk)},material_data(k,1));

        end
    end

    
    







end
