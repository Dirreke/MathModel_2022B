data_ori = data_pre_fun("../data/dataA/dataA1.csv");
height = 2440;
width = 1220;
bins = q1_FFF_fun(data_ori,width,height);

%numtotal_item=length(data_ori);
i_total=1;
item_x(1) = 0;  
item_y(1) = 0;
item_x_next=0;
item_y_next=0;


num_bin=size(bins,2);
  for j=1:1:num_bin
    num_strip=size(bins(j).strips,2);
     for k=1:1:num_strip
        num_stack=size(bins(j).strips(k).stacks,2);
        mark_stack_item=0;
        for l=1:1:num_stack
            num_item=size(bins(j).strips(k).stacks(l).items,1);
            for h=1:1:num_item
              item_tag(i_total) =1; %产品项
              item_x(i_total) = item_x_next;  % 产品x坐标
              item_y(i_total) = item_y_next; % 产品y坐标
              item_batch(i_total) = 1;   % 批次序号
              item_bin(i_total)  = j;    % 原片序号 
              item_ID(i_total) = bins(j).strips(k).stacks(l).items(h,8);  % 产品ID
              item_material(:,1)  = 'YW10-0218S' ;   % 原片材质
              item_x_length(i_total) = bins(j).strips(k).stacks(l).items(h,3) ;    % 产品x方向长度
              item_y_length(i_total) = bins(j).strips(k).stacks(l).items(h,4) ;    % 产品y方向长度
              item_x_next = item_x(i_total)+bins(j).strips(k).stacks(l).items(h,3);
              item_y_next = item_y(i_total); 
              i_total=i_total+1;
              mark_stack_item=mark_stack_item+1;
            end
            item_tag(i_total) =0; %剩余项
            item_x(i_total) = item_x_next;  % 剩余项x坐标
            item_y(i_total) = item_y_next; % 剩余项y坐标
            item_batch(i_total) = 1;   % 批次序号
            item_bin(i_total)  = j;    % 原片序号 
            item_ID(i_total) = 0;  % 产品ID
            item_material(:,1)  = 'YW10-0218S';   % 原片材质
            item_x_length(i_total) = bins(j).strips(k).stacks(l).unused_height ;    % 产品x方向长度
            item_y_length(i_total) = item_y_length(i_total-1) ;    % 产品y方向长度 
            item_x_next=item_x(i_total-num_item);
            item_y_next=item_y(i_total-num_item)+bins(j).strips(k).stacks(l).width;
            i_total=i_total+1;
            mark_stack_item=mark_stack_item+1;
        end
         item_tag(i_total) =0; %剩余项
         item_x(i_total) = item_x_next;  % 剩余项x坐标
         item_y(i_total) = item_y_next; % 剩余项y坐标
         item_batch(i_total) = 1;   % 批次序号
         item_bin(i_total)  = j;    % 原片序号 
         item_ID(i_total) = 0;  % 产品ID
         item_material(:,1)  = 'YW10-0218S';   % 原片材质
         item_x_length(i_total) = item_x_length(i_total-mark_stack_item) ;    % 产品x方向长度
         item_y_length(i_total) = bins(j).strips(k).unused_width ;    % 产品y方向长度 
         item_x_next=item_x(i_total-mark_stack_item)+bins(j).strips(k).height;
         item_y_next=item_y(i_total-mark_stack_item);
         i_total=i_total+1;
     end
         item_tag(i_total) =0; %剩余项
         item_x(i_total) = item_x_next;  % 剩余项x坐标
         item_y(i_total) = item_y_next; % 剩余项y坐标
         item_batch(i_total) = 1;   % 批次序号
         item_bin(i_total)  = j;    % 原片序号 
         item_ID(i_total) = 0;  % 产品ID
         item_material(:,1)  = 'YW10-0218S';   % 原片材质
         item_x_length(i_total) = bins(j).unused_height;    % 产品x方向长度
         item_y_length(i_total) = 1220;      %item_y_length(i_total-1)  % 产品y方向长度 
         item_x_next=item_x(i_total-mark_stack_item)+bins(j).strips(k).height;
         item_y_next=item_y(i_total-mark_stack_item);
         i_total=i_total+1;
     item_x_next=0;
     item_y_next=0;
  end


fileID = fopen('../data/resultA/Output2.csv','w+','n','GB2312');
fprintf(fileID,'%s,%s,%s,%s,%s,%s,%s,%s,%s\n','批次序号','原片材质','原片序号','产品ID','产品x坐标','产品y坐标','产品x方向长度','产品y方向长度',"是否为产品项");
for item_code=1:1:(i_total-1)
    fprintf(fileID,'%d,%s,%d,%d,%f,%f,%f,%f,%d\n',item_batch(item_code),'YW10-0218S',item_bin(item_code), item_ID(item_code),item_x(item_code),item_y(item_code),item_x_length(item_code),item_y_length(item_code),item_tag(item_code));
end
fclose(fileID);


