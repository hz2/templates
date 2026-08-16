.PHONY: build notes figures watch watch-notes clean

build: figures
	latexmk main.tex

notes: figures
	latexmk notes.tex

figures:
	./scripts/export-figures.sh

watch: figures
	latexmk -pvc main.tex

watch-notes: figures
	latexmk -pvc notes.tex

clean:
	latexmk -C main.tex
	latexmk -C notes.tex
	rm -rf build figures/pdf/*.pdf figures/png/*.png
