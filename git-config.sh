#!/bin/sh

# This script must run inside git bash (on Windows)

is_git_version_less_than() {
	git_version=$(echo $(git --version)| cut -d' ' -f3)
	major=$(echo $git_version| cut -d'.' -f1| cut -c -1)
	minor=$(echo $git_version| cut -d'.' -f2| cut -c -1)

	if [ $major -lt $1 ]
	then
	    return 1
	fi

	if [ $major -gt $1 ]
	then
	    return 0
	fi

	if [ $minor -lt $2 ]
	then
	    return 1
	fi

	if [ $minor -gt $2 ]
	then
	    return 0
	fi

	return 0
}

echo "Configuration in progress..."

git config --global branch.autosetuprebase always
echo " - Make \"git pull\" on every new branch always use rebase. Use \"git pull --no-rebase\" if you need pull without rebase."

for branch in $(git for-each-ref --format='%(refname)' -- refs/heads/); do git config branch."${branch#refs/heads/}".rebase true; done
echo " - Make \"git pull\" on every existing branch always use rebase."

is_git_version_less_than 1 8
is_old_git_version=$?
if [ $is_old_git_version -eq 1 ]
then
	git config --global push.default upstream
else
	git config --global push.default simple
fi
echo " - Only current branch will be pushed, when doing a git push without specifying a branch."

git config --global merge.ff no
echo " - Prevent fast-forward merge."

if [[ "$COMSPEC" == *cmd.exe ]] #check that it is windows
then
	git config --global core.autocrlf true
	echo " - Convert LF endings into CRLF when you check out code."
else
	git config --global core.autocrlf false
	echo " - Don't convert LF endings into CRLF when you check out code."
fi

git config --global user.name "$1"
echo " - Set username: $1"

git config --global user.email $2
echo " - Set email: $2"

echo "Configuration completed."

# Check git status to ensure that there are no errors after configuration completed.
git_status=$(echo $(git status))