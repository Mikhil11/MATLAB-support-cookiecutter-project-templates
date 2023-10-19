% BUILDFILE - Build Tool
%
% Usage:
%   buildtool <command> [options]
%
% Commands:
%   test <tests>                  Run unit tests with optional arguments
%                                 - tests: Path to the tests folder (default: "tests")
%
%   check                         Identify code issues
%
%   release                       Create a release and package the toolbox
%
% Examples:
%   buildtool test("tests")       Run unit tests in the 'tests' folder
%   buildtool check               Identify code issues
%   buildtool release             Create a release and package the toolbox
%
% For more information, please refer to the buildtool <a href="https://in.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html">documentation</a> for the build plan and task definitions.

function plan = buildfile
    % BUILDFILE - Create a build plan for tasks
    %
    %   The buildfile script is used to define a build plan for your project. It contains task functions that define the actions
    %   to be performed during the build process. Each task represents a specific unit of work, such as running tests or
    %   identifying code issues.
    %
    %   Usage:
    %       To execute the buildfile, open the command line and navigate to the directory containing the buildfile.m file. Then
    %       run the following command:
    %
    %           buildtool
    %
    %       This will execute the buildfile and perform all the tasks defined in the build plan.
    %
    %   Tasks:
    %       - check: Identify code issues
    %       - test: Run unit tests
    %       - release: Create a release and package the toolbox
    %
    %   Example:
    %       buildtool test("tests")
    %       buildtool check
    %       buildtool release
    %
    %   See also: buildtool
    
    plan = buildplan(localfunctions);
    
    % Make the "test" task the default task in the plan
    plan.DefaultTasks = "test";
    
    % Make the "release" task dependent on the "check" and "test" tasks
    plan("release").Dependencies = ["check" "test"];
end

    function checkTask(~)
        % CHECKTASK - Identify code issues
        %
        %   This task identifies code issues using the codeIssues function. If any issues are found, an assertion error is raised
        %   with the formatted display text of the issues. If there are warnings, they are displayed on the console.
        %
        %   Execution:
        %   To execute only the check task, open the command line and navigate to the directory containing the buildfile.m file.
        %   Then run the following command:
        %
        %       buildtool check
        %
        %   This will execute the check task and identify code issues.
        
        issues = codeIssues("toolbox",IncludeSubfolders=true);
        issueTable = issues.Issues;
        if ~isempty(issueTable)
            assert(~any(contains(string(issueTable.Severity),"error")),formattedDisplayText(issues.Issues(:,["Location" "Severity" "Description"])))
            if contains(string(issueTable.Severity),"warning")
                disp(formattedDisplayText(issues.Issues(:,["Location" "Severity" "Description"])));
            end
        end
    end

    function testTask(~,testFolder)
            % TESTTASK - Run unit tests
            %
            %   TESTTASK - This function runs unit tests using the runtests function
            %   for a specified test folder
            %
            %   Syntax:
            %   testTask(~, testFolder)
            %
            %   Inputs:
            %   - ~: Unused placeholder for the context object
            %   - testFolder: The folder containing the unit tests (default: "tests")
            %
            %   Execution:
            %   To execute the testTask separately, open the command line and navigate to
            %   the directory containing the buildfile.m file. Then run the following
            %   command:
            %
            %       buildtool test
            %
            %   This will execute the testTask and run the unit tests
            %   Eg: buildtool test("tests")
            %
            %   This executes all the tests within the 'test' folder

        arguments
            ~
            testFolder string = "tests"
        end
        
        %Run unit tests
        addpath(genpath('toolbox'))
        results = runtests(testFolder);
        assertSuccess(results);
    end

    function releaseTask(~)
        %   RELEASETASK - This function creates a release and packages the toolbox
        %   using the matlab.addons.toolbox.packageToolbox function. The toolbox
        %   options are customized with specific values for ToolboxName,
        %   Description, ToolboxVersion, and ToolboxGettingStartedGuide. The
        %   packaged toolbox is saved in the "release" directory as an MLTBX file.
        %
        %
        %   Execution:
        %   To execute the releaseTask separately, open the command line and navigate
        %   to the directory containing the buildfile.m file. Then run the following
        %   command:
        %
        %       buildtool release
        %
        %   This will execute the releaseTask and create a release of the
        %   toolbox inside release directory
        
        releaseFolderName = "release";
        
        % Create toolbox options
        opts = matlab.addons.toolbox.ToolboxOptions("toolboxPackaging.prj");
        
        % Update toolbox name
        opts.ToolboxName = "{{ cookiecutter.RepositoryName }}";
        
        % Update toolbox description
        opts.Description = "{{ cookiecutter.ProjectDescription }}";
        
        % Update toolbox version
        opts.ToolboxVersion = "{{ cookiecutter.ToolboxVersion }}";
        
        % Include gettingStarted guide in the packaging process
        opts.ToolboxGettingStartedGuide = fullfile("toolbox", "gettingStarted.mlx");
        
        % GitHub releases don't allow spaces, so replace spaces with underscores
        mltbxFileName = strrep(opts.ToolboxName," ","_") + ".mltbx";
        opts.OutputFile = fullfile(releaseFolderName,mltbxFileName);
        
        %opts.SupportedPlatforms.Win64 = true;
        %opts.SupportedPlatforms.Maci64 = false;
        %opts.SupportedPlatforms.Glnxa64 = true;
        %opts.SupportedPlatforms.MatlabOnline = true;
        %opts.MinimumMatlabRelease = "R2019b";
        %opts.MaximumMatlabRelease = "";
        
        % Create the release directory, if needed
        if ~exist(releaseFolderName,"dir")
            mkdir(releaseFolderName)
        end
        
        % Package the toolbox
        matlab.addons.toolbox.packageToolbox(opts);
    end
    % Note : The user can add custom functions which can be part of build
    % process. Add suffix 'Task' to the custom function name
