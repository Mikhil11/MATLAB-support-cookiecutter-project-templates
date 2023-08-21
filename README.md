# MATLAB Support for Cookiecutter project templates (Work in progress)..

[![View <File Exchange Title> on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/####-file-exchange-title) 

MATLAB Toolbox Template helps users generate their own MATLAB&reg; Toolboxes repository using a command line utility tool called [Cookiecutter][1]. The template folder structure and files which are generated as a part of this package is provided within the directory '{{cookiecutter.rootFolderName}}'

## Setup  

* Install [MATLAB][2] 2019b or newer versions

* Install [Python&trade;][8] Latest version 

* Install [Cookiecutter][9] using command: pip install cookiecutter 

* Install [Git Bash][6] in your system  

## Installation 
### Via Add-on Explorer
  * Launch MATLAB and download Project Template tool from Add-On Explorer in MATLAB&reg;

### Alternate method: Download Repository
  * Download the repository using the folllowing git command:

    `git clone https://github.com/mathworks/MATLAB-support-cookiecutter-project-templates.git`
  
  * Open the root folder of the repository in MATLAB.
  * Add folder templateToolbox to the MATLAB [path][10]


## Getting Started
 * Create options object using generateProjectOptions function.

```matlab
  
  options = generateProjectOptions();
  %% OR %%
  options = generateProjectOptions(GitRepositoryUrl);
  
```
* The options object defines the interface which helps user to modify a given project template.

```matlab
   >> options = 
     
       generateProjectOptions with properties:
     
             outputPath: 'projectFolderPath'
         templateFields: [1×1 struct]
               addTests: 0
               repoPath: "https://github.com/mathworks/MATLAB-support-cookiecutter-project-templates"
               isFolder: 0
```

* The parameters required to define a project is declared in the fieldname 'templateFields' of options object.

```matlab
   >> options.templateFields
   
     struct with fields:
   
             userFullName: 'UserFullName'
                userEmail: 'UserEmailID'
           githubUserName: 'GitUserName'
           rootFolderName: 'MATLABTemplate'
           repositoryName: 'MATLABTemplate'
       projectDescription: 'This project helps open source community in getting started with toolbox development activity using MATLAB environment'
           toolboxVersion: '0.0.1'
              licenseType: ["MIT license", "BSD license", "ISC license", "Apache Software License 2.0", "GNU General Public License v3", "Not open source"]

```

 ## License 

<!--- Make sure you have a License.txt within your Repo ---> 

The license is available in the [LICENSE.md][3] file within this repository

 
## Community Support 

[MATLAB Central](https://www.mathworks.com/matlabcentral) 

Copyright 2023 The MathWorks, Inc. 


[1]: https://github.com/cookiecutter/cookiecutter 

[2]: https://in.mathworks.com/help/install/install-products.html 

[3]: https://github.com/mathworks/MATLAB-Support-for-Cookiecutter-Project-Templates/-/blob/main/LICENSE 

[4]: https://in.mathworks.com/help/matlab/ref/matlab.addons.install.html 

[5]: https://in.mathworks.com/help/matlab/matlab_prog/create-and-share-custom-matlab-toolboxes.html 

[6]: https://git-scm.com/downloads 

[8]: https://www.python.org/downloads/ 

[9]: https://pypi.org/project/cookiecutter/

[10]: https://in.mathworks.com/help/matlab/ref/addpath.html#btpdojo-1
