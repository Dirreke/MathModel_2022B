%% tanlan

% material_num;
q2_materials_data;

batch.orders=[];
batch.items=[];
batch.materials=[];

for k = 1:material_num
    if material_data(k,3) == 1
        continue
    end
    orders = material_data_order{k};
    tmp_num_bins = material_data(k,4);
    for kk = 1:length(orders)
        orders(kk)
    
    







end
