all: saved-site clean mediumish-theme-jekyll/Gemfile \
	copy_theme delete_existing_posts \
	copy_site_posts copy_site_assets copy_site_config \
       	bundle done

serve: all serve

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

delete_existing_posts:
	rm -rf dist/_posts/

copy_site_posts:
	cp -R *-ss/_posts/ dist/

copy_site_assets:
	cp -R *-ss/assets/ dist/

copy_site_config:
	cp -R *-ss/_config.yml dist/

bundle:
	cd dist/ && bundle

done:
	@echo ; echo "Completed without error"
	@echo "Run the below commands to start serving:"
	@echo "cd dist && jekyll serve --watch"

serve:
	cd dist && jekyll serve --watch

clean:
	rm -rf dist/
