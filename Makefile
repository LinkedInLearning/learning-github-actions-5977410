README_FILES := $(shell find . -type f -not -path './.git/*' -name 'README.md' -o -name 'WINDOWS.md' -o -name 'MAC_LINUX_DOCKER.md')
DIRECTORIES := $(shell find $(PWD) -type f -name 'README.md' -exec dirname {} \;)

hello:
	@echo "This makefile has the following tasks:"
	@echo "\tlint        - lint README files"
	@echo "\tspellcheck  - spell check README files"
	@echo "\tfooter      - generate footer links for README files"
	@echo "\tpdf         - generate PDFs for README files"
	@echo "\tupdate-titles - update titles in README files"
	@echo "\tclean       - remove backup files"
	@echo "\tall         - run all tasks (except clean)"

#all: footer lint spellcheck
all: clean update-titles footer spellcheck
	@echo "Done."

lint:
	#-@docker pull ghcr.io/managedkaos/summarize-markdown-lint:main
	#-@docker pull davidanson/markdownlint-cli2:v0.13.0
	-@docker run -v $(PWD):/workdir davidanson/markdownlint-cli2:v0.13.0 $(README_FILES) 2>&1 | \
		docker run --interactive ghcr.io/managedkaos/summarize-markdown-lint:main

rawlint:
	-@docker run -v $(PWD):/workdir davidanson/markdownlint-cli2:v0.13.0 $(README_FILES) 2>&1

spellcheck:
	@echo "Spell checking README files..."
	@for file in $(README_FILES); do \
		echo "\t$$file"; \
		aspell check --mode=markdown --lang=en $$file; \
	done

toc:
	@echo "Generating table of contents for README files..."
	-@docker pull ghcr.io/managedkaos/readme-toc-generator:main
	@docker run --rm --volume $(PWD):/data ghcr.io/managedkaos/readme-toc-generator:main

footer:
	@echo "Generating footer links for README files..."
	-@docker pull ghcr.io/managedkaos/readme-footer-generator:main
	@docker run --rm --volume $(PWD):/data ghcr.io/managedkaos/readme-footer-generator:main

pdf: $(DIRECTORIES)

$(DIRECTORIES):
	@echo "Processing directory: $@"
	@cd $@ && pandoc README.md -o $(notdir $@)-README.pdf
	@cd $(PROJECT_HOME)

wordcount:
	@find . -type f -name README.md -exec wc -l {} \; | sort -nr

chapterlist:
	@find . -type f -name README.md | sed 's/\/README.md//' | sed 's/\.\///' | sed '/\./d' | sort

chapterlist-touch:
	@if [ -f CHAPTER_LIST.txt ]; then \
		if fgrep "/0_0" CHAPTER_LIST.txt; then \
			echo "CHAPTER_LIST.txt contains /0_0"; \
			exit 1; \
		fi; \
	fi
	@cat ./CHAPTER_LIST.txt | while read line; do \
		echo "$$line"; \
		mkdir -p $$line; \
		touch $$line/README.md; \
	done

overlay:
	@find . -type f -name README.md | sort | sed 's/^\.\///' | sed 's/\// > /g' | sed 's/ > README.md//'

clean:
	find . -type f -name \*.pdf -not \( -path '*/github-actions-cheat-sheet.pdf' \) -exec rm -vf {} \;
	find . -type f -name \*.bak -exec rm -vf {} \;
	find . -type f -name \*.new -exec rm -vf {} \;
	find . -type d -name .pytest_cache -exec trash {} \;

nuke: clean
	find /tmp/ -type f -name \*.pdf -exec rm -vf {} \;

update-titles:
	@if [ ! -f CHAPTER_LIST.txt ] || [ ! -f CHAPTER_TITLES.txt ]; then \
		echo "Error: CHAPTER_LIST.txt and CHAPTER_TITLES.txt must exist"; \
		exit 1; \
	fi
	@paste -d '|' CHAPTER_LIST.txt CHAPTER_TITLES.txt | while IFS='|' read -r dir title; do \
		if [ -f "$$dir/README.md" ]; then \
			echo "$$dir/README.md: $$title"; \
			# Create a temporary file with the new title \
			echo "# $$title" > "$$dir/README.md.tmp"; \
			# Append the rest of the file (skip the first line if it's a title) \
			if [ -s "$$dir/README.md" ]; then \
				tail -n +2 "$$dir/README.md" >> "$$dir/README.md.tmp" 2>/dev/null || \
				cat "$$dir/README.md" >> "$$dir/README.md.tmp"; \
			fi; \
			# Replace the original file \
			mv "$$dir/README.md.tmp" "$$dir/README.md"; \
		else \
			echo "Warning: $$dir/README.md not found"; \
		fi; \
	done

.PHONY: hello lint spellcheck toc footer pdf countlines chapterlist overlay clean nuke update-titles $(DIRECTORIES)
