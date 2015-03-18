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
%visResults (X, y, XClean, yClean, modelCoeffs);

end % fitQuadModels

% This is a private function. Not callable from elsewhere.
function [XClean, yClean] = removeNaNs (X, y)
    missingVals = any ([X, y], 2);
    XClean = X(~missingVals);
    yClean = y(~missingVals);
end % removeNaNs

% private
function modelCoeffs = fitModel (XClean, yClean)
    nVars = size(XClean, 2); % 1 or 2 please.
    switch nVars
        case 1
            A = [ones(size(XClean)), XClean, XClean.^2];
        case 2
            x1 = XClean(:,1); x2 = XClean(:,2);
            A = [x1.^0, x1, x1.^2, x2, x2.^2, x1.*x2];
        otherwise
            % First arg is error identifier. It MUST contain a colon.
            error ('fitQuadModel:WrongNumberOfVars', ...
                   'X must have one or two columns');
    end % switch
    modelCoeffs = A\yClean;
end % fitModel

% private
function visResults (X, y, XClean, yClean, modelCoeffs)

end % visResults
