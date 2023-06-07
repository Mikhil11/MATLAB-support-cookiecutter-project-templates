classdef generateProjectOptions < handle

%   generateProjectOptions Specify parameters used to generate project template
%
%   Syntax
%   ------
%   options = generateProjectOptions()
%   options = generateProjectOptions(repoPath)
%
%   Description
%   -----------
%   options = generateProjectOptions() constructs a default object with
%   parameters for defining a MathWorks recommended project template.
%
%   options = generateProjectOptions(repoPath) constructs a default object with
%   parameters for defining a user created project template.
%
%   generateProjectOptions properties:
%      outputPath - Path where project is created
%      templateFields - Parameters for a cookiecutter template



    properties
        outputPath
        templateFields
        addTests logical = false
        createRelease logical = false
    end

    properties (SetAccess = immutable)
        %repoPath - Path to cookiecutter template folder/repository
        %isFolder - whether the input is a folder or a url (logical)
        repoPath
        isFolder
    end

    methods
        function obj = generateProjectOptions(repoPath)
            % The class constructor return the class object as output

            arguments
                repoPath string = "https://github.com/Mikhil11/MATLAB-support-cookiecutter-project-templates"
            end

            
            %Remove .git and file separator, if its added at the end
            %of url
            checkGitStr = split(repoPath,'.');
            if strcmp(checkGitStr{end},'git')
                repoPath = erase(repoPath,'.git');
            elseif strcmp(repoPath(end),'/')
                repoPath = repoPath(1:end-1);
            end

            % Assign updated input path to class object property
            obj.repoPath = repoPath;

            % Assign current directory as default value to class object property
            % outputPath
            obj.outputPath = string(pwd());

            %First Case: Check whether the input path is a folder or not.
            
            if isfolder(obj.repoPath)
                % Access project template parameters from cookiecutter.json
                % file in local system
                obj.templateFields = obj.getTemplateFields();
                obj.isFolder = true;
                return
            else
                % check whether the repository Url exists or not using send
                % request function
                validUrl = obj.verifyUrl(repoPath,'showError');
                obj.isFolder = false;
            end
            

            %Second case: Cookiecutter template is a subdirectory of a repository
            if validUrl
                % Get path of json file inside the repository
                cookiecutterPath = strcat(repoPath,'/cookiecutter.json');
                
                % check whether the Json file Url is valid or not
                fileExists = obj.verifyUrl(cookiecutterPath,'hideError');
                if fileExists
                    % convert file Url to Raw url and get project template
                    % parameters from cookiecutter.json file
                    obj.getFieldsfromRawUrl(cookiecutterPath);
                    return
                end
            end

            % Third case: Repository itself is a cookiecutter template
            if validUrl
                % identify the hosting site of the repository from the URL
                siteName = obj.getServerUrl();

                % Update the URL based on hosting site and access Raw url
                % to get project template parameters from cookiecutter.json file
                obj.getFieldsFromUrl(siteName);
            end
        end
    end

    % Only class constructor is public rest of the functions are
    % defined under private method
    methods(Access = private)
        %reads cookiecutter.json file from cookiecutter template in the
        %local system
        function templateFields = getTemplateFields(obj)
            jsonFile = fullfile(obj.repoPath,"cookiecutter.json");
            if isfile(jsonFile)
                str = fileread(jsonFile);
                templateFields = jsondecode(str);
            else
                error("Invalid input argument of type 'string'. Input must be a valid cookiecutter (project template).");
            end
        end

         % This function updates the URL to access the raw file directly
        function getFieldsfromRawUrl(obj,Url)

            % split URL to identify characters 'tree' or 'blob'
            splitURL = split(Url,'/');
            if any(strcmp('tree',splitURL)) || any(strcmp('blob',splitURL))
                options = weboptions("ContentType","text");

                % Replace character 'tree' or 'blob' with 'raw' to get raw
                % file URL
                updatedURL = strrep(splitURL,'tree','raw');
                updatedURL = strrep(updatedURL,'blob','raw');

                % Rejoin splitUrl array to get raw file URL
                updatedURL = cellfun(@(c)[c '/'],updatedURL,'uni',false);
                updatedURL = strjoin(updatedURL);
                updatedURL = erase(updatedURL,' ');
                
                %Read raw file directly using webread
                try
                    str = webread(updatedURL,options);
                    obj.templateFields = jsondecode(str);
                    return
                catch
                    error("Invalid input argument of type 'string'. Input must be a valid cookiecutter (project template).");
                end
            end
        end

        

        %Find which website repoPath URL belongs to
        function siteName = getServerUrl(obj)

            % Hosting site supported by this package
            hostingSite = {'github','gitlab','insidelabs-git'};
            splitUrl = split(obj.repoPath,{'/','.'});
            
            % Identify hosting site from splitUrl array
            for i = 1:numel(hostingSite)
                if any(strcmp(hostingSite{i},splitUrl))
                    siteName = hostingSite{i};
                    break
                end
                if i == 3
                    error("hostingSite:NotSupported")
                end
            end
        end

        %If repository itself is a cookiecutter template update the URL
        function getFieldsFromUrl(obj,siteName)
          
            %split the URL and identify characters 'main' or 'master'
            splitURL = split(obj.repoPath,'/');
            if ~any(strcmp('main',splitURL)) && ~any(strcmp('master',splitURL))
                options = weboptions("ContentType","text");

                % update URL based on hosting site and the branch name
                if strcmp('github',siteName)
                    jsonUrl = {'/raw/main/cookiecutter.json','/raw/master/cookiecutter.json'};
                elseif any(strcmp({'gitlab','insidelabs-git'},siteName))
                    jsonUrl = {'/-/raw/main/cookiecutter.json','/-/raw/master/cookiecutter.json'};
                end
            end

            % Parse through jsonUrl array and add it to repoUrl
            for i=1:numel(jsonUrl)
                newStr = strcat(obj.repoPath,jsonUrl{i});
                try
                    % Check if the updated Url exists or not
                    str = webread(newStr,options);
                    obj.templateFields = jsondecode(str);
                    return
                catch
                    continue;
                end                    
            end
            error("Invalid input argument of type 'string'. Input must be a valid cookiecutter (project template).");
        end        
    end

    methods(Static,Access = private)

        %Uses send request function to verify the existence of the given URL
        function validUrl = verifyUrl(repoUrl,option)
            request = matlab.net.http.RequestMessage;
            url = matlab.net.URI(repoUrl);
            validUrl = false;
            try
                response = send(request,url);
                if strcmp(response.StatusCode,'OK')
                    validUrl = true;
                    return
                end
            catch
            end
            if strcmp('showError',option) && ~validUrl
                error("Invalid input argument of type 'string'. Input must be a valid cookiecutter (project template).")
            end
        end       
    end
end