function model = q2_create_x_model_fun(W, H, data)

% W = 1220;
% H = 2440;
% file_path = "../data/dataB/dataB1.csv";
% data = data_pre_fun(file_path);

C = unique(data(:, 8)); %ic:data�е�item��C�е�����
n = length(C); %��������

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

Ax = coematrix.A * alpha' - coematrix.b; %���㲻��ʽԼ�������
%     Ax(Ax<=0) = 0;     %������Լ����ĸ�ֵΪ0
%     Ax_sum = sum(Ax, 'all');  %��������Լ�������

AEQx = coematrix.Aeq * alpha' - coematrix.beq; %�����ʽԼ�������
%     AEQx_sum = sum(abs(AEQx), 'all');  %��ÿ��ȡ����ֵ���

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

function alpha = x_to_alphax(x) %x(i)=j ��alpha(j,i)��ӳ��
n = length(x); %������

index_1 = false(n);

for k = 1:n
    
    for kk = 1:k - 1
        index_1(k, kk) = 1;
    end
    
end

index_delete = reshape(index_1', 1, n^2);

alpha = zeros(n, n);

for k = 1:n %����x(k)
    alpha(round(x(k)), k) = 1; %��x��alpha��ӳ��
end

alpha = reshape(alpha, 1, n^2);
alpha(:, index_delete) = [];
end
