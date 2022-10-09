function [xstar, fxstar, flagOut, iter] = q2_branch_and_bound(obj, vlb, vub, nonlcon, optXin, optF, iter)
    global optX optVal optFlag;%将最优解定义为全局变量
    iter = iter + 1;
    optX = optXin;
    optVal = optF;  %更新迭代得到的值
    
    [x, fit,exitflag,~] = fmincon(obj,x0,[],[],[],[],vlb,vub,nonlcon);
    if exitflag < 0  %没有找到最优解，此分支不用继续迭代下去，返回
        xstar = x;
        fxstar = fit;
        flagOut = exitflag;
        return;
    end

    if max(abs(round(x) - x)) > 1e-3    %找到的函数最优解仍不是整数解
        if fit < optVal   %此时的函数值小于之前解得的值
            xstar = x;
            fxstar = fit;
            flagOut = -100;
            return;
        end 
    else    %此时解得的函数解为整数解，此分支求解结束，不再继续向下求解，返回
        if fit < optVal   %此时的函数值小于之前解得的值
            xstar = x;
            fxstar = fit;
            flagOut = -101;
            return;
        else   %解出的值>之前解得的值，先放入全局变量中暂时存放
            optVal = fit;
            optX = x;
            optFlag = status;
            xstar = x;
            fxstar = fit;
            flagOut = status;
            return;
        end
    end
    
    midX = abs(round(x) - x);     %得到x对应的小数部分
    notIntV = find(midX > 1e-3);  %得到非整数的x的索引值，find()函数返回非0的索引值
    pXidx = notIntV(1);    %得到第一个非整数x的下标索引
    tempVlb = vlb;         %临时拷贝一份
    tempVub = vub;
    % fix(x) 函数将x中元素零方向取整
    if vub(pXidx) >= fix(x(pXidx)) + 1       %原上界大于此时找到的分界的位置值
        tempVlb(pXidx) = fix(x(pXidx)) + 1;  %将这个分界位置值作为新的下界参数传入，进一步递归
        [~, ~, ~] = q2_branch_and_bound(obj, tempVlb, vub, nonlcon, optX, optVal, iter+1);
    end
    if vlb(pXidx) <= fix(x(pXidx))         %原下界小于此时找到的分界的位置值
        tempVub(pXidx) = fix(x(pXidx));    %将这个分界位置值作为新的上界参数传入，进一步递归
        [~, ~, ~] = q2_branch_and_bound(obj, tempVlb, vub, nonlcon, optX, optVal, iter+1);
    end
    xstar = optX;
    fxstar = optVal;
    flagOut = optFlag;

end





% x0 = 1:n;
% 
% %求解问题B
% x_opt = 1:n;
% fval_opt = n;
% index_brand = 1;  %分枝的对象
% [x_conti, fval_conti] = fmincon(obj,x0,[],[],[],[],model.lb,model.ub,model.nonlcon);
% fval_upper = obj(x0);
% fval_lower = fval_upper;
% lb_now = model.lb;
% ub_now = model.ub;
% while 1      %选x1进行分支，分为a、b两枝
%    
%     %分支a
%     lb_a = lb_now;
%     ub_a = ub_now;
%     ub_a(index_brand) = floor(x_conti(index_brand));
%     [x_a, fval_a,exitflag,output] = fmincon(obj,x0,[],[],[],[],lb_a,ub_a,model.nonlcon);
%     if exitflag < 0
%         break
%     end
%     %更新下界
%     if fval_a < fval_lower
%         fval_lower = fval_a;  
%     end
%     %更新上界
%     fval_x = obj(ceil(x_a));
%     if fval_x < fval_upper
%         fval_upper = fval_x;
%     end
%      
%     %分支b
%     lb_b = lb_now;
%     lb_b(index_brand) = ceil(x_conti(index_brand));
%     ub_b = ub_now;
%     [x_b, fval_b] = fmincon(obj,x0,[],[],[],[],lb_b,ub_b,model.nonlcon);
%     if exitflag < 0
%         break
%     end
%     %更新下界
%     if fval_b < fval_lower
%         fval_lower = fval_b;  
%     end
%     %更新上界
%     fval_x = obj(ceil(x_b));
%     fval_x(fval_x<lb_b) = lb_b;  %如果向下取整低于了最低值
%     if fval_x < fval_upper
%         fval_upper = fval_x;
%     end
%     
% end