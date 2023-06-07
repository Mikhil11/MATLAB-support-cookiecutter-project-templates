function generateProject(options)
%   generateProject This is the wrapper function for class createProjectTemplate
%
%   Syntax
%   ------
%   outputPath = generateProject(options)
%
%   Description
%   -----------
%   outputPath = generateProject(options) takes options object as input and
%   creates project template at specified location using cookiecutter

arguments
    options generateProjectOptions
end

if nargin == 1
    % if repository is a folder in local system then git installation is
    % not a requirement
    if options.isFolder
        obj = createProjectTemplate(options,false);
    else
        obj = createProjectTemplate(options,true);
    end
end

testFolderPath = fullfile(options.outputPath,options.templateFields.rootFolderName,'tests');
releaseFolderPath = fullfile(options.outputPath,options.templateFields.rootFolderName,'release');

% Remove test directory if user doesnt ask for it
if ~options.addTests && isfolder(testFolderPath)
    rmdir(testFolderPath,'s');
end

% Remove release directory if user doesnt ask for it
if ~options.createRelease && isfolder(releaseFolderPath)
    rmdir(releaseFolderPath,'s');
end

%The path where template is created is returned as output
%outputPath = obj.outputPath;
end