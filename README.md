# MATLAB Toolbox Template using Cookiecutter

[Cookiecutter][1] template for creating a [MATLAB Toolbox Template][2]

* Github repository: https://github.com/Mikhil11/cookiecutter-MATLAB-Toolbox-template
* Software usage: [License][3]

## Quickstart

Generate a local Toolbox template repository using command line:

```bash
$ cookiecutter https://github.com/Mikhil11/cookiecutter-MATLAB-Toolbox-template
```

Then:
* Edit the file in the local repository based on requirements
* Add the core functionality files in the folder code
* Tag a release for your Toolbox (`git tag`)
* Generate mltbx file for your repository using the [ToolBox Package][5]
* Import your plugin from within MATLAB using the [MATLAB add-on installation][4]

[1]: https://github.com/cookiecutter/cookiecutter
[2]: https://github.com/Mikhil11/cookiecutter-MATLAB-Toolbox-template
[3]: https://github.com/Mikhil11/cookiecutter-MATLAB-Toolbox-template/blob/main/License.txt
[4]: https://in.mathworks.com/help/matlab/ref/matlab.addons.install.html
[5]: https://in.mathworks.com/help/matlab/matlab_prog/create-and-share-custom-matlab-toolboxes.html
