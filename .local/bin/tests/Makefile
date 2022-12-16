# Automatic Makefile for generating notes

# Commands
PANDOC := pandoc
LATEXMK := latexmk
ENGINE := ${LATEXMK}
PDFLATEX := pdflatex --shell-escape -synctex=1 -interaction=nonstopmode
PDFTOPS := pdftops -eps
PYTHON := python
MATLAB = $(shell which matlab 2> /dev/null)
MATLAB := $(if $(MATLAB), $(MATLAB), octave)

SCRIPTS_DIR := ${HOME}/.local/bin
GPP := gpp -x -U "!" "" "(" "," ")" "(" ")" "" "" -I $(shell pwd)

# Automatically generate list of src files
ifneq ("$(wildcard .exclude_dirs)", "")
	EXCLUDE_DIRS := `cat .exclude_dirs`
else
	EXCLUDE_DIRS := ""
endif
SRC := $(subst ./,,$(shell getallsrc -m 2 -e ${EXCLUDE_DIRS}))
PANDOC_TEMPLATE_DIR := ${HOME}/Templates/pandoc-templates

BLDDIR := .make
DISTDIR := dist
FIGFILEDIR := fig.files
FIGDIR := fig
DEST=
DIST_TEX=

# Automatically create build recipes for these files

RULE_FILES := $(addprefix $(BLDDIR)/, $(addsuffix .make, $(SRC)))

$(RULE_FILES) : $(BLDDIR)/%.make : % ${SCRIPTS_DIR}/getmakerecipe
	@echo "Getting recipes from $<."
	@mkdir -p ${BLDDIR}
	@getmakerecipe $<
-include $(RULE_FILES)

.DEFAULT_GOAL := all

all : $(filter %.pdf, $(DEST))

fig : $(filter ${FIGDIR}/*, $(DEST))

dist : ${DIST_TEX}
	@echo "Build package!"

%.zip : %
	@zip -r $@ $<

${FIGDIR}/% : ${FIGFILEDIR}/%
	@mkdir -p ${FIGDIR}
	@cp $< $@

.PHONY : .gitignore fig-clean dist-clean clean deep-clean
.gitignore :
	@echo .exclude_dirs >> .gitignore
	@echo $(DISTDIR) >> .gitignore
	@echo $(BLDDIR) >> .gitignore
	@printf '%s\n' $(notdir $(DEST)) >> .gitignore
	@# General stuff
	@echo "tags" >> .gitignore
	@echo "*.zip" >> .gitignore
	@echo "*-eps-converted-to.pdf" >> .gitignore

fig-clean :
	@rm -rf $(filter ${FIGFILEDIR}/*, $(DEST))

dist-clean:
	@rm -rf ${DISTDIR}

clean : dist-clean
	@rm -rf ${DEST} ${RULE_FILES}
	@find -type f -name "*-eps-converted-to.pdf" -exec rm -rf -rf {} \;

deep-clean : clean
	@rm -rf ${BLDDIR}
