TEMPLATES := templates/base.html templates/header.html templates/navbar.html templates/footer.html
MD := $(shell find content -name '*.md')
HTML := $(patsubst content/%.md,build/%.html,$(MD))

all: $(HTML) resources

build/%.html: content/%.md templates clean
	@echo "Building $@ from $<"
	@mkdir -p $(dir $@)
	pandoc $< --wrap=preserve --template=templates/base.html -o $@

templates: $(TEMPLATES)

resources:
	@test -d resources && mkdir -p build/resources && cp -a resources/* build/resources/ || :

clean:
	rm -rf build

.PHONY: all clean templates resources
