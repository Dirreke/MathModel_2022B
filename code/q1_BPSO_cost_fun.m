function cost=q1_BPSO_cost_fun(model,x,k)
% if size(x,1) == 1
    x = x';
% end


cost = model.obj * x + 0.001 * sum(max(0,model.A*x - model.b)) + sum(max(0,abs(model.Aeq*x - model.beq)));
cost = model.obj * x + k*sqrt(k) * sum(max(0,model.A*x - model.b)) + k*sqrt(k) * sum(max(0,abs(model.Aeq*x - model.beq)));
% cost = sum(x);

end