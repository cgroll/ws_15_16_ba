# Adapted from https://github.com/kjhealy/pandoc-templates/blob/master/examples/Makefile
# Thanks to Kieran Healy!

CSL = apsa
CSL = jcsl
CSL = inline_bibliography/chicago-ital-author-bold-title-inline-bibliography
BIB = refs.bib

## specify output files 
FILES = modus_operandi.pdf modus_operandi.html topics.pdf topics.html
OUTDIR = output
OUT := $(addprefix $(OUTDIR)/,$(FILES))

all: $(OUT)

$(OUTDIR)/topics.pdf: src/topics.md Makefile refs.bib
	pandoc -t latex -f markdown --number-sections --filter pandoc-citeproc --csl=pandoc_custom/csl/$(CSL).csl --bibliography=$(BIB) -o $@ $<

$(OUTDIR)/topics.html: src/topics.md Makefile refs.bib
	pandoc -t html -s -f markdown --number-sections --filter pandoc-citeproc --csl=pandoc_custom/csl/$(CSL).csl --bibliography=$(BIB) -o $@ $<

$(OUTDIR)/modus_operandi.pdf: src/modus_operandi.md Makefile
	pandoc -t latex -f markdown -o $@ $<

$(OUTDIR)/modus_operandi.html: src/modus_operandi.md Makefile refs.bib
	pandoc -t html -s -f markdown --number-sections --filter pandoc-citeproc --csl=pandoc_custom/csl/$(CSL).csl --bibliography=$(BIB) -o $@ $<

clean:
	rm -f $(OUTDIR)/*.slides.html $(OUTDIR)/*.pdf

again:
	make clean
	make
