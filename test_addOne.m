function tests = test_addOne()
%TEST_ADDONE: Test harness for the "addOne" function.

    % This runs all the functions which are local to this file.
    tests = functiontests(localfunctions());
end % test_addOne

% It's ok to have apparently unused functions in this file, because they're
% all called in localfunctions()
%#ok<*DEFNU>

% T is the test object. It's used to record the results of this test.
function testScalarDouble(T)
    input = 1;
    expected = 2;
    actual = addOne(input);
    % Compare actual with expected and record the result in T.
    verifyEqual(T, actual, expected);
end

function testComplex(T)
    input = 3+5i;
    expected = 4+5i;
    actual = addOne(input);
    verifyEqual(T, actual, expected);
end

% Exercise: Two more tests for inputs [0;0;0;0] and eye(2)
function testColZeros(T)
    input = [0;0;0;0];
    expected = [1;1;1;1];
    actual = addOne(input);
    verifyEqual(T, actual, expected);
end

% A better version of the above:
function testVector(T)
    input = zeros(4,1);
    expected = ones(size(input));
    actual = addOne(input);
    % Note use of abstol to avoid precision errors:
    verifyEqual(T, actual, expected, 'AbsTol', 1e-6);
end

function testEye(T)
    input = eye(2);
    expected = [2,1;1,2];
    actual = addOne(input);
    verifyEqual(T, actual, expected);
end

function testMike(T)
    input = 'Mike';
    expected = 'Njlf';
    actual = char(addOne(input));
    verifyEqual(T, actual, expected);
end

% Verify we get an error for the wrong input arguments
function testNargin(T)
    % Test with zero inputs
    codeToEvaluate = @() addOne();
    verifyError(T, codeToEvaluate, 'MATLAB:narginchk:notEnoughInputs');

    % Test with too many inputs
    codeToEvaluate = @() addOne(1, 1);
    verifyError(T, codeToEvaluate, 'MATLAB:TooManyInputs');
end

% Verify behaviour with empty input
function testEmpty(T)
    codeToEvaluate = @() addOne([]);
    verifyError(T, codeToEvaluate, 'MATLAB:expectedNonempty');
end

% Test what happens for NaN/Inf
function testNaNInf(T)
    verifyEqual(T, addOne(NaN), NaN);
    verifyEqual(T, addOne(Inf), Inf);
    verifyEqual(T, addOne(-Inf), -Inf);
end

% Tip: See MException.last to see last exception. Can also access
% MXException.last.identifier.
