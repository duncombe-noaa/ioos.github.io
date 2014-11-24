
# About

## IOOS 

Some explanation of IOOS might be nice?


## Website generation, installation and updating

The website will be transitioned to
[Hugo](http://gohugo.io/overview/introduction) for creation and regeneration,
at least until we decide that Hugo is not the appropriate vehicle to do this.
Hugo is written in [go programming language](https://golang.org/). It helps
with modifying the chrome and template pages to understand the go syntax.  Hugo
documentation is sparse at best. Close and careful reading is required. Also
Hugo community appears to be small; not much shows up when searching on google
for help. This may change, if the website builder gains popularity.


The website will initially rely on Hugo for creation and deployment.  The top
level document appears in both the GitHub `README.md` and the website's
`index.html`.  This is accomplished is by symlinking `README.md` to
`index.md` in the `content/` subdirectory that Hugo expects. Thus Hugo creates
`index.html` in `public/`, while the same document still appears in the GitHub
repository.  The generation scripts (`generation.sh` and `update.sh`) and
Windows users need to be aware of the symlink so that they preserve it and the
relationship between the files. 

### Summary 

Checkout the `new-website`  branch of the repository, change the layouts,
templates, chrome, and markdown files as required. Regenerate the website with
Hugo, the results will end up in `public/`. Commit and push the changes to the
`new-website` branch on github, then `git subtree push` the `public/`
subdirectory to the `master` branch in the repository on github.

### Creating the website

Initially this website was generated   by Jekyll. That was removed and a blank
Hugo website was created with the original `README.md`.  The following commands
were used to 
do this, and preserve the repository history and information in
`ioos.github.io/.git` 

```
mv -i ioos.github.io/README.md
rm -rf ioos.github.io/* 
cd ioos.github.io/
mkdir {archetypes,content,layouts,static}
(  echo 'baseurl = "http://ioos.github.io"' 
   echo 'languageCode = "en-us"'
   ) > config.toml
```

In order to use the `README.md` as an `index.html` page, a symlink was made.
It works better on GitHub if the `README.md` is the file and `index.md` is the
link. Some care must be taken to ensure Hugo knows that things have changed
when any of these links are modified. To do this we touch an empty marker file,
Hugo thinks the contents tree has changed (it has, but not in a way Hugo
otherwise recognizes), and rebuilds the website.

```
ln -s ../README.md content/index.md 
```

The Hyde theme was cloned in and the relevant subdirectories copied to the
blank site. 

``` 
git clone --recursive https://github.com/spf13/hyde.git themes/hyde 
rsync -auvi themes/hyde/{archetypes,layouts,static} .

```

Hugo can be run as a server to see how things change as 
the layouts and pages are edited.

```
hugo server --theme=hyde --buildDrafts
```


### Regeneration

The following commands could be run to recompile the documentation and
update the website after changes have been made. 

```

# run hugo to build the website
hugo

# add and commit everything that changed
git add -A
git commit -m "Update website `date`" 
git push

# you may need to synchronize the remote and local gh-pages branches, in
# which case this may be required (origin is the appropriate remote
# repository):
# git subtree pull --prefix=public origin gh-pages
#
# but this usually (sometimes) works by itself. Of course, it is very important
# to note that since this is a top-level github.io site, the master is the
# branch that must be pushed to, the gh-pages branch is ignored in this
# context.

git subtree push --prefix=public origin master

```

If you run into trouble remember that branch `master` is displayed as the
website.  As a failsafe everything in `master` can be deleted, and everything
in subdirectory `public/` in the `new-website` branch can be copied into the
`master` branch. Et voila. 


<!--
	The following commands from history were the first to successfully push
the subtree to the remote branch to publish the website. Might be useful to
know what they were, so retain them here, until merge them in.


 2840  ./generate.sh 
 2841  ./update.sh 
 2844  git pull origin gh-pages:gh-pages
 2845  git subtree push --prefix=public origin gh-pages
 2846  git subtree split -P public -b gh-pages
 2848  git checkout gh-pages
 2853  git checkout new-website
 2854  git branch -d gh-pages
 2855  git push origin :gh-pages
 2858  rm -rf public/
 2861  git rm -r public
 2863  git commit -m "Clearing public for gh-pages"
 2864  git subtree add --prefix public origin gh-pages --squash
 2866  git checkout -b gh-pages 
 2869  git checkout new-website
 2871  hugo
 2872  ./generate.sh 
 2873  ./update.sh 
 2874  git subtree split -P public -b gh-pages

-->

<!-- vi:se nowrap tw=0: -->

