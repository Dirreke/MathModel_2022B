function coematrix = q2_create_Inl_coematrix_fun(data)
%���붩�����������������0-1�����滮ģ�͵�ϵ������

max_item_num = 1000; %�������β�Ʒ�item����������
max_item_area = 250 * 1000 * 1000; %�������β�Ʒ�item��������ܺ�����

[C, ia, ic] = unique(data(:, 8)); %ic:data�е�item��C�е�����
a_counts = accumarray(ic, 1);
item_counts = [C, a_counts]; %����������item����
n = length(C); %��������

order_item_info = [item_counts, zeros(n, 1)]; %����order������item��������item�����

for k = 1:size(data, 1) %���㶩����item�����
    order_item_info(ic(k), 3) = order_item_info(ic(k), 3) + data(k, 5);
end

index_1 = false(n);

for k = 1:n
    
    for kk = 1:k - 1
        index_1(k, kk) = 1;
    end
    
end

index_delete = reshape(index_1', 1, n^2);

Aeq = zeros(n, n^2);
beq = zeros(n, 1);

for k = 1:n
    Aeq(k, k:n:k * n) = 1;
    beq(k, :) = 1;
end

Aeq(:, index_delete) = [];

A_3 = zeros(n, n^2);
b_3 = zeros(n, 1);

for k = 1:n
    A_3(k, n * (k - 1) + k:n * k) = order_item_info(k:n, 2)';
    b_3(k, :) = max_item_num;
end

A_4 = zeros(n, n^2);
b_4 = zeros(n, 1);

for k = 1:n
    A_4(k, n * (k - 1) + k:n * k) = order_item_info(k:n, 3)';
    b_4(k, :) = max_item_area;
end

A_5 = zeros(n, n^2);
b_5 = zeros(n, 1);

for k = 1:n - 1 %j
    A_5(k, n * (k - 1) + k + 1:n * (k - 1) + n) = 1;
    A_5(k, n * (k - 1) + k) =- (n - k);
end

A_6 = zeros(n, n^2);
b_6 = zeros(n, 1);

for k = 1:n %j
    A_6(k, n * (k - 1) + k + 1:n * (k - 1) + n) = 1;
    A_6(k, n * (k - 1) + k) = 1 - (n - k + 1);
end

A = [A_3; A_4; A_5; A_6];
b = [b_3; b_4; b_5; b_6];
clear A_3 A_4 A_5 A_6
clear b_3 b_4 b_5 b_6
A(:, index_delete) = [];

coematrix.Aeq = Aeq;
coematrix.beq = beq;
coematrix.A = A;
coematrix.b = b;
end
