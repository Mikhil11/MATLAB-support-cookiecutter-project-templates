# {{ cookiecutter.rootFolderName }} 
 

{{ cookiecutter.project_short_description }} 

 
 

## Description 

* Explain in detail the features and capabilities of the toolbox for its users.Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with 

 
 

## Prerequisites 

* This section contains all the requirements which should be fullfilled before installing the Toolbox 

 
 

## Installation 

* Clone `{{ cookiecutter.rootFolderName }}` to the local folder using the below command: 

 
 

    $ git clone https://github.com/{{ cookiecutter.github_username }}/{{ cookiecutter.rootFolderName }}.git 

     

* Generate mltbx file for your repository using the [ToolBox Package][5] 

* Import your plugin from within MATLAB using the [MATLAB add-on installation][4] 

 
 
 

## Getting Started 

In this section provide a brief description about the demo toolbox and how it helps users to solve their problem

Contents
Requirements
Installation
How to use the Toolbox functions
How to analyse and visualize the results (If any)

Requirements:
MATLAB
3rd Party Software
Demo Toolbox

Installation:
In order to install the toolbox please follow the below steps:
A compatible version of MATLAB for the toolbox
Provide location of MLTBX or source file
Install any third party software required for the Toolbox (if any)

How to use the toolbox functions:
%% Provide descriotion about the toolbox function and provide an example for it
x = 2;
y = 3;
a =  addVariable(x,y);
disp(a)
b = subtractVariable(x,y);
disp(b)

How to analyse and visualize the results (If any):
% Use MATLAB plot function to visualize data
x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y)
 
 

## Acknowledgement 

* This package was created with [Cookiecutter](https://github.com/cookiecutter) and the [community-toolbox-MATLAB-template](https://github.com/mathworks/community-toolbox-MATLAB-template) 

 
 

[4]: https://in.mathworks.com/help/matlab/ref/matlab.addons.install.html 

[5]: https://in.mathworks.com/help/matlab/matlab_prog/create-and-share-custom-matlab-toolboxes.html 
