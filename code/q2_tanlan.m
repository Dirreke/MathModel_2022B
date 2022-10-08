%% tanlan

file = ["../data/dataB/dataB1.csv","../data/dataB/dataB2.csv","../data/dataB/dataB3.csv","../data/dataB/dataB4.csv","../data/dataB/dataB5.csv"];
width = 1220;
height = 2440;
[data_ori, material_index] = data_pre_fun(file(2));
max_item_number = 1000;
max_item_area = 250e6;


%% 
is_merge = true;
iter_num = 0;
tic
while is_merge
    [material_data,material_data_order] = q2_materials_data_fun(data_ori,material_index,width,height);
    is_merge = false;
    for k = 1:size(material_data,1)
        if material_data(k,3) == 1
            continue
        end
        orders = material_data_order{k};
        for kk = 1:length(orders)
            % order_1 �Ĳ���k���Ű�����
            order_1 = orders(kk);
            index_1 = data_ori(:,8) == order_1;
            tmp_data_1 = data_ori(index_1,:);
            index_1_2 = tmp_data_1(:,9) == material_data(k,1);
            tmp_data_1_2 = tmp_data_1(index_1_2,:);
            
            tmp_num_1 = length(q1_FFF_fun(tmp_data_1_2,width,height));
            for kkk = kk+1:length(orders)
                % order_2 �Ĳ���k���Ű�����
                order_2 = orders(kkk);
                index_2 = data_ori(:,8) == order_2;
                tmp_data_2 = data_ori(index_2,:);
                % �ж�����������Ƿ�����Ҫ��
                if size(tmp_data_1,1) + size(tmp_data_2,1) > max_item_number  || sum(tmp_data_1(:,5)) + sum(tmp_data_2(:,5)) > max_item_area
                    continue
                end
                index_2_2 = tmp_data_2(:,9) == material_data(k,1);
                tmp_data_2_2 = tmp_data_2(index_2_2,:);
                tmp_num_2 = length(q1_FFF_fun(tmp_data_2_2,width,height));
                % order_1+2 �Ĳ���k���Ű�����
                tmp_data_12 = [tmp_data_1_2;tmp_data_2_2];
                tmp_num_12 = length(q1_FFF_fun(tmp_data_12,width,height));
                if tmp_num_12 < tmp_num_1 + tmp_num_2
                    data_ori(data_ori(:,8) == order_2,8) = order_1;
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
        fprintf("No.%d iter merge: %d & %d. time passed %.2f seconds \n",iter_num, order_1,order_2,toc );
    end
    
end
    
                
            
    
% num_bins_calculate = @(x_alpha,x_material)q2_FFF_fun(data_ori,width,height,x_alpha,x_material);
%     tmp_num_bins = material_data(k,4);
%     while ~isempty(orders)
%         for kk = 1:length(orders)   % ��order1 ���������plate�У���֤�����Ƿ���Է���ʣ��plate
%             tmp_used_num = num_bins_calculate({orders(kk)},material_data(k,1));
% 
%         end
%     end

    
    







% end
