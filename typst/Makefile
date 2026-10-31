.PHONY: build notes figures watch watch-notes clean

build: figures
	mkdir -p build
	typst compile main.typ build/main.pdf

notes: figures
	mkdir -p build
	typst compile notes.typ build/notes.pdf

figures:
	./scripts/export-figures.sh

watch: figures
	mkdir -p build
	typst watch main.typ build/main.pdf

watch-notes: figures
	mkdir -p build
	typst watch notes.typ build/notes.pdf

clean:
	rm -rf build figures/svg/*.svg figures/png/*.png
