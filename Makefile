###############################################################################
#
# 	Makefile for scutthesis
#
# 	Copyright (C) 2021-2021 Jusong Yu,
#   Department of Physics, South China University of Technology.
#
# 	Copyright (C) 2013-2015 Haixing Hu,
#   Department of Computer Science and Technology, Nanjing University.
#
#	Home Page of the Project: https://github.com/unkcpz/scut-thesis
# Project fork and modified from: http://haixing-hu.github.io/nju-thesis/
#
###############################################################################

PACKAGE=scutthesis
BST_FILE=gbt7714-2005.bst
BST_URL=https://raw.githubusercontent.com/Haixing-Hu/GBT7714-2005-BibTeX-Style/master/gbt7714-2005.bst
SOURCES=$(PACKAGE).dtx $(PACKAGE).ins
CLS=$(PACKAGE).cls $(PACKAGE).cfg dtx-style.sty
SAMPLE=sample
SAMPLECONTENTS=$(SAMPLE).tex
SAMPLEBIB=$(SAMPLE).bib
INSTITUTE_LOGO=scutlogo.eps
TEXMFLOCAL=$(shell sh get_texmf_dir.sh)

.PHONY: all clean cls doc sample

all: bst cls doc sample

###### update bst file
bst:  $(BST_FILE)

$(BST_FILE):
	curl $(BST_URL) -o $(BST_FILE)

###### generate cls/cfg
cls:  $(CLS)

$(CLS): $(SOURCES)
	latex $(PACKAGE).ins

###### generate doc

doc: $(PACKAGE).pdf

$(PACKAGE).pdf: $(CLS)
	xelatex $(PACKAGE).dtx
	makeindex -s gind.ist -o $(PACKAGE).ind $(PACKAGE).idx
	xelatex $(PACKAGE).dtx
	xelatex $(PACKAGE).dtx

###### for sample

sample:	 $(SAMPLE).pdf

$(SAMPLE).pdf: $(CLS) $(INSTITUTE_LOGO) $(BST_FILE) $(SAMPLE).tex $(SAMPLEBIB)
	xelatex $(SAMPLE).tex
	bibtex $(SAMPLE)
	xelatex $(SAMPLE).tex
	xelatex $(SAMPLE).tex

###### install

install: $(SOURCE) $(CLS) $(INSTITUTE_LOGO) $(BST_FILE) $(PACKAGE).pdf $(SAMPLE).pdf
	mkdir -p $(TEXMFLOCAL)/tex/latex/scutthesis
	cp -rvf $(SOURCES) $(CLS) $(INSTITUTE_LOGO) $(TEXMFLOCAL)/tex/latex/scutthesis/
	mkdir -p $(TEXMFLOCAL)/doc/latex/scutthesis
	cp -rvf $(PACKAGE).pdf $(SAMPLE).pdf $(TEXMFLOCAL)/doc/latex/scutthesis/
	mkdir -p $(TEXMFLOCAL)/bibtex/bst
	cp -rvf $(BST_FILE) $(TEXMFLOCAL)/bibtex/bst/
	texhash

###### clean

clean:
	-@rm -f \
		*.aux \
		*.bak \
		*.bbl \
		*.blg \
		*.dvi \
		*.glo \
		*.gls \
		*.idx \
		*.ilg \
		*.ind \
		*.ist \
		*.log \
		*.out \
		*.ps \
		*.thm \
		*.toc \
		*.lof \
		*.lot \
		*.loe \
		*.sty \
		*.cfg \
		*.cls \
		*.sty
