function model = q2_create_x_model_fun(W, H, data)

% W = 1220;
% H = 2440;
% file_path = "../data/dataB/dataB1.csv";
% data = data_pre_fun(file_path);

C = unique(data(:, 8)); %ic:data中的item在C中的索引
n = length(C); %订单总数

lb = ones(1, n);
ub = 1:n;

obj = @(x)objV(data, W, H, x);

model.obj = obj;
model.A = [];
model.b = [];
model.Aeq = [];
model.beq = [];
model.lb = lb;
model.ub = ub;
coematrix = q2_create_Inl_coematrix_fun(data);
model.nonlcon = @(x)nlcon_x(x, coematrix);
end

function [c, ceq] = nlcon_x(x, coematrix)
alpha = x_to_alphax(x);
n = size(x);

Ax = coematrix.A * alpha' - coematrix.b; %计算不等式约束的情况
%     Ax(Ax<=0) = 0;     %将满足约束项的赋值为0
%     Ax_sum = sum(Ax, 'all');  %将不满足约束的求和

AEQx = coematrix.Aeq * alpha' - coematrix.beq; %计算等式约束的情况
%     AEQx_sum = sum(abs(AEQx), 'all');  %对每项取绝对值求和

%     c = Ax_sum + AEQx_sum;

% int process
x_old = x;
x = round(x);
ceq_2 = (x - x_old)' * 10;

c = Ax;
ceq = [AEQx; ceq_2];
end

function cost = objV(data, W, H, x)
alpha = x_to_alphax(x);
cost = q2_FFF_fun(data, W, H, alpha);
end

function alpha = x_to_alphax(x) %x(i)=j 到alpha(j,i)的映射
n = length(x); %订单数

index_1 = false(n);

for k = 1:n
    
    for kk = 1:k - 1
        index_1(k, kk) = 1;
    end
    
end

index_delete = reshape(index_1', 1, n^2);

alpha = zeros(n, n);

for k = 1:n %遍历x(k)
    alpha(round(x(k)), k) = 1; %从x到alpha的映射
end

alpha = reshape(alpha, 1, n^2);
alpha(:, index_delete) = [];
end
