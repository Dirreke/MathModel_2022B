%% data
file = ["../data/dataA/dataA1.csv", "../data/dataA/dataA2.csv", "../data/dataA/dataA3.csv", "../data/dataA/dataA4.csv"];
data_ori = data_pre_fun(file(1), 1);
height = 2440;
width = 1220;
%% model
model = q1_create_restricted_model_fun(width, height, data_ori);
num = length(model.obj);

%% solve
% rng default % for reproducibility
% obj = @(x)model.obj * x'; % objective
% x0 = [20,30]; % start point away from the minimum

% initpop = randi(20,num);
% opts = optimoptions('ga','InitialPopulationMatrix',initpop);
% opts = optimoptions('ga');
% [xga,fga,flga,oga] = ga(obj,num,model.A,model.b,model.Aeq,model.beq,model.lb,model.ub,[],1:num,opts)
%%  gaot
%
% [x,endPop,bPop,traceInfo] = gaot_ga(bounds,evalFN,evalOps,startPop,opts,...
% termFN,termOps,selectFN,selectOps,xOverFNs,xOverOps,mutFNs,mutOps)

%% gatbx

%% �����Ŵ��㷨����
NIND = 100; %������Ŀ
MAXGEN = 1000; %����Ŵ�����
GGAP = 0.90; %����
px = 0.1; %�������
pm = 0.007; %�������
ge_num = num;
trace = zeros(MAXGEN, ge_num); %Ѱ�Ž���ĳ�ʼֵ
tracei = zeros(MAXGEN, 1);
%% initial Chrom
%% x0
% bins = q1_FFF_fun(data_ori,width,height,0);
% xs = q1_bins2xs_fun(bins);
% x0 = [xs.alpha,xs.beta,xs.gamma];
% x0(model.index_delete) = [];
% Chrom(1,:) = logical(x0);

for k = 1:NIND
    bins = q1_FFF_fun(data_ori, width, height, 0, 1);
    xs = q1_bins2xs_fun(bins);
    x0 = [xs.alpha, xs.beta, xs.gamma];
    x0(model.index_delete) = [];
    Chrom(k, :) = logical(x0);
end

% Chrom=logical(crtbp(NIND,ge_num));%��ʼ��Ⱥ
% Chrom(1,:) = logical(x0);
%% �Ż�
obj = @(x, k)q1_BPSO_cost_fun(model, x, k);

gen = 0;
ObjV = obj(Chrom, gen)';

while gen < MAXGEN
    FitnV = ranking(ObjV); %������Ӧ��ֵ
    Selch = select('sus', Chrom, FitnV, GGAP); %ѡ��
    Selch = recombin('xovsp', Selch, 0.7); %����
    Selch = mut(Selch, pm);
    %     Selch=mut(Selch);
    ObjVSel = obj(Selch, gen)'; %�����Ӵ���Ŀ�꺯��ֵ
    [Chrom, ObjV] = reins(Chrom, Selch, 1, [1, 1], ObjV, ObjVSel); %�ز����Ӵ����������õ�����Ⱥ
    
    gen = gen + 1;
    gen
    %������������
    %��ȡÿ�������Ž⼰����ţ�YΪ���Ž�,IΪ��������
    [Y, I] = min(ObjV);
    trace(gen, :) = Chrom(I, :); %����ÿ��������ֵ
    tracei(gen, 1) = Y; %����ÿ��������ֵ
end

figure;
plot(1:MAXGEN, tracei);
grid on
xlabel('�Ŵ�����')
ylabel('��ı仯')
title('��������')
answer = zeros(MAXGEN, 1);
% for t=1:MAXGEN
%     answer(t)=weight(trace(t,:));
% end
