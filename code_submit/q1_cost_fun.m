function cost = q1_BPSO_cost_fun(model, x, k)
x = x';
cost = model.obj * x + k * sqrt(k) * sum(max(0, model.A * x - model.b)) + k * sqrt(k) * sum(max(0, abs(model.Aeq * x - model.beq)));
end
