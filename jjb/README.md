Sample usage:

```sh
./make-venv.sh
source ~/.venvs/jjb/bin/activate
install -Dm600 jenkins_jobs.ini ~/.config/jenkins_jobs/jenkins_jobs.ini
vim ~/.config/jenkins_jobs/jenkins_jobs.ini
jenkins-jobs test "$some_dir"
jenkins-jobs update "$some_dir"
```
