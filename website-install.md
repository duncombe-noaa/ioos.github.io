
# About

## IOOS 

## Website generation, installation and updating

The website will be transitioned to Hugo for creation and regeneration, at
least until we decide that Hugo is not the appropriate vehicle to do this.

The website will initially rely on Hugo for creation and deployment.  I will
try to have the top level document appear in both the GitHub `README.md` and
the website's `index.html`.  The way this is accomplished is to sym-link the
README.md to index.md in the content subdirectory. Thus Hugo creates
`index.html` in public, while the same document still appears in the GitHub
repository.  Scripts like `stats.sh` and Windows users need to be aware of the
sym-link so that they preserve it and the relationship between the files.

### Creating the website

There was a Jekyll generated website lurking here. That was removed and a blank
Hugo website was created with the original `README.md`.  The following commands
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

In order to use the `README.md` as an `index.html` page, a sym-link was made.
It works better on GitHub if the README.md is the file and the index.md is the
link. Some care must be taken to ensure Hugo knows that things have changed
when the README.md is modified. 

```
ln -s ../README.md content/index.md 
```

The Hyde theme was cloned in and the relevant subdirectories copied to the
blank site. 

``` 
git clone --recursive https://github.com/spf13/hyde.git themes/hyde 
rsync -auvi themes/hyde/{archetypes,layouts,static} .

```

Now we run Hugo as a server so we can see how things change as we 
edit the layouts and pages to how we want them. 

```
hugo server --theme=hyde --buildDrafts
```



### Regeneration

The following commands should be run to recompile the documentation and
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
# but this usually (sometimes) works by itself. Note that since this is a
# top-level github.io site, the master is the btranch that must be pushed to,
# the gh-pages branch is ignored here.
git subtree push --prefix=public origin master

```

<!-- vi:se nowrap tw=0: -->

