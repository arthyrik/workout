Steps for windows users to configure local git:

1) Open Git Bash. Usually it is located inside git directory "c:/Program Files (x86)/git/Git Bash.vbs".

2) Navigate to your repository using the change directory (cd) command.
Example: cd d:/repositories/workout
NOTE: use only forward slashes in path to repository

3) Run configuration script. Replace [FirstName LastName] and [email] with your data:
git-config.sh "[FirstName LastName]" [email] 

For example:
git-config.sh "arthyrik" arthyrik@tut.by

4) Ensure that configuration completed (you will see message like "Configuration completed.") and there are no error messages.
