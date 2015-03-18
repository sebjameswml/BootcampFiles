function [ modelCoeffs ] = fitQuadModels (X, y)
% fitQuadModels Do a quadratic fit to input data
% y is the output vector.
% X is the matrix of input vectors.
% returns model coefficients for a quadratic fit.
% See also surf, meshgrid, linspace

% Clean the data
[XClean, yClean] = removeNaNs (X, y);

% Fit the model
modelCoeffs = fitModel (XClean, yClean);

% Visualise results
visResults (X, y, XClean, yClean, modelCoeffs);

end % fitQuadModels

% This is a private function. Not callable from elsewhere.
function [XClean, yClean] = removeNaNs (X, y)
    missingVals = any ([X, y], 2);
    XClean = X(~missingVals);
    yClean = y(~missingVals);
end % removeNaNs

% private
function modelCoeffs = fitModel (XClean, yClean)

end % fitModel

% private
function visResults (X, y, XClean, yClean, modelCoeffs)

end % visResults
