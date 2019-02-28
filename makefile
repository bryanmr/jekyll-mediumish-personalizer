all: saved-site clean mediumish-theme-jekyll/Gemfile \
	copy_theme delete_non_prod \
	copy_site bundle done

serve: all serve

production: all production

saved-site: *-ss/_posts/
*-ss/_posts/:
	@echo "Expecting to find a directory ending in -ss"
	@echo "Site save should contain: _posts/, _config.yml, and assets/"
	@echo "Run ./configure and point it at your saved site information"
	exit 1

mediumish-theme-jekyll/Gemfile:
	git submodule init
	git submodule update

copy_theme:
	cp -R mediumish-theme-jekyll/ dist/

delete_non_prod:
	rm -rf dist/changelog.md dist/LICENSE.txt dist/README.md dist/_pages/ dist/_posts

copy_site:
	cp -R *-ss/_posts/ dist/
	cp -R *-ss/_pages/ dist/
	cp -R *-ss/assets/ dist/
	cp -R *-ss/_config.yml dist/

bundle:
	cd dist/ && bundle

done:
	@echo ; echo "Completed without error"
	@echo "Run the below commands to start serving:"
	@echo "cd dist && jekyll serve --watch"

serve:
	cd dist && jekyll serve --watch

production:
	cd dist && jekyll build

clean:
	rm -rf dist/
