# Setup



## One time installation:

* Clone this repository
* Run:

      pip3 install mkdocs
      pip3 install mkdocs-material
      pip3 install mkdocs-git-revision-date-localized-plugin
      pip3 install mkdocs-minify-plugin

## Write & Test

* Edit .md files. If you add a new article, add a link to it to mkdocs.yaml
* Run:
    
    mkdocs serve 
    
* View your changes at [localhost:8000](http://localhost:8000)


# deploy

Run:
     mkdocs gh-deploy
     
* view at [docs.run.ai](https://docs.run.ai)

Don't forget to also push the documents to this repository
