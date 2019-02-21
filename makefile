all: clean mediumish-theme-jekyll/Gemfile \
	copy_theme delete_existing_posts copy_site_source bundle done

mediumish-theme-jekyll/Gemfile:
	git submodule init
	git submodule update

copy_theme:
	cp -R mediumish-theme-jekyll/ dist/

delete_existing_posts:
	rm -rf dist/_posts/

copy_site_source:
	cp -R *-ss/_posts/ *-ss/assets/ dist/

bundle:
	cd dist/ ; bundle

done:
	@echo ; echo "Completed without error"

clean:
	rm -rf dist/
