function model = q2_create_nl_model_fun(W,H,data)

W = 1220;
H = 2440;
file_path = "../data/dataB/dataB1.csv";
data = data_pre_fun(file_path);

max_item_num = 1000;            %单个批次产品项（item）总数上限
max_item_area = 250*1000*1000;  %单个批次产品项（item）的面积总和上限

[C, ia, ic] = unique(data(:,8));    %ic:data中的item在C中的索引
a_counts = accumarray(ic,1);
item_counts = [C, a_counts];        %订单包含的item数量
n = length(C);      %订单总数

order_item_info = [item_counts,zeros(n,1)];  %订单order，所含item数，所含item总面积
for k = 1:size(data, 1)     %计算订单的item总面积
    order_item_info(ic(k),3) = order_item_info(ic(k),3) + data(k,5);
end

index_1 = false(n);
for k = 1:n
    for kk = 1:k-1
        index_1(k,kk) = 1;
    end
end
index_1 = reshape(index_1',1,n^2);
index_1 = [index_1, index_1];


tmp = speye(n^2);
Aeq_1 = [tmp,tmp];
beq_1 = ones(n^2,1);

Aeq_2 = zeros(n,2*n^2);
beq_2 = zeros(n,1);
for k = 1:n    %j
    Aeq_2(k,k:n:k*n) = 1;
    beq_2(k,:) = 1;
end

A_3 = zeros(n,2*n^2);
b_3 = zeros(n,1);
for k = 1:n
    A_3(k,n*(k-1)+k:n*k) = order_item_info(k:n,2)';
    b_3(k,:) = max_item_num;
end

A_4 = zeros(n,2*n^2);
b_4 = zeros(n,1);
for k = 1:n
    A_4(k,n*(k-1)+k:n*k) = order_item_info(k:n,3)';
    b_4(k,:) = max_item_area;
end

A_5 = zeros(n, 2*n^2);
b_5 = zeros(n,1);
for k = 1:n-1  %j
    A_5(k,n*(k-1)+k+1:n*(k-1)+n) = 1;
    A_5(k,n*(k-1)+k) = -(n-k);
end

A_6 = zeros(n, 2*n^2);
b_6 = zeros(n,1);
for k = 1:n  %j
    A_6(k,n*(k-1)+k+1:n*(k-1)+n) = 1;
    A_6(k,n*(k-1)+k) = 1-(n-k+1);
end

index_delete = index_1;

Aeq = [Aeq_1;Aeq_2];
beq = [beq_1;beq_2];
clear Aeq_1 Aeq_2
clear beq_1 beq_2
Aeq(:,index_delete) = [];

A = [A_3;A_4;A_5;A_6];
b = [b_3;b_4;b_5;b_6];
clear A_3 A_4 A_5 A_6
clear b_3 b_4 b_5 b_6
A(:,index_delete) = [];

lb = zeros(1,2*n^2);
ub = ones(1,2*n^2);
lb(index_delete)=[];
ub(index_delete)=[];

obj = @(x)objV(data,W,H,x,index_delete);

model.obj = obj;
model.A = A;
model.b = b;
model.Aeq = Aeq;
model.beq = beq;
model.lb = lb;
model.ub = ub;
model.nonlcon = @(x)nlcon(x);
model.index_delete = index_delete;
end

function c = nlcon(x)
    alpha = x(:,1:end/2);
    beta = x(:,end/2+1:end);
    c = sum(alpha.*beta, 2);
end

function cost = objV(data,W,H,x,index_delete)
n = length(x) + sum(index_delete);
alpha = false(1,n^2);
alpha(~index_delete) = x;
alpha = reshape(alpha,n,n);

cost = q2_FFF_fun(data,W,H,alpha);
end
