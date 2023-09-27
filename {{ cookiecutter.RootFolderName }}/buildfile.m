% BUILDFILE - Build Tool
%
% Usage:
%   buildtool <command> [options]
%
% Commands:
%   test <tests>                  Run unit tests with optional arguments
%                                 - tests: Path to the tests folder (default: context.Plan.RootFolder)
%
%
% Examples:
%   buildtool test("tests")       Run unit tests in the 'tests' folder with default options
%   buildtool test("tests",createTestReport = true)
%                                 Run unit tests in the 'tests' folder and
%                                 generates report
%
% For more information, please refer to the buildtool <a href="https://in.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html">documentation</a> for the build plan and task definitions.

function plan = buildfile
    % BUILDFILE - Create a build plan for tasks

    %   PLAN = BUILDPLAN - This function creates a plan using the buildplan
    %   function and sets the default task and dependencies for the plan.
    %   The plan is returned as an output.
    %
    %
    %   Execution:
    %   To execute the buildfile, open the command line and navigate to the
    %   directory containing the buildfile.m file. Then run the following
    %   command:
    %
    %   >> buildtool
    %
    %   This will execute the buildfile and perform all the tasks.
    
    plan = buildplan(localfunctions);
    
    % Make the "test" task the default task in the plan
    plan.DefaultTasks = "test";
    
    % Make the "release" task dependent on the "check" and "test" tasks
    plan("release").Dependencies = ["check" "test"];
end

    function checkTask(~)
        % CHECKTASK - Identify code issues
        %
        %   CHECKTASK - This function identifies code issues using the codeIssues
        %   function. If any issues are found, an assertion error is raised with
        %   the formatted display text of the issues.
        %
        %
        %   Execution:
        %   This task is automatically executed as part of the build process when
        %   running the buildfile. It can be executed separately from the
        %   command line
        %
        %   >> buildtool check
        %
        %   This will execute only check task of the buildfile

        
        issues = codeIssues;
        issueTable = issues.Issues;
        assert(~contains(string(issueTable.Severity),"error"),formattedDisplayText(issues.Issues(:,["Location" "Severity" "Description"])))
        if contains(string(issueTable.Severity),"warning")
            disp(formattedDisplayText(issues.Issues(:,["Location" "Severity" "Description"])));
        end
    end

    function testTask(~,testFolder,options)
            % TESTTASK - Run unit tests and generate reports
            %
            %   TESTTASK - This function runs unit tests using the runtests function
            %   with specified options. If any test failures occur, an assertion
            %   error is raised.
            %
            %   Syntax:
            %   testTask(~, testFolder, options)
            %
            %   Inputs:
            %   - ~: Unused placeholder for the context object
            %   - testFolder: The folder containing the unit tests (default: "tests")
            %   - options: Additional options for running the tests
            %       - IncludeSubfolders: Logical flag indicating whether to include subfolders (default: true)
            %       - OutputDetail: Level of detail for test output (default: "terse")
            %       - createTestReport: Logical flag indicating whether to create a test report (default: false)
            %
            %   Execution:
            %   To execute the testTask separately, open the command line and navigate to
            %   the directory containing the buildfile.m file. Then run the following
            %   command:
            %
            %       buildtool test
            %
            %   This will execute the testTask and run the unit tests
            %   Note: user can use different options availablein this task
            %   Eg: buildtool test("tests",createTestReport = true)
            %
            %   This executes all the tests within the 'test' folder and
            %   create report inside 'reports' directory
        arguments
            ~
            testFolder string = "tests"
            options.IncludeSubfolders logical = true
            options.OutputDetail string = "terse"
            options.createTestReport logical = false
        end
        
        %Run unit tests
        addpath(genpath('toolbox'))
        results = runtests(testFolder,IncludeSubfolders=options.IncludeSubfolders,OutputDetail=options.OutputDetail);
        assertSuccess(results);
        if options.createTestReport
            generateHTMLReport(results,'reports');
        end
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
        
        % By default, the packaging GUI restricts the name of the getting started
        % guide, so we fix that here.
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
    % process. Just add suffix 'Task' to the function name