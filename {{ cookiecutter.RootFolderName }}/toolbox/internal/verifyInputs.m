function verifyInputs(a, b, functionName)
% VERIFYINPUTS - Verify inputs for addVariable and subtractVariable functions
%
%   verifyInputs(a, b, functionName) verifies the inputs a and b
%   for the specified functionName (either 'addVariable' or 'subtractVariable').
%   It throws an error if the inputs are not valid (not integers or floating-point numbers).
%
%   Inputs:
%       a - First input variable
%       b - Second input variable
%       functionName - Name of the function ('addVariable' or 'subtractVariable')
%
%   Example:
%       verifyInputs(2, 3, 'addVariable')
%
%   See also: ADDVARIABLE, SUBTRACTVARIABLE

    % Verify inputs based on the specified function
    switch functionName
        case 'addVariable'
            % Verify inputs for addVariable function
            isValid = isnumeric(a) && isnumeric(b) && (isinteger(a) || isfloat(a)) && (isinteger(b) || isfloat(b));

        case 'subtractVariable'
            % Verify inputs for subtractVariable function
            isValid = isnumeric(a) && isnumeric(b) && (isinteger(a) || isfloat(a)) && (isinteger(b) || isfloat(b));

        otherwise
            error('Invalid functionName. Please provide either ''addVariable'' or ''subtractVariable''.');
    end

    % Throw an error if inputs are invalid
    if ~isValid
        error('Invalid input arguments. Inputs must be integers or floating-point numbers.');
    end
end
