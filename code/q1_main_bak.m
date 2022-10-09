data = data_pre_fun("../data/dataA/dataA1.csv");

cell_stack = []; % height
cell_stack2 = []; % jihe
width_list = []; % width
num = 0;
% 横向长度
for k = 1:length(data)
    stack = [];
    stack2 = {0};
    num = 3;
    
    % 正宽度
    if isempty(width_list) || sum(find(width_list == data(k, 3))) == 0
        width = data(k, 3);
        stack(1) = data(k, 3);
        stack(2) = data(k, 4);
        stack2(2) = {k};
        % 正着装，
        index = find(data(:, 3) == width); % 可以拼stack的
        
        if length(index) ~= 1
            
            for kk = 1:length(index)
                
                if index(kk) ~= k
                    len = data(index(kk), 4);
                    stack(num) = len;
                    stack2(num) = {index(kk)};
                    num = num + 1;
                    
                    for kkk = 2:length(stack) - 1
                        stack(num) = stack(kkk) + len;
                        stack2(num) = {[stack2{kkk}, index(kk)]};
                        num = num + 1;
                    end
                    
                end
                
            end
            
        end
        
        % 竖着装，
        index = find(data(:, 4) == width); % 可以拼stack的
        
        if length(index) ~= 1
            
            for kk = 1:length(index)
                
                if index(kk) ~= k && data(index(kk), 3) ~= data(index(kk), 3) %不是正方形，正方形已经拼过
                    len = data(index(kk), 3);
                    stack(num) = len;
                    stack2(num) = {-index(kk)};
                    num = num + 1;
                    
                    for kkk = 2:length(stack) - 1
                        stack(num) = stack(kkk) + len;
                        stack2(num) = {[stack2{kkk}, -index(kk)]};
                        num = num + 1;
                    end
                    
                end
                
            end
            
        end
        
        width_list = [width_list; width];
        cell_stack = [cell_stack; {stack}];
        cell_stack2 = [cell_stack2; {stack2}];
        
    end
    
    % 竖宽度
    stack = [];
    stack2 = {0};
    num = 3;
    
    if isempty(width_list) || sum(find(width_list == data(k, 4))) == 0
        width = data(k, 4);
        stack(1) = data(k, 4);
        stack(2) = data(k, 3);
        stack2(2) = {k};
        % 正着装，
        index = find(data(:, 3) == width); % 可以拼stack的
        
        if length(index) ~= 1
            
            for kk = 1:length(index)
                
                if index(kk) ~= k
                    len = data(index(kk), 4);
                    stack(num) = len;
                    stack2(num) = {index(kk)};
                    num = num + 1;
                    
                    for kkk = 2:length(stack) - 1
                        stack(num) = stack(kkk) + len;
                        stack2(num) = {[stack2{kkk}, index(kk)]};
                        num = num + 1;
                    end
                    
                end
                
            end
            
        end
        
        % 竖着装，
        index = find(data(:, 4) == width); % 可以拼stack的
        
        if length(index) ~= 1
            
            for kk = 1:length(index)
                
                if index(kk) ~= k && data(index(kk), 3) ~= data(index(kk), 3) %不是正方形，正方形已经拼过
                    len = data(index(kk), 3);
                    stack(num) = len;
                    stack2(num) = {-index(kk)};
                    num = num + 1;
                    
                    for kkk = 2:length(stack) - 1
                        stack(num) = stack(kkk) + len;
                        stack2(num) = {[stack2{kkk}, -index(kk)]};
                        num = num + 1;
                    end
                    
                end
                
            end
            
        end
        
        width_list = [width_list; width];
        cell_stack = [cell_stack; {stack}];
        cell_stack2 = [cell_stack2; {stack2}];
        
    end
    
end
