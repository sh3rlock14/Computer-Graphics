%{
Implement FPS using this algorithm:
    1) Fix n and let S(0) = fyg for some y 2 X
    2) Proceed recursively:
       ? At step k, given S(k-1), select x in (X; distX ) such that
                            x = arg   max   distX(x,S(k-1))
                                    x in X
       ? Set S(k) = S(k-1) U x
       ? Repeat until k = n

    3) Test with dierent starting points y
    4) Test with a xed starting point and gradually increasing n

Use FPS to dene the initial seed for k-means in color space.
%}


function [idx,seed] = fps_sampling(X, n, ptI)
    
    %i vertici della struttura sono memorizzati in VERT
    %X = X.VERT;
    seed = zeros(n + 1, 3);
    
    if nargin < 3 % non ho passato il punto di partenza
        seed(1, :) = X(randi(size(X, 1)), :);
    else % ho passato il punto di partenza
        try
            seed(1, :) = X(ptI, :);
        catch
            error('La shape non ha il punto indicato');
    end
    
    
    for i = 2:n + 1
        [idx, mi] = max(min(pdist2(seed(1:i, :), X)));
        seed(i, :) = X(mi(randi(length(mi))), :);
    end
    end
end