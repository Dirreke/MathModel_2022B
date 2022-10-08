% function model = q2_create_x_model_fun(W,H,data)

W = 1220;
H = 2440;
file_path = "../data/dataB/dataB1.csv";
data = data_pre_fun(file_path);

[C, ia, ic] = unique(data(:,8));    %ic:data�е�item��C�е�����
n = length(C);      %��������

lb = zeros(1, n);
ub = n*ones(1, n);

obj = @(x)objV(data,W,H,x);

model.obj = obj;
model.A = [];
model.b = [];
model.Aeq = [];
model.beq = [];
model.lb = lb;
model.ub = ub;
model.nonlcon = @(x)nlcon_x(x, data);
%end

function c = nlcon_x(x, data)
    alpha = x_to_alphax(x);
    n = size(x);
    coematrix = q2_create_Inl_coematrix_fun(data);

    Ax = coematrix.A*alpha - coematrix.b;  %���㲻��ʽԼ�������
    Ax(Ax<=0) = 0;     %������Լ����ĸ�ֵΪ0
    Ax_sum = sum(Ax, 'all');  %��������Լ�������
    
    AEQx = coematrix.Aeq*alpha - coematrix.beq;  %�����ʽԼ�������
    AEQx_sum = sum(abs(AEQx), 'all');  %��ÿ��ȡ����ֵ���
    
    c = Ax_sum + AEQx_sum;
end

function cost = objV(data,W,H,x)
    alpha = x_to_alphax(x);
    cost = q2_FFF_fun(data,W,H,alpha);
end

function alpha = x_to_alphax(x)  %x(i)=j ��alpha(j,i)��ӳ��
    n = size(x);  %������
    
    index_1 = false(n);
    for k = 1:n
        for kk = 1:k-1
            index_1(k,kk) = 1;
        end
    end
    index_delete = reshape(index_1',1,n^2);
    
    alpha = zeros(n,n);
    for k = 1:n  %����x(k)
        alpha(x(k), k) = 1;  %��x��alpha��ӳ��
    end
    alpha(:,index_delete) = [];
end