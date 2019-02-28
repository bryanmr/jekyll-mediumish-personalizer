all: saved-site clean \
	copy_theme delete_not_ours \
	copy_site bundle done

serve: all serve

production: all production

saved-site: *-ss/_posts/
*-ss/_posts/:
	@echo "Expecting to find a directory ending in -ss"
	@echo "Site save should contain: _posts/, _config.yml, and assets/"
	@echo "Run ./configure and point it at your saved site information"
	exit 1

copy_theme:
	cp -R *-jekyll/ dist/

delete_not_ours:
	rm -rf dist/changelog.md dist/LICENSE.txt dist/README.md dist/_posts/

copy_site:
	cp -R *-ss/* dist/

bundle:
	cd dist/ && bundle

done:
	@echo ; echo "Completed without error"
	@echo "Run the below commands to start serving:"
	@echo "cd dist && jekyll serve --watch"

serve:
	cd dist && jekyll serve --watch

production:
	cd dist && JEKYLL_ENV=production jekyll build

clean:
	rm -rf dist/
