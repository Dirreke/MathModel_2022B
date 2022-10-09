function draw_picture_fun(data_type, files_id)
%draw_picture_fun draw csv file to png file
%
%   Inputs (all are optional):
%       DATA_TYPE : 1 for question 1
%                   2 for question 2
%       FILE_ID : the File ID

%%
%   data_type = 1;
%   files_id = 1;
 color_map = parula(256);
if data_type == 1
    content = "../result/figuresA/";
    input_file = "../result/figure_dataA/figure_A" + files_id + ".csv";
elseif data_type == 2
    content = "../result/figuresB/";
    input_file = "../result/figure_dataB/figure_B" + files_id + ".csv";
end

file_info = dir(input_file);
tmp = strfind(file_info.name, '.');

if ~isempty(tmp)
    tmp = tmp(end);
    file_name = file_info.name(1:tmp - 1);
else
    file_name = file_info.name;
end

content = content + '/' + file_name + '/';

if ~isfolder(content)
    mkdir(content);
end



f = fopen(input_file);
fgetl(f);
data_ori = textscan(f, '%s %s %s %s %f %f %f %f %d', 'delimiter', ',');
fclose(f);
number(:, 1) = string(data_ori{1}); % 批次序号
number(:, 2) = string(data_ori{3}); % 原片序号
number(:, 3) = string(data_ori{4}); % 产品ID
material(:, 1) = data_ori{2}; % 原片材质
data(:, 1) = data_ori{5}; % 产品y坐标
data(:, 2) = data_ori{6}; % 产品x坐标
data(:, 3) = data_ori{7}; % 产品y方向长度
data(:, 4) = data_ori{8}; % 产品x方向长度
mark(:, 1) = data_ori{9}; % 是否为产品项标志??

numtotal_item = length(number(:, 3));

i = 1;

while i <= numtotal_item %产品总个??
    picture = 'Batch' + number(i, 1) + '-' + material(i, 1) + '-' + 'Board' + number(i, 2);
    figure('NumberTitle', 'off', 'Name', picture);
    
    hold on;
    str="PRODUCT DATA";
    text_mark=2;
    
    
    if mark(i, 1) == 1
        %cmap = turbo(256);
        % rand_color_F = randperm(255);
        %rectangle('Position', [data(i, 2), data(i, 1), data(i, 4), data(i, 3)], 'LineWidth', 0.5, 'FaceColor', cmap(rand_color_f, :));
        
        rand_color_F = randperm(256);
        rand_color_f = rand_color_F(1, 1);
        rectangle('Position', [data(i, 2), data(i, 1), data(i, 4), data(i, 3)], 'LineWidth', 0.5, 'FaceColor', color_map(rand_color_f, :));
       % plot(data(i, 2), data(i, 1), 'K-o', 'MarkerFaceColor', 'K', 'MarkerSize', 3);
       % text(data(i, 2) + 30, data(i, 1) + 50, 'Item' + number(i, 3) + '(' + num2str(data(i, 2)) + ',' + num2str(data(i, 1)) + ')' + num2str(data(i, 4)) + '*' + num2str(data(i, 3)), 'fontsize', 6, 'FontName', 'Times New Roman', 'FontAngle', 'italic');
        text((data(i, 2)+data(i, 4)/2-40), (data(i, 1)+data(i, 3)/2-5), 1, number(i, 3),'fontsize', 9, 'FontName', 'Times New Roman');
        str(text_mark,1) =  ""+number(i, 3) + ':Position(' + num2str(data(i, 2)) + ',' + num2str(data(i, 1)) + ')' +':Size'+ num2str(data(i, 4)) + 'mm*' + num2str(data(i, 3))+ 'mm';
        text_mark=text_mark+1; 
    else
        rectangle('Position', [data(i, 2), data(i, 1), data(i, 4), data(i, 3)], 'LineWidth', 0.2, 'EdgeColor', 'k', 'LineStyle', ':','FaceColor',[0.87 0.87 0.87]);
    end
    

    i = i + 1;
    axis([0 1220 0 2440]);
    set(gca, 'XTick', 0:0:0);
    set(gca, 'YTick', 0:0:0);
    set(gca, 'fontsize', 12, 'FontName', 'Times New Roman');
    set(gca, 'position', [0.05 0.1 0.5 0.81]);
    set(gcf, 'position', [0.75 1.5 630 600]);
    xlabel('1220mm', 'fontsize', 9, 'FontName', 'Times New Roman');
    ylabel('2440mm', 'fontsize', 9, 'FontName', 'Times New Roman');
    title(picture);
   
    while i <= numtotal_item %产品总个??
        
        if strcmpi(number(i- 1, 2), number(i, 2))
            
            if mark(i, 1) == 1
               % cmap = turbo(256);
               % rand_color_F = randperm(255);
               % rand_color_f = rand_color_F(1, 1);
               % rectangle('Position', [data(i, 2), data(i, 1), data(i, 4), data(i, 3)], 'LineWidth', 0.5, 'FaceColor', cmap(rand_color_f, :));
               rand_color_F = randperm(256);
               rand_color_f = rand_color_F(1, 1);
               rectangle('Position', [data(i, 2), data(i, 1), data(i, 4), data(i, 3)], 'LineWidth', 0.5, 'FaceColor', color_map(rand_color_f, :)); 
              % plot(data(i, 2), data(i, 1), 'K-o', 'MarkerFaceColor', 'K', 'MarkerSize', 3);
              % text(data(i, 2) + 30, data(i, 1) + 20, 'Item' + number(i, 3) + '(' + num2str(data(i, 2)) + ',' + num2str(data(i, 1)) + ')' + num2str(data(i, 4)) + 'mm*' + num2str(data(i, 3)) + 'mm', 'fontsize', 9, 'FontName', 'Times New Roman', 'FontAngle', 'italic');
               text((data(i, 2)+data(i, 4)/2-40), (data(i, 1)+data(i, 3)/2-5), 1, number(i, 3),'fontsize', 9, 'FontName', 'Times New Roman');
               str(text_mark,1) = "" +number(i, 3) + ':Position(' + num2str(data(i, 2)) + ',' + num2str(data(i, 1)) + ')' +':Size'+ num2str(data(i, 4)) + 'mm*' + num2str(data(i, 3))+ 'mm';
               text_mark=text_mark+1; 
            else
                rectangle('Position', [data(i, 2), data(i, 1), data(i, 4), data(i, 3)], 'LineWidth', 0.2, 'EdgeColor', 'k', 'LineStyle', ':','FaceColor',[0.87 0.87 0.87]);
            end
            
            i = i + 1;
        else
            break;
        end
        
    end
    
    dim =  [0.56 0.085 0.38 0.81];
    annotation('textbox',dim,'String',str,'LineStyle','-','LineWidth',0.1,'EdgeColor','w','fontsize', 9, 'FontName', 'Times New Roman','FitBoxToText','on' ,'VerticalAlignment','bottom') ;
    rectangle('Position', [0, 0, 1220, 2440], 'LineWidth',1, 'EdgeColor', 'K', 'LineStyle', '-');
    
    hold off;
    %saveas(gca,content+picture,'png');
    print(content + picture, '-dpng');

    close(gcf);
    
end
