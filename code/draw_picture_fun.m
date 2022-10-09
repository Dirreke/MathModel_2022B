function draw_picture_fun(data_type,id)

if data_type == 1
    content = "../result/figuresA/";
    input_file = "../result/figure_dataA/figure_A" + id + ".csv";
elseif data_type == 2
    content = "../result/figuresB/";
    input_file = "../result/figure_dataB/figure_B"+id+".csv";
end

file_info = dir(input_file);
tmp = strfind(file_info.name,'.');
if ~isempty(tmp)
    tmp = tmp(end);
    file_name = file_info.name(1:tmp-1);
else
    file_name = file_info.name;
end
content = content + '/' + file_name + '/';
if ~isfolder(content)
    mkdir(content);
end

f = fopen(input_file);
fgetl(f);
data_ori = textscan(f,'%s %s %s %s %f %f %f %f %d','delimiter',',');
fclose(f);
number(:,1) = string(data_ori{1});   % �������
number(:,2) = string(data_ori{3});    % ԭƬ��� 
number(:,3) = string(data_ori{4});    % ��ƷID
material(:,1) = data_ori{2};    % ԭƬ����
data(:,1) = data_ori{5};    % ��Ʒx����
data(:,2) = data_ori{6};    % ��Ʒy����
data(:,3) = data_ori{7};    % ��Ʒx���򳤶�
data(:,4) = data_ori{8};    % ��Ʒy���򳤶�
flag(:,1) = data_ori{9};    % �Ƿ�Ϊ��Ʒ���־??

numtotal_item=length(number(:,3));

i=1;
while i<=28%numtotal_item %��Ʒ�ܸ�??
    picture = 'Batch'+number(i,1)+'-'+'Board'+number(i,2)+'-'+'Material'+material(i,1);
    figure('NumberTitle', 'off','Name',picture);
 
    hold on;
    rectangle('Position',[0,0,2440,1220],'LineWidth',0.5,'EdgeColor','K','LineStyle','-');

    if flag(i,1)==1
    cmap=hsv(256);
    rand_color_F=randperm(255);
    rand_color_f=rand_color_F(1,1);
    rectangle('Position',[data(i,1),data(i,2),data(i,3),data(i,4)],'LineWidth',0.5,'FaceColor',cmap(rand_color_f,:));
    plot(data(i,1),data(i,2),'K-o','MarkerFaceColor','K','MarkerSize',3);
    text(data(i,1)+30,data(i,2)+20,'Order'+number(i,3)+'('+num2str(data(i,1))+','+num2str(data(i,2))+')','fontsize',5,'FontName', 'Times New Roman','FontAngle','italic');
    else
    cmap=hsv(256);
    rand_color_F=randperm(255);
    rand_color_f=rand_color_F(1,1);
    rectangle('Position',[data(i,1),data(i,2),data(i,3),data(i,4)],'LineWidth',0.2,'EdgeColor','k','LineStyle',':');
    end
    i=i+1;
    axis([0 2440 0 1220]);
    set(gca, 'XTick', 0:0:0);
    set(gca, 'YTick', 0:0:0);
    set(gca, 'fontsize',9,'FontName', 'Times New Roman');
    set(gca, 'position',[0.05 0.1 0.9 0.81]);
    set(gcf, 'position',[0.75 1.5 333 188]);
    xlabel('2440mm','fontsize',9,'FontName', 'Times New Roman');
    ylabel('1220mm','fontsize',9,'FontName', 'Times New Roman');
    title(picture);
   
    while i<=28%numtotal_item  %��Ʒ�ܸ�??
    if strcmpi(number(i-1,2), number(i,2))
         if flag(i,1)==1
         cmap=hsv(256);
         rand_color_F=randperm(255);
         rand_color_f=rand_color_F(1,1);
         rectangle('Position',[data(i,1),data(i,2),data(i,3),data(i,4)],'LineWidth',0.5,'FaceColor',cmap(rand_color_f,:));
         plot(data(i,1),data(i,2),'K-o','MarkerFaceColor','K','MarkerSize',3);
         text(data(i,1)+30,data(i,2)+20,'Order'+number(i,3)+'('+num2str(data(i,1))+','+num2str(data(i,2))+')','fontsize',5,'FontName', 'Times New Roman','FontAngle','italic');
         else
         rectangle('Position',[data(i,1),data(i,2),data(i,3),data(i,4)],'LineWidth',0.2,'EdgeColor','k','LineStyle',':');
         end
         i=i+1;
    else
         break;
    end
    end

   
    hold off;
    saveas(gca,content+picture,'png');
%     close(gcf);
 
end
    
