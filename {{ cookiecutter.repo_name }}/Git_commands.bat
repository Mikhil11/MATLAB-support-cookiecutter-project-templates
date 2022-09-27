git init -b main
git add . && git commit -m "First commit"
gh repo create {{cookiecutter.repo_name}} --private
git remote add origin https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.repo_name}}.git
git remote -v
git push origin main
