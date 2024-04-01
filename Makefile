TEX=latex
BIB=bibtex
FILE=driver
NW=nw/float.nw nw/prelim.nw nw/environ.nw
NOWEBOPTS=-latex -n

all: doc

code:
	notangle -RTEXT/float-1.miz $(NW) | tr -d '\r' > text/float_1.miz
	notangle -RDICT/float-1.voc $(NW) | tr -d '\r' > dict/float_1.voc

rm_defs:
	-rm *.defs
	touch 001.defs
defs: rm_defs
	nodefs $(NW) > 001.defs
	sort -u 001.defs | cpif 001.defs

extract_text: defs
	noweave $(NOWEBOPTS) -indexfrom 001.defs $(NW) > tex/formalization.tex

doc: extract_text
	$(TEX) $(FILE)
	$(BIB) $(FILE)
	$(TEX) $(FILE)
	$(TEX) $(FILE)
	dvipdfmx $(FILE).dvi
