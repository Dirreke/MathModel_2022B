function model = q1_create_unrestricted_model_fun(W, H, data)
% W = 1220;
% H = 2440;
% data = data_pre_fun("../data/dataA/dataA1.csv");
data = data(1:2, :);

% A = zeros(n,3*n^2)
index_1 = false(n);

for k = 1:n
    
    for kk = 1:k - 1
        index_1(k, kk) = 1;
    end
    
end

index_1 = reshape(index_1', 1, n^2);
index_1 = [index_1, zeros(1, n^2), index_1];

Aeq_17 = zeros(n, 3 * n^2);
beq_17 = zeros(n, 1);

for k = 1:n
    Aeq_17(k, k:n:k * n) = 1;
    beq_17(k, :) = 1;
end

Aeq_17 = sparse(Aeq_17);
beq_17 = sparse(beq_17);

index_3 = false(1, 3 * n^2);

for k = 1:n - 1
    
    for kk = k + 1:n
        
        if data(kk, 4) ~= data(k, 4) || data(kk, 3) + data(k, 3) > H
            index_3((k - 1) * n + kk) = 1;
        end
        
    end
    
end

Aeq_20 = zeros(n, 3 * n^2);
beq_20 = zeros(n, 1);

for k = 1:n % j
    Aeq_20(k, n^2 + k:n:n^2 + k + n * n) = 1;
    Aeq_20(k, k * n - n + k) = -1; % -alpha_jj
end

Aeq_20 = sparse(Aeq_20);
beq_20 = sparse(beq_20);

A_21 = zeros(n - 1, 3 * n^2);
b_21 = zeros(n - 1, 1);

for t = 2:n %k
    
    for k = 1:n - 1 %j
        A_21(k + (n - 1) * (t - 2), n * k - n + k:n:n * k) = data(k:n, 3)';
        A_21(k + (n - 1) * (t - 2), n * t - n + t:n:n * t) = -data(t:n, 3)';
        A_21(k + (n - 1) * (t - 2), n^2 + t * n + k) = H + 1;
        b_21(k + (n - 1) * (t - 2), 1) = H + 1;
    end
    
end

A_22 = zeros(n - 1, 3 * n^2);
b_22 = zeros(n - 1, 1);

for t = 1:n - 1 %k
    
    for k = t + 1:n %j
        A_22(k - t + (n - 1) * (t - 1), n * k - n + k:n:n * k) = data(k:n, 3)';
        A_22(k - t + (n - 1) * (t - 1), n * t - n + t:n:n * t) = -data(t:n, 3)';
        A_22(k - t + (n - 1) * (t - 1), n^2 + t * n + k) = H;
        b_22(k - t + (n - 1) * (t - 1), 1) = H;
    end
    
end

%% here!
A_23 = zeros(n - 1, 3 * n^2);
b_23 = zeros(n - 1, 1);

for k = 1:n % k
    A_23(k, n^2 + n * k - n + k:n^2 + n * k) = data(k:n, 4)';
    A_23(k, n^2 + n * k - n + k) = A_23(k, n^2 + n * k - n + k) - W;
end

A_23 = sparse(A_23);
b_23 = sparse(b_23);

Aeq_7 = zeros(n, 3 * n^2);
beq_7 = zeros(n, 1);

for k = 1:n % k
    Aeq_7(k, 2 * n^2 + k:n:2 * n^2 + k * n) = 1;
    Aeq_7(k, n^2 + k * n - n + k) = -1; % -beta_kk
end

Aeq_7 = sparse(Aeq_7);
beq_7 = sparse(beq_7);

A_8 = zeros(n - 1, 3 * n^2);
b_8 = zeros(n - 1, 1);

for k = 1:n - 1 % l
    A_8(k, 2 * n^2 + n * k - n + k:2 * n^2 + n * k) = data(k:n, 3)';
    A_8(k, 2 * n^2 + n * k - n + k) = A_8(k, 2 * n^2 + n * k - n + k) -H;
end

A_8 = sparse(A_8);
b_8 = sparse(b_8);

index_delete = index_1 | index_3;

Aeq = [Aeq_17; Aeq_20; Aeq_7];
beq = [beq_17; beq_20; beq_7];
clear Aeq_2 Aeq_4 Aeq_7
clear beq_2 beq_4 beq_7
Aeq(:, index_delete) = [];

A = [A_21; A_23; A_8];
b = [b_21; b_23; b_8];
clear A_5 A_6 A_8
clear b_5 b_6 b_8
A(:, index_delete) = [];

lb = sparse(zeros(1, 3 * n^2));
ub = sparse(ones(1, 3 * n^2));
intcon = 1:3 * n^2 - sum(index_1) - sum(index_3);
lb(index_delete) = [];
ub(index_delete) = [];

obj = zeros(1, 3 * n^2);
obj(2 * n^2 + 1:n + 1:end) = 1;
obj(index_delete) = [];
obj = sparse(obj);

model.obj = obj;
model.A = A;
model.b = b;
model.Aeq = Aeq;
model.beq = beq;
model.lb = lb;
model.ub = ub;
model.index_delete = index_delete;
end
