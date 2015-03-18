%% Interactive prototyping
load S02_MedData

%% Basic data exploration
figure
x = MedData.Age;
y = MedData.BPDiff; % pulse pressure

scatter (x,y, 'kx')
xlabel ('Age')
ylabel ('Pulse pressure mmHg')
title ('PP vs age')

%% quadratic fit

missingVals = isnan(x);
xClean = x(~missingVals);
yClean = y(~missingVals);

b = yClean;
A = [xClean.^0, xClean, xClean.^2];
modelCoeffs = A\b

pulseModel = A * modelCoeffs;

hold on
plot (xClean, pulseModel, 'r*')
legend('raw', 'fit')

%% Two dimensions

h = MedData.Height;      % x1
waist = MedData.Waist;   % x2
weight = MedData.Weight; % y

% Can we estimate weight from waist and height?

% Step 1 scatter plot
figure
scatter3 (h, waist, weight);

% Step 2 clean data
missingWaist = isnan(waist);
missingH = isnan(h);
missingWeight = isnan(weight);
missing = missingWaist | missingH | missingWeight;
% or missing = any(isnan ([h, waist, weight]), 2)

size (missing)

x1Clean = h(~missing);
x2Clean = waist(~missing);
yClean = weight(~missing);

% Step 3 generate a fit);
b = yClean;
A = [x2Clean.^0, x1Clean, x1Clean.^2, x2Clean, x2Clean.^2, x1Clean .* x2Clean];
coeffs = A\b

% Step 4 visualisation
modelFun = @(c, x1, x2) c(1) + c(2)*x1 + c(3)*x1.^2 + c(4)*x2 + c(5)*x2.^2 + c(6)*x1.*x2; 
% make vector data for x1 and x2
x1Vec = linspace (min(x1Clean), max(x1Clean), 150);
x2Vec = linspace (min(x2Clean), max(x2Clean), 150);
% meshgrid these vectors into a grid
[X1, X2] = meshgrid (x1Vec, x2Vec);
% Eval model on grid
modelOnGrid = modelFun(coeffs, X1, X2);

hold on
surf (X1, X2, modelOnGrid, 'EdgeAlpha', 0);
xlabel ('h')
ylabel ('waist')
zlabel ('weight')
%shading interp

% Surface
%w1 = [59:10:180];
%h1 = [130:10:210];
%[X,Y] = meshgrid (w1,h1);

%% Testing our fitQuadModels function
x = MedData.Age;
y = MedData.BPDiff;
modelCoeffs = fitQuadModels (x,y)

%% 2D test
height = MedData.Height;
weight = MedData.Weight;
waist = MedData.Waist;
modelCoeffs = fitQuadModels([height waist], weight)
