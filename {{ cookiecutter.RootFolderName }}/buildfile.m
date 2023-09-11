function plan = buildfile
    % Create a plan from the task functions
    plan = buildplan(localfunctions);
    
    % Make the "test" task the default task in the plan
    plan.DefaultTasks = "test";

    % Make the "release" task dependent on the "check" and "test" tasks
    plan("release").Dependencies = ["check" "test"];
end
    
    function checkTask(~)
        % Identify code issues
        issues = codeIssues;
        assert(isempty(issues.Issues),formattedDisplayText( ...
            issues.Issues(:,["Location" "Severity" "Description"])))
    end
    
    function testTask(~)
        % Run unit tests
        results = runtests(IncludeSubfolders=true,OutputDetail="terse");
        assertSuccess(results);
    end
    
    function releaseTask(~)
        releaseFolderName = "release";
        % Create a release and put it in the release directory
        opts = matlab.addons.toolbox.ToolboxOptions("toolboxPackaging.prj");

        %update toolbox name
        opts.ToolboxName = "{{ cookiecutter.RootFolderName }}";

        %update Toolbox description
        opts.Description = "{{ cookiecutter.ProjectDescription }}";

        %update Toolbox version
        opts.ToolboxVersion = "{{ cookiecutter.ToolboxVersion }}";

        % By default, the packaging GUI restricts the name of the getting started guide, so we fix that here.
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
        matlab.addons.toolbox.packageToolbox(opts);
    end
    
