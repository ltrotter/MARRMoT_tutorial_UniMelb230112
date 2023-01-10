function [x,...  
          fval,...
          exitflag,...
          output] = ...
                    my_new_optimiser(fun,...
                                     x0,...
                                     options)

if ischar(fun)
    fun_char = fun;
    fitfun = @(x) feval(fun_char, x);
else
    fitfun = fun;
end

% value of fun at the initial parameter set
x = x0;
fval = fitfun(x);

% some loop that progressively improves fval
iter = 0;
exitflag = 0;
while true
    iter = iter + 1;

    % do something that returns a better x and fval
    x    = improve_x(fval, x);
    fval = fitfun(x);

    % set some termination conditions (these will be based on values in the
    % options)
    if fval < options.objective
        exitflag = 1;
    elseif iter == options.maxiter
        exitflag = 2;
    end

    % break the loop if any of the termination conditions is met
    if exitflag ~= 0; break; end
end