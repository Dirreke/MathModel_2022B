% file = [
%     "../data/dataB/dataB1.csv", 
%     "../data/dataB/dataB2.csv", 
%     "../data/dataB/dataB3.csv", 
%     "../data/dataB/dataB4.csv", 
%     "../data/dataB/dataB5.csv"
%     ];
% 
% 
% for k = 1:5
%     [data_ori, material_index] = data_pre_fun(file(k));
%     save_to_file_fun(2, k,results{k}, material_index);
% end
%%

 for k = 1:4
  draw_picture_fun(1, k);
 end
