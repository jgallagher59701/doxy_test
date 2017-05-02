
HTML_DOCS=html
DOXYGEN_CONF=doxy.conf

# Docs rules. Targets used to force order with a parallel build.
.PHONY: gh-pages-present clean-gh-pages generate-docs update-gh-pages docs 
gh-pages-present:
	@git branch --list | grep gh-pages

clean-gh-pages: gh-pages-present
	git checkout gh-pages
	git rm -rf ${HTML_DOCS}/*
	git commit -m "Removed old docs"

generate-docs: clean-gh-pages
	git checkout master
	doxygen ${DOXYGEN_CONF}

update-gh-pages: generate-docs
	git checkout gh-pages
	git add ${HTML_DOCS}
	git commit -m "Added new docs"
	git push

docs: update-gh-pages
	@echo "Documentation updated"
