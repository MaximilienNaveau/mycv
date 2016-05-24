FILENAME=cv
PDFFILE=$(FILENAME).pdf
TEXFILE=$(FILENAME).tex

SOURCEDIR=./src
REVERSE_SRCDIR=..

OUTPUTDIR=./bin
BUILDDIR=./build

RM:=rm -f
PDFLATEX:= cd $(SOURCEDIR) ; pdflatex --interaction=nonstopmode --output-directory=$(REVERSE_SRCDIR)/$(BUILDDIR) $(TEXFILE) ; cd $(REVERSE_SRCDIR)
LATEX:= cd $(BUILDDIR) ; xelatex ../$(SOURCEDIR)/$(TEXFILE) ; cd ../
BIBTEX:= cd ./build ; bibtex $(FILENAME).aux
BIBTEXREVIEW:= cd ./build ; bibtex $(REVIEWNAME).aux
BEAMERBIBTEX:= cd ./build ; bibtex bu1.aux

all:
	ln -sf ../$(SOURCEDIR)/$(FILENAME).bib ./build/
# 	create a link to the log file for texmaker
	ln -sf ../$(BUILDDIR)/$(FILENAME).log $(SOURCEDIR)/
	$(PDFLATEX)
	$(PDFLATEX)
	$(BIBTEX)
	$(PDFLATEX)
	$(PDFLATEX)
# 	create a link to the log file for texmaker
	ln -sf ../$(BUILDDIR)/$(FILENAME).log $(SOURCEDIR)/
#	copy the results in a binary directory.
	cp $(BUILDDIR)/$(PDFFILE) $(OUTPUTDIR)/$(PDFFILE)

pdf:
	$(PDFLATEX)
#	$(BIBTEX)
	$(PDFLATEX)

latex :
	$(LATEX)

bibtex:
	${BIBTEX}

beamerbitex:
	${BEAMERBIBTEX}

clean:
	$(RM) ./build/*
	$(RM) ./bin/*
#	$(RM) *.dvi *.ps *.log *.out *.aux *.blg *.bbl *.gz *.nav *.snm *.toc $(PDFFILE) $(PSFILE)

# dummy targets
.PHONY: clean
