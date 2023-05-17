% Copyright 2023 The MathWorks, Inc.

% Any test normally can be divided in following
% steps:
% 1. Set up - setting up environment for test
% 2. Action - Execute source code which we intend to test
% 3. Verification - Verify output of execution with expected
%                   value

function tests = tMathFunc
% This is a standard function for function based MATLAB tests. Used for
% identifying tests in the file
tests = functiontests(localfunctions);
end

function tAddFunc(testCase)
actSolution = addVariable(1,2);
expSolution = 3;
verifyEqual(testCase,actSolution,expSolution)
end

function tSubtractFunc(testCase)
actSolution = subtractVariable(3,2);
expSolution = 1;
verifyEqual(testCase,actSolution,expSolution)
end
