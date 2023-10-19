# MATLAB Support for Cookiecutter project templates

[![View <File Exchange Title> on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/####-file-exchange-title) 
 
The MATLAB Project Template tool is a good resource for anyone starting their own MATLAB® Toolbox development. It provides a convenient command line utility called [Cookiecutter][1] that helps you quickly set up your project. Forget about the hassle of creating the folder structure and necessary files from scratch – this tool generates them for you!


Inside the '{{cookiecutter.RootFolderName}}' directory, you'll find the complete project template. It follows MathWorks' recommended [toolbox design](https://github.com/mathworks/toolboxdesign), so you can rest assured that you're building your toolbox using best practices.

Why waste time reinventing the wheel? With the MATLAB Project Template tool, you'll save valuable time and effort, allowing you to focus on what really matters – developing your MATLAB Toolbox. Give it a try and experience the ease and efficiency it brings to your toolbox development process.



## Setup  

* Install [MATLAB][2] 2019b or newer versions

* Install [Python&trade;][8] Latest version 

* Install [Cookiecutter][9] using command: pip install cookiecutter 

* Install [Git Bash][6] in your system  

## Installation 
### Via Add-on Explorer
  * Launch MATLAB and add MATLAB Project Template tool from Add-On Explorer

### Alternate method: Download Repository
  * Download the repository using the folllowing git command:

    `git clone https://github.com/mathworks/MATLAB-support-cookiecutter-project-templates.git`
  
  * Open the root folder of the repository in MATLAB.
  * Add folder projectTemplateToolbox to the MATLAB [path][10]



## Getting Started
 
 * Open MATLAB and follow the steps mentioned below to create a project template using MathWorks recommended design
 1. Create options object using generateProjectOptions function.

```matlab
  
   >> options = generateProject();

  
```
2. The options object defines the interface which helps user to modify a given project template.

```matlab
   >> options = 
     
       projectOptions with properties:

            OutputPath: "C:\Users\mikhils\OneDrive - MathWorks\Desktop\outputPath"
              AddTests: 0
         IsUserDefined: 0
        RepositoryPath: "https://github.com/Mikhil11/MATLAB-support-cookiecutter-project-templates"
              IsFolder: 0
          UserFullName: "Enter full name of the user"
             UserEmail: "Enter user email ID"
           LicenseType: [6×1 string]
        ToolboxVersion: "0.0.1"
    ProjectDescription: "This project helps open source community in getting started with toolbox development activity using MATLAB environment"
        RepositoryName: "Demo Toolbox for Math operations"
        RootFolderName: "DemoToolbox"
        GithubUsername: "Enter github user ID"

```

3. The parameters required to define a project is declared in the options object.

```matlab
   >> options.LicenseType
   
     6×1 string array

    "MIT license"
    "BSD license"
    "ISC license"
    "Apache Software license 2.0"
    "GNU General Public license v3"
    "other"

```
4. Update the parameters based on the users requirements and update the local folder path where user wants to create the project.The default output path is the location at which the generateProjectOptions function is executed.

```matlab

   >> options.RootFolderName = 'ExampleToolbox'
   >> options.ProjectDescription = 'An Example toolbox to demonstrate how user can get started in toolbox development activities'
   >> options.OutputPath = 'Path_where_project_is_created'
```
5. In last step pass the options object to generateProject function.

```matlab
   >> generateProject(options)
```
6. It will perform a system check to confirm installation of cookiecutter python package and finally create the project template
 

* The user can create their own [cookiecutter template](https://cookiecutter.readthedocs.io/en/1.7.2/first_steps.html) in a new Github repository.
* Pass the Github repository WebUrl as an argument to generateProjectOptions function. The Web URL should end with '.git'.
```matlab
  
   >> options = generateProject(GitRepositoryWebUrl);
  
```
* Follow steps from 2 to 5 as mentioned above to create the project using any other cookiecutter template. The custom fields are defined 
  inside the variable options.TemplateFields for any other templates


## License 

<!--- Make sure you have a License.txt within your Repo ---> 

The license is available in the [license.txt][3] file within this repository

 
## Community Support 

[MATLAB Central](https://www.mathworks.com/matlabcentral) 

Copyright 2023 The MathWorks, Inc. 


[1]: https://github.com/cookiecutter/cookiecutter 

[2]: https://in.mathworks.com/help/install/install-products.html 

[3]: https://github.com/mathworks/MATLAB-Support-for-Cookiecutter-Project-Templates/-/blob/main/license.txt 

[4]: https://in.mathworks.com/help/matlab/ref/matlab.addons.install.html 

[5]: https://in.mathworks.com/help/matlab/matlab_prog/create-and-share-custom-matlab-toolboxes.html 

[6]: https://git-scm.com/downloads 

[8]: https://www.python.org/downloads/ 

[9]: https://pypi.org/project/cookiecutter/

[10]: https://in.mathworks.com/help/matlab/ref/addpath.html#btpdojo-1
