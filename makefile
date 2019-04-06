SHELL := /bin/bash

all: all_minus_build build done

all_minus_build: saved-site clean \
        copy_theme delete_not_ours \
        copy_site done

serve: all
	cd dist && jekyll serve --skip-initial-build --watch

production: all_minus_build prod_build nodejs_work
	./helper-scripts/deploy_production

prod_build:
	cd dist && JEKYLL_ENV=production jekyll build


saved-site: *-ss/_posts/
*-ss/_posts/:
	@echo "Expecting to find a directory ending in -ss"
	@echo "Site save should contain: _posts/, _config.yml, and assets/"
	@echo "Run ./configure and point it at your saved site information"
	exit 1

copy_theme:
	cp -R *-jekyll/ dist/

nodejs_work:
	cat dist/_site/search_data.json | node lunr_prebuild/build_index.js > dist/_site/lunr_serialized.json
	cd fetch_comments && ./fetch_comments.sh

delete_not_ours:
	rm -rf -- dist/changelog.md dist/LICENSE.txt dist/README.md dist/_posts/

copy_site:
	cp -R *-ss/* dist/

bundle:
	cd dist/ && bundle

build: dev_build nodejs_work

dev_build:
	cd dist && jekyll build --profile

done:
	@echo ; echo "Completed without error"

clean:
	rm -rf dist/
