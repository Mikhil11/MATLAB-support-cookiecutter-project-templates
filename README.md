# Organizing Community Toolbox Structure with MATLAB Project Template

MATLAB Toolbox Template helps users generate their own MATLAB Toolboxes repository using a command line utility tool called [Cookiecutter][1]. The template folder structure and files which are generated as a part of this package is provided within this [directory][2]

* Software usage: [License][3]

## Prerequisites

* Install [python][8] Latest version
* Install [Cookiecutter][9] using command: pip install cookiecutter
* Install [Git Bash][6] and [Git CMD][6] in your system and authorize login for [GitHub CLI][7]

## Getting Started

Generate a MATLAB Toolbox local repository using the following command in Git Bash:
```bash
cookiecutter https://insidelabs-git.mathworks.com/mikhils/community-toolbox-MATLAB-template
```

* This will initiate an interactive setup in the command line. Make sure your answer github username and email details matches with your profile   details
* After creation of local repository, run the file Git_commands.bat using CMD. This will push the local repository to the user's GitHub profile.
* Add the core functionality files in the folder 'code'
* This will trigger github workflow and generate 'test_parameters.txt' file in the test folder
* Add input arguments and expected output to the 'test_parameters.txt' file and commit the changes
* The repo will generate a unit test for your repo and print the results in the report folder
* The new repo is now ready to use. Clone the repository in the local folder
* Generate mltbx file for your repository using the [ToolBox Package][5]
* Import your plugin from within MATLAB using the [MATLAB add-on installation][4]
* Tag a release for your Toolbox (`git tag`)

[1]: https://github.com/cookiecutter
[2]: https://insidelabs-git.mathworks.com/mikhils/community-toolbox-MATLAB-template/-/tree/main/%7B%7B%20cookiecutter.repo_name%20%7D%7D
[3]: https://insidelabs-git.mathworks.com/mikhils/community-toolbox-MATLAB-template/-/blob/main/LICENSE
[4]: https://in.mathworks.com/help/matlab/ref/matlab.addons.install.html
[5]: https://in.mathworks.com/help/matlab/matlab_prog/create-and-share-custom-matlab-toolboxes.html
[6]: https://git-scm.com/downloads
[7]: https://cli.github.com/manual/gh_auth_login
[8]: https://www.python.org/downloads/
[9]: https://pypi.org/project/cookiecutter/
