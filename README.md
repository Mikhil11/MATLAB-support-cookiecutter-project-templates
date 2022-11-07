# MATLAB Toolbox Template using Cookiecutter

[Cookiecutter][1] template for creating a [MATLAB Toolbox Template][2]

* Github repository: https://github.com/Mikhil11/cookiecutter-MATLAB-Toolbox-template
* Software usage: [License][3]

## Getting Started

* Install python Latest version
* Install Cookiecutter using pip command: pip install cookiecutter
* Install Git Bash and Git CMD in your system and authorize login for GitHub CLI

Generate a MATLAB Toolbox template local repository using command line:

```bash
$ cookiecutter https://github.com/Mikhil11/cookiecutter-MATLAB-Toolbox-template
```

Then:
* Add the core functionality files in the folder code
* Push the template to a new repository in your profile
* This will trigger github workflow and generate 'test_parameters.txt' file in the test folder
* Add input arguments and expected output to the 'test_parameters.txt' file and commit the changes
* The repo will generate a unit test for your repo and print the results in the report folder
* The new repo is now ready to use. Clone the repository in the local folder
* Generate mltbx file for your repository using the [ToolBox Package][5]
* Import your plugin from within MATLAB using the [MATLAB add-on installation][4]
* Upload for updated local repository to GitHub
* Tag a release for your Toolbox (`git tag`)

[1]: https://github.com/cookiecutter
[2]: https://github.com/Mikhil11/cookiecutter-MATLAB-Toolbox-template
[3]: https://github.com/Mikhil11/cookiecutter-MATLAB-Toolbox-template/blob/main/License.txt
[4]: https://in.mathworks.com/help/matlab/ref/matlab.addons.install.html
[5]: https://in.mathworks.com/help/matlab/matlab_prog/create-and-share-custom-matlab-toolboxes.html
