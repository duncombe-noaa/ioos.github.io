ioos.github.io
==============

IOOS GitHub pages are the entry point for technical documentation.

# Initial navigation structure
* Projects and Software Development Activities
  * System Integration Test
  * ncSOS
  * i52N and related activities like sensor web harvesters
  * pyoos
  * compliance-checker
  * registry
  * catalog
* Guidelines and specifications
  * Data Provider Guidelines
  * SOS Guidelines
  * netCDF Guidelines
  * ioos-csv-tsv
  * asset identifiers
  * vocabularies
* About  (Not sure about this yet)


# Projects
## System Integration Test

## ncSOS

## i52N and related activities like sensor web harvesters

# Guidelines and specifications
## Data Provider Guidelines
What are the responsiblities of an IOOS Data Provider? This page should be
based on [http://www.ioos.noaa.gov/data/contribute_data.html].

## SOS Guidelines
Includes the following:    

* Overview of SOS activities in IOOS based on Alex's one page summary   
* WSDD   
* Templates   
* Testing/Compliance   

## netCDF and/or opendap guidelines
* See github.com/dpsnowden/netcdf-guidelines for some initial ideas on what
this needs to contain.
* 

## ioos-csv-tsv

## Asset Identifiers 

## Vocabularies

# About

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

In order to use the `README.md` as an `index.html` page, a sym-link was made:

```
mv -i README.md content/index.md
ln -s content/index.md README.md
```

The Hyde theme was cloned in and the relevant subdirectories copied to the
blank site. 

``` 
git clone --recursive https://github.com/spf13/hyde.git themes/hyde 
rsync -nauvi themes/hyde/{archetypes,layouts,static} .

```

Now we run Hugo as a server so we can see how thinkgs change as we 
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
# but this usually (sometimes) works by itself:
git subtree push --prefix=public origin gh-pages

```

<!-- vi:se nowrap tw=0: -->

