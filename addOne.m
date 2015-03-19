function xplusone = addOne(x)
    narginchk(1, 1);
    validateattributes(x, {'double', 'char'}, {'nonempty'});
    xplusone = x + 1;
end % addOne
