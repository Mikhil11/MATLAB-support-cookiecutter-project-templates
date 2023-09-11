% testMathFunc - Example MATLAB Unit Test for a Toolbox

% This MATLAB unit test example demonstrates how to use the MATLAB Unit Test
% Framework to test a toolbox. The example includes two test functions: 
% testAddFunc and testSubtractFunc. Each test function follows the typical structure
% of a unit test, including setup, action, and verification steps.

% Usage:
%   - Run the entire test suite by executing the `runtests` command in the
%     MATLAB Command Window.
%   - To run specific test functions, use the `runtests` command followed by
%     the name of the test function(s) you want to execute. For example:
%       runtests testMathFunc/testAddFunc
%       runtests testMathFunc/testSubtractFunc
%   - For running complete test file use:
%       runtests testMathFunc

% Test Functions:
%   1. testAddFunc - Tests the addVariable function.
%      - Sets up the necessary environment for the test.
%      - Executes the addVariable function with input arguments.
%      - Verifies that the output matches the expected solution.

%   2. testSubtractFunc - Tests the subtractVariable function.
%      - Sets up the necessary environment for the test.
%      - Executes the subtractVariable function with input arguments.
%      - Verifies that the output matches the expected solution.

% Note: You can add more test functions to this file as needed.

% Running the Tests:
%   - Change the current directory to the folder where the test file is located.
%   - To run the tests, execute the `runtests` command in the MATLAB Command
%     Window with the appropriate test function(s) or test suite.

% Example:
%   - Run the entire test suite:
%       runtests testMathFunc
%   - Run a specific test function:
%       runtests testMathFunc/testAddFunc

% Remember to modify the input arguments and expected solutions in the test
% functions based on the actual functions you want to test.

function tests = testMathFunc
% This is a standard function for function-based MATLAB tests. Used for
% identifying tests in the file.
tests = functiontests(localfunctions);
end

function testAddFunc(testCase)
% Test function for the addVariable function.
% Sets up the necessary environment, executes the function,
% and verifies the output against the expected solution.

% Set up
% Add any necessary setup steps here

% Action
actSolution = addVariable(1,2);  % Execute the function

% Verification
expSolution = 3;  % Define the expected solution
verifyEqual(testCase, actSolution, expSolution);  % Verify the output
end

function testSubtractFunc(testCase)
% Test function for the subtractVariable function.
% Sets up the necessary environment, executes the function,
% and verifies the output against the expected solution.

% Set up
% Add any necessary setup steps here

% Action
actSolution = subtractVariable(3,2);  % Execute the function

% Verification
expSolution = 1;  % Define the expected solution
verifyEqual(testCase, actSolution, expSolution);  % Verify the output
end