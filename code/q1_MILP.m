W = 2440;
H = 1220;
data = data_pre_fun("../data/dataA/dataA1.csv");
% data(3:end,:)=[];
%% MILP
n = size(data,1);
alpha = zeros(n);
beta = zeros(n);
gamma = zeros(n);

% A = zeros(n,3*n^2)
index_1 = false(n);
for k = 1:n
    for kk = 1:k-1
        index_1(k,kk) = 1;
    end
end
index_1 = reshape(index_1',1,n^2);
index_1 = [index_1,index_1, index_1];

Aeq_2 = zeros(n,3*n^2);
beq_2 = zeros(n,1);
for k = 1:n
    Aeq_2(k,k:n:k*n) = 1;
    beq_2(k,:) = 1;
end
Aeq_2 = sparse(Aeq_2);
beq_2 = sparse(beq_2);

index_3 = false(1,3*n^2);
for k = 1:n-1
    for kk = k+1:n
        if data(kk,4)~=data(k,4) || data(kk,3) + data(k,3)> H
            index_3((k-1)*n+kk) = 1;
        end
    end
end

    
Aeq_4 = zeros(n,3*n^2);
beq_4 = zeros(n,1);
for k = 1:n     % j
    Aeq_4(k,n^2+k:n:n^2+k*n) = 1;
    Aeq_4(k,k*n-n+k) = -1;    % -alpha_jj
end
Aeq_4 = sparse(Aeq_4);
beq_4 = sparse(beq_4);

A_5 = zeros(n-1,3*n^2);
b_5 = zeros(n-1,1);
for k = 1:n-1     % j
    A_5(k,n*k-n+k:n*k) = data(k:n,3)';
    A_5(k,n^2+k:n:n^2+k*n) = -data(1:k,3)';
end
A_5 = sparse(A_5);
b_5 = sparse(b_5);

A_6 = zeros(n-1,3*n^2);
b_6 = zeros(n-1,1);
for k = 1:n-1     % k
    A_6(k,n^2+n*k-n+k:n^2+n*k) = data(k:n,4)';
    A_6(k,n^2+n*k-n+k) = A_6(k,n^2+n*k-n+k)-W;
end
A_6 = sparse(A_6);
b_6 = sparse(b_6);

Aeq_7 = zeros(n,3*n^2);
beq_7 = zeros(n,1);
for k = 1:n     % k
    Aeq_7(k,2*n^2+k:n:2*n^2+k*n) = 1;
    Aeq_7(k,n^2+k*n-n+k) = -1;    % -beta_kk
end
Aeq_7 = sparse(Aeq_7);
beq_7 = sparse(beq_7);

A_8 = zeros(n-1,3*n^2);
b_8 = zeros(n-1,1);
for k = 1:n-1     % l
    A_8(k,2*n^2+n*k-n+k:2*n^2+n*k) = data(k:n,3)';
    A_8(k,2*n^2+n*k-n+k) = -H;
end
A_8 = sparse(A_8);
b_8 = sparse(b_8);


Aeq = [Aeq_2;Aeq_4;Aeq_7];
beq = [beq_2;beq_4;beq_7];
clear Aeq_2 Aeq_4 Aeq_7
clear beq_2 beq_4 beq_7
Aeq(:,index_1 | index_3) = [];

A = [A_5;A_6;A_8];
b = [b_5;b_6;b_8];
clear A_5 A_6 A_8
clear b_5 b_6 b_8
A(:,index_1 | index_3)=[];


lb = sparse(zeros(1,3*n^2));
ub = sparse(ones(1,3*n^2));
intcon = 1:3*n^2-sum(index_1)-sum(index_3);
lb(index_1 | index_3)=[];
ub(index_1 | index_3)=[];

obj = zeros(1,3*n^2);
obj(2*n^2+1:n+1:end) = 1;
obj(index_1 | index_3)=[];
obj = sparse(obj);

test = intlinprog(obj,intcon,A,b,Aeq,beq,lb,ub);
% function cost = q1_cost(x)
%     n = round(length(x)/3);
%     % alpha = x(1:n);
%     % beta  = x(n+1:2*n);
%     gamma = x(2*n^2:3*n^2);
% 
%     cost = sum(diag(gamma));
% 
% end
