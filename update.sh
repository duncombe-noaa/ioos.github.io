
# this script pushes the regenerated website to github

git add -A -v
git commit -m "Update website `date`"

git push
# git subtree pull --prefix=public
git subtree push --prefix=public origin master


