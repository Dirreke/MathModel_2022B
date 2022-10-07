f = fopen("C:\Users\admin\Desktop\组批方案.csv");
fgetl(f);
data_ori = textscan(f,'%s %s %s %s %f %f %f %f','delimiter',',');
number(:,1) = string(data_ori{1});   % 批次序号
number(:,2) = string(data_ori{3});    % 原片序号 
number(:,3) = string(data_ori{4});    % 产品ID
material(:,1) = data_ori{2};    % 原片材质
data(:,1) = data_ori{5};    % 产品x坐标
data(:,2) = data_ori{6};    % 产品y坐标
data(:,3) = data_ori{7};    % 产品x方向长度
data(:,4) = data_ori{8};    % 产品y方向长度

i=1;
while i<=3
    picture='Batch'+number(i,1)+'-'+'Board'+number(i,3)+'-'+'Material'+number(i,2)
    figure('NumberTitle', 'off','Name',picture);
   
    hold on;
    rectangle('Position',[0,0,2440,1220],'LineWidth',0.5,'EdgeColor','K','LineStyle','-');
    plot(data(i,1),data(i,2),'K-o','MarkerFaceColor','K','MarkerSize',3);
    text(data(i,1)+30,data(i,2)+30,'ID'+number(i,3)+'('+num2str(data(i,1))+','+num2str(data(i,2))+')','fontsize',9,'FontName', 'Times New Roman');
    rectangle('Position',[data(i,1),data(i,2),data(i,3),data(i,4)],'LineWidth',0.5,'EdgeColor','r','LineStyle','--');
    i=i+1;
    axis([0 2440 0 1220]);
    set(gca, 'XTick', 0:0:0);
    set(gca, 'YTick', 0:0:0);
    set(gca, 'fontsize',9,'FontName', 'Times New Roman');
    xlabel('2440mm','fontsize',9,'FontName', 'Times New Roman');
    ylabel('1220mm','fontsize',9,'FontName', 'Times New Roman');
    title(picture);
   
    if i<=3
    while  strcmpi(number(i-1,2), number(i,2))
         plot(data(i,1),data(i,2),'K-o','MarkerFaceColor','K','MarkerSize',3);
         text(data(i,1)+30,data(i,2)+30,'ID'+number(i,3)+'('+num2str(data(i,1))+','+num2str(data(i,2))+')','fontsize',9,'FontName', 'Times New Roman' );
         rectangle('Position',[data(i,1),data(i,2),data(i,3),data(i,4)],'LineWidth',0.5,'EdgeColor','r','LineStyle','--');
         i=i+1;
    end
    end
    fig_width = 28.8;%cm
    fig_height = 24.7;
   
    hold off;
    saveas(gca,picture,'png')

end
    
