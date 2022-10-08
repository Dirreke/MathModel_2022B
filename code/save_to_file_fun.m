function save_to_file_fun(bins,output_type)


% data_ori = data_pre_fun("../data/dataA/dataA1.csv");
% height = 2440;
% width = 1220;
% bins = q1_FFF_fun(data_ori,width,height);

%numtotal_item=length(data_ori);
i_total=1;
item_x(1) = 0;
item_y(1) = 0;
item_x_next=0;
item_y_next=0;

material = "YW10-0218S";
num_bin=length(bins);
for k=1:num_bin
    num_strip=length(bins(k).strips);
    for kk=1:num_strip
        num_stack=size(bins(k).strips(kk).stacks,2);
        mark_stack_item=0;
        for kkk=1:num_stack
            num_item=size(bins(k).strips(kk).stacks(kkk).items,1);
            for kkkk=1:num_item
                item_tag(i_total) = 1; %��Ʒ?
                item_x(i_total) = item_x_next;  % ��Ʒx����
                item_y(i_total) = item_y_next; % ��Ʒy����
                item_batch(i_total) = 1;   % �������
                item_bin(i_total)  = k;    % ԭƬ���
                item_ID(i_total) = bins(k).strips(kk).stacks(kkk).items(kkkk,7);  % ��ƷID
                item_material(:,1)  = material ;   % ԭƬ����
                item_x_length(i_total) = bins(k).strips(kk).stacks(kkk).items(kkkk,3) ;    % ��Ʒx���򳤶�
                item_y_length(i_total) = bins(k).strips(kk).stacks(kkk).items(kkkk,4) ;    % ��Ʒy���򳤶�
                item_x_next = item_x(i_total)+bins(k).strips(kk).stacks(kkk).items(kkkk,3);
                item_y_next = item_y(i_total);
                i_total=i_total+1;
                mark_stack_item=mark_stack_item+1;
            end
            item_tag(i_total) =0; %ʣ��?
            item_x(i_total) = item_x_next;  % ʣ����x����
            item_y(i_total) = item_y_next; % ʣ����y����
            item_batch(i_total) = 1;   % �������
            item_bin(i_total)  = k;    % ԭƬ���
            item_ID(i_total) = 0;  % ��ƷID
            item_x_length(i_total) = bins(k).strips(kk).stacks(kkk).unused_height ;    % ��Ʒx���򳤶�
            item_y_length(i_total) = item_y_length(i_total-1) ;    % ��Ʒy���򳤶�
            item_x_next=item_x(i_total-num_item);
            item_y_next=item_y(i_total-num_item)+bins(k).strips(kk).stacks(kkk).width;
            i_total=i_total+1;
            mark_stack_item=mark_stack_item+1;
        end
        item_tag(i_total) =0; %ʣ��??
        item_x(i_total) = item_x_next;  % ʣ����x����
        item_y(i_total) = item_y_next; % ʣ����y����
        item_batch(i_total) = 1;   % �������
        item_bin(i_total)  = k;    % ԭƬ���
        item_ID(i_total) = 0;  % ��ƷID
        item_x_length(i_total) = item_x_length(i_total-mark_stack_item) ;    % ��Ʒx���򳤶�
        item_y_length(i_total) = bins(k).strips(kk).unused_width ;    % ��Ʒy���򳤶�
        item_x_next=item_x(i_total-mark_stack_item)+bins(k).strips(kk).height;
        item_y_next=item_y(i_total-mark_stack_item);
        i_total=i_total+1;
    end
    item_tag(i_total) =0; %ʣ��??
    item_x(i_total) = item_x_next;  % ʣ����x����
    item_y(i_total) = item_y_next; % ʣ����y����
    item_batch(i_total) = 1;   % �������
    item_bin(i_total)  = k;    % ԭƬ���
    item_ID(i_total) = 0;  % ��ƷID
    item_x_length(i_total) = bins(k).unused_height;    % ��Ʒx���򳤶�
    item_y_length(i_total) = 1220;      %item_y_length(i_total-1)  % ��Ʒy���򳤶�
    item_x_next=item_x(i_total-mark_stack_item)+bins(k).strips(kk).height;
    item_y_next=item_y(i_total-mark_stack_item);
    i_total=i_total+1;
    item_x_next=0;
    item_y_next=0;
end
item_material(1:i_total-1,1)  = material;   % ԭƬ����
         

%% print
dataid = 1;
if output_type == 1
    type = 'A';
elseif output_type == 2
    type = 'B';
else
    error("1");
end


if ~isfolder('../result')
    mkdir('../result');
end
if ~isfolder("../result/figure_data"+type)
    mkdir("../result/figure_data"+type);
end
fileID = fopen("../result/figure_data"+type+'/figure_'+type+dataid+'.csv','w+','n','GB2312');
fprintf(fileID,'%s,%s,%s,%s,%s,%s,%s,%s,%s\n','�������','ԭƬ����','ԭƬ���','��Ʒid','��Ʒx����','��Ʒy����','��Ʒx���򳤶�','��Ʒy���򳤶�',"�Ƿ�Ϊ��Ʒ��");
for item_code=1:(i_total-1)
    fprintf(fileID,'%d,%s,%d,%d,%f,%f,%f,%f,%d\n',item_batch(item_code),'YW10-0218S',item_bin(item_code), item_ID(item_code),item_x(item_code),item_y(item_code),item_x_length(item_code),item_y_length(item_code),item_tag(item_code));
end
fclose(fileID);


index_delete = item_tag == 0;
if ~isfolder('../result')
    mkdir('../result');
end
if ~isfolder("../result/result"+type)
    mkdir("../result/result"+type);
end

if output_type == 1
    fileID = fopen("../result/result"+type+'/cut_program_'+type+dataid+'.csv','w+','n','GB2312');
    fprintf(fileID,'%s,%s,%s,%s,%s,%s,%s\n','ԭƬ����','ԭƬ���','��Ʒid','��Ʒx����','��Ʒy����','��Ʒx���򳤶�','��Ʒy���򳤶�');
    for item_code=1:(i_total-1)
        if index_delete(item_code) == 1
            continue;
        end
        fprintf(fileID,'%s,%d,%d,%f,%f,%f,%f\n',item_material(item_code),item_bin(item_code), item_ID(item_code),item_x(item_code),item_y(item_code),item_x_length(item_code),item_y_length(item_code));
    end
    fclose(fileID);
elseif output_type == 2
    fileID = fopen("../result/result"+type+'/sum_order_'+type+dataid+'.csv','w+','n','GB2312');
    fprintf(fileID,'%s,%s,%s,%s,%s,%s,%s,%s,%s\n','�������','ԭƬ����','ԭƬ���','��Ʒid','��Ʒx����','��Ʒy����','��Ʒx���򳤶�','��Ʒy���򳤶�',"�Ƿ�Ϊ��Ʒ��");
    for item_code=1:(i_total-1)
        if index_delete(item_code) == 1
            continue;
        end
        fprintf(fileID,'%d,%s,%d,%d,%f,%f,%f,%f,%d\n',item_batch(item_code),item_material(item_code),item_bin(item_code), item_ID(item_code),item_x(item_code),item_y(item_code),item_x_length(item_code),item_y_length(item_code),item_tag(item_code));
    end
    fclose(fileID);
else
    error("1");
end


