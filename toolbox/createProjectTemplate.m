classdef createProjectTemplate < handle
%   createProjectTemplate creates project template using cookiecutter python package
%
%   Syntax
%   ------
%   obj = createProjectTemplate(options,gitInstalled)
%
%   Description
%   -----------
%   obj = createProjectTemplate(options,gitInstalled) constructs a default
%   object and generates project template
%
%
%   createProjectTemplate properties:
%      outputPath - Path where project template is created
%      templateFields - Parameters for a cookiecutter template
    

    properties
        templateFields
        outputPath
    end

    methods
        function obj = createProjectTemplate(options,gitInstalled)
            % class constructor
            arguments
                options
                gitInstalled logical = true
            end

            % update default values for fieldnames whose values is a cell array
            % e.g: "license": ["MIT license","BSD license","ISC license"] 
            % then "license": "MIT license"
            obj.updateFieldValues(options.templateFields);

            % Check system requirements
            validSystem = obj.SystemCheck(gitInstalled);
            if validSystem
                % If system requirements are satisfied generate the project
                % template
                obj.generateTemplate(options);
            end
        end             
    end

    methods (Access = private)
         % This function updated fieldvalues if its a cell array
        function updateFieldValues(obj,templateFields)
            fieldNames = fieldnames(templateFields);

            %parse through templateFields to check for cell array            
            for i=1:numel(fieldNames)
                if iscell(templateFields.(fieldNames{i})) && numel(templateFields.(fieldNames{i})) > 1
                    tempCellArray = templateFields.(fieldNames{i});

                    % default value for a given fieldname in case of cell
                    % array is the value at index 1
                    obj.templateFields.(fieldNames{i}) = tempCellArray{1};
                else
                    obj.templateFields.(fieldNames{i}) = templateFields.(fieldNames{i});
                end
            end
        end

        % This function creates the project template
        function generateTemplate(obj,options)
            py.cookiecutter.main.cookiecutter(pyargs('template',options.repoPath,'no_input','True','extra_context',obj.templateFields,'output_dir',options.outputPath));
            obj.outputPath = options.outputPath;           
        end
    end

    methods(Static,Access=private)
        function validSystem = SystemCheck(checkGitInstallation)
            %UNTITLED System check is performed to see whether the required components
            %are installed in the system or not
            
            
            % Check whether git is installed or not
            [status,~] = system('git --version');
            if status ~= 0 && checkGitInstallation
                error("InstallationError:GitNotInstalled",'Could not find Git in the system')
            end
            
            % Check if MATLAB has python set up
            pythonInfo = pyenv;
            if pythonInfo.Version ~= ""
                % Check If cookiecutter python package is installed or not
                [status,~] = system('cookiecutter --version');
                if status ~=0 
                    error("InstallationError:CookiecutterNotInstalled",'Cookiecutter package not installed. Run !pip install cookiecutter to install the lastest version of cookiecutter')
                % check if pyargs is available or not
                elseif ismember(exist('pyargs'),[2,5])                    
                    validSystem = true;
                end
            else
                error("InstallationError:PythonNotInstalled",'Could not find python in the system')
            end
            disp('System check complete.....')
        end
    end
end