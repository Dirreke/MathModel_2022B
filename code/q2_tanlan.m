function batches = q2_tanlan(data_file_path)
%% tanlan
    % file = ["../data/dataB/dataB1.csv","../data/dataB/dataB2.csv","../data/dataB/dataB3.csv","../data/dataB/dataB4.csv","../data/dataB/dataB5.csv"];
    width = 1220;
    height = 2440;
    data_ori = data_pre_fun(data_file_path);
    max_item_number = 1000;
    max_item_area = 250e6;
    data = data_ori;

    %% 
    is_merge = true;
    iter_num = 0;
    tic
    while is_merge
        [material_data,material_data_order] = q2_materials_data_fun(data_ori,width,height);
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

    orders_unique = unique(data_ori(:, 8));
    orders_BP_infos = cell(size(orders_unique,1),1);
    batches_BP_infos = zeros(size(orders_unique,1),2);
    orders_bins = cell(size(orders_unique,1),2);  %�����ţ�material_packs
    for k = 1:size(orders_unique,1)
        %[orders_BP_infos{k}, num, ratio] = q3_FFF_fun(data_ori,width,height,orders_unique(k));
        [orders_BP_infos{k}, order_bins] = q3_FFF_fun(data_ori,width,height,orders_unique(k));
        for kk = 1:length(orders_bins.material_packs)
            orders_bins.material_packs{kk}.material = material_index(orders_bins.material_packs{kk}.material_id);
        end
        orders_bins{k,1} = orders_unique(k);
        orders_bins{k,2} = order_bins;
        batches_BP_infos{k}(:,4) = [];       % materials num_plates ratio_all
    end

    %�����ݼ������������ε���Ϣ
    batches = cell(length(batches_BP_infos), 3);  %������ţ����������������ж���ʵ��id�����ʰ�
    for k = 1:size(orders_unique,1)  %����ÿһ����������
        batches{k,1} = k;  %�������
       
        order_now_id = orders_unique(k);  %�����ζ�Ӧ�Ķ�������
        order_total_num = sum(data_ori(:,8)==order_now_id);     %�����ΰ�����ʵ�ʶ�����
        order_in_data_row = data(data_ori(:,8)==order_now_id);  %�����ΰ�����ʵ�ʶ�����
        order_id_real = [];
        for kk = 1:order_total_num  
            order_id_real = [order_id_real,data(order_in_data_row(kk),8)];    %�˶����ı��涩����
        end
        batches{k,2} = order_id_real;  %���������������ж���ʵ��id
        
        batches{k,3} = orders_bins{k,2}; %���ʰ�
     
    end

    % num_bins_calculate = @(x_alpha,x_material)q2_FFF_fun(data_ori,width,height,x_alpha,x_material);
    %     tmp_num_bins = material_data(k,4);
    %     while ~isempty(orders)
    %         for kk = 1:length(orders)   % ��order1 ���������plate�У���֤�����Ƿ���Է���ʣ��plate
    %             tmp_used_num = num_bins_calculate({orders(kk)},material_data(k,1));
    % 
    %         end
    %     end


end
