function [xstar, fxstar, flagOut, iter] = q2_branch_and_bound(obj, vlb, vub, nonlcon, optXin, optF, iter)
    global optX optVal optFlag;%�����Žⶨ��Ϊȫ�ֱ���
    iter = iter + 1;
    optX = optXin;
    optVal = optF;  %���µ����õ���ֵ
    
    [x, fit,exitflag,~] = fmincon(obj,x0,[],[],[],[],vlb,vub,nonlcon);
    if exitflag < 0  %û���ҵ����Ž⣬�˷�֧���ü���������ȥ������
        xstar = x;
        fxstar = fit;
        flagOut = exitflag;
        return;
    end

    if max(abs(round(x) - x)) > 1e-3    %�ҵ��ĺ������Ž��Բ���������
        if fit < optVal   %��ʱ�ĺ���ֵС��֮ǰ��õ�ֵ
            xstar = x;
            fxstar = fit;
            flagOut = -100;
            return;
        end 
    else    %��ʱ��õĺ�����Ϊ�����⣬�˷�֧�����������ټ���������⣬����
        if fit < optVal   %��ʱ�ĺ���ֵС��֮ǰ��õ�ֵ
            xstar = x;
            fxstar = fit;
            flagOut = -101;
            return;
        else   %�����ֵ>֮ǰ��õ�ֵ���ȷ���ȫ�ֱ�������ʱ���
            optVal = fit;
            optX = x;
            optFlag = status;
            xstar = x;
            fxstar = fit;
            flagOut = status;
            return;
        end
    end
    
    midX = abs(round(x) - x);     %�õ�x��Ӧ��С������
    notIntV = find(midX > 1e-3);  %�õ���������x������ֵ��find()�������ط�0������ֵ
    pXidx = notIntV(1);    %�õ���һ��������x���±�����
    tempVlb = vlb;         %��ʱ����һ��
    tempVub = vub;
    % fix(x) ������x��Ԫ���㷽��ȡ��
    if vub(pXidx) >= fix(x(pXidx)) + 1       %ԭ�Ͻ���ڴ�ʱ�ҵ��ķֽ��λ��ֵ
        tempVlb(pXidx) = fix(x(pXidx)) + 1;  %������ֽ�λ��ֵ��Ϊ�µ��½�������룬��һ���ݹ�
        [~, ~, ~] = q2_branch_and_bound(obj, tempVlb, vub, nonlcon, optX, optVal, iter+1);
    end
    if vlb(pXidx) <= fix(x(pXidx))         %ԭ�½�С�ڴ�ʱ�ҵ��ķֽ��λ��ֵ
        tempVub(pXidx) = fix(x(pXidx));    %������ֽ�λ��ֵ��Ϊ�µ��Ͻ�������룬��һ���ݹ�
        [~, ~, ~] = q2_branch_and_bound(obj, tempVlb, vub, nonlcon, optX, optVal, iter+1);
    end
    xstar = optX;
    fxstar = optVal;
    flagOut = optFlag;

end





% x0 = 1:n;
% 
% %�������B
% x_opt = 1:n;
% fval_opt = n;
% index_brand = 1;  %��֦�Ķ���
% [x_conti, fval_conti] = fmincon(obj,x0,[],[],[],[],model.lb,model.ub,model.nonlcon);
% fval_upper = obj(x0);
% fval_lower = fval_upper;
% lb_now = model.lb;
% ub_now = model.ub;
% while 1      %ѡx1���з�֧����Ϊa��b��֦
%    
%     %��֧a
%     lb_a = lb_now;
%     ub_a = ub_now;
%     ub_a(index_brand) = floor(x_conti(index_brand));
%     [x_a, fval_a,exitflag,output] = fmincon(obj,x0,[],[],[],[],lb_a,ub_a,model.nonlcon);
%     if exitflag < 0
%         break
%     end
%     %�����½�
%     if fval_a < fval_lower
%         fval_lower = fval_a;  
%     end
%     %�����Ͻ�
%     fval_x = obj(ceil(x_a));
%     if fval_x < fval_upper
%         fval_upper = fval_x;
%     end
%      
%     %��֧b
%     lb_b = lb_now;
%     lb_b(index_brand) = ceil(x_conti(index_brand));
%     ub_b = ub_now;
%     [x_b, fval_b] = fmincon(obj,x0,[],[],[],[],lb_b,ub_b,model.nonlcon);
%     if exitflag < 0
%         break
%     end
%     %�����½�
%     if fval_b < fval_lower
%         fval_lower = fval_b;  
%     end
%     %�����Ͻ�
%     fval_x = obj(ceil(x_b));
%     fval_x(fval_x<lb_b) = lb_b;  %�������ȡ�����������ֵ
%     if fval_x < fval_upper
%         fval_upper = fval_x;
%     end
%     
% end