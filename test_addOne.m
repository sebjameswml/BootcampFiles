function tests = test_addOne()
%TEST_ADDONE: Test harness for the "addOne" function.

    % This runs all the functions which are local to this file.
    tests = functiontests(localfunctions());
end % test_addOne

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
