#### Start of configuration section. ####

# Name of the output file for the document.
output           := manuscript.pdf
# Root directory for the document's TeX files.
tex_dir          := manuscript
# Current cover letter to be produced
cover_letter_dir  := cover-letter
cover_letter_src  := $(cover_letter_dir)/cover-letter.tex
# Directory for pictures used in the document.
pics_dir         := pictures/manuscript
# Directory for source files of pictures used in the document.
pics_src_dir     := $(pics_dir)/src
# Extension of Python-generated picture files.
pics_py_ext      := .pdf
# Extension of TeX-generated picture files.
pics_tex_ext     := .pdf
# Directories where all Python modules used for the project production are stored.
py_modules       := pictures/config
# Unneeded files generated during TeX compilation.
tex_resid        := *.bbl *.xml
# The main TeX file to be compiled.
tex_main         := $(tex_dir)/main.tex
# Other TeX files required for the main document.
tex_deps         := $(wildcard $(tex_dir)/config/*.cls \
                               $(tex_dir)/config/*.sty \
                               $(tex_dir)/config/*.tex \
                               $(tex_dir)/tables/*.tex)
# Other files required for Python pictures to be produced.
pics_py_modules  :=
pics_py_deps     := $(pics_dir)/../config/my_py_picture.py \
                    $(pics_py_modules)
# Other files required for TeX pictures to be produced.
pics_tex_deps    := $(pics_dir)/../config/mytexpicture.cls

#### End of configuration section. ####

#### Start of development tools definitions section. ####

TEX              := latexmk
TEX_BUILD_FLAGS  := -pdf
TEX_DEL_FLAGS    := -silent -C
PY               := python
PDF_COMPRESS     := gs -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -q -o

#### End of development tools definitions section. ####

#### Start of automatic dependency generation section. ####

tex_bib          := $(wildcard $(tex_dir)/*.bib)
pics_tex_src     := $(wildcard $(pics_src_dir)/*.tex)
pics_tex         := $(patsubst %.tex,\
                               %$(pics_tex_ext),\
                               $(addprefix $(pics_dir)/,\
			                   $(notdir $(pics_tex_src))))
pics_py_src      := $(wildcard $(pics_src_dir)/*.py)
pics_py          := $(patsubst %.py,\
                               %$(pics_py_ext),\
                               $(addprefix $(pics_dir)/,\
			                   $(subst _,-,\
						   $(notdir $(pics_py_src)))))
pics_editable    := $(pics_tex) $(pics_py)
pics_addl        := $(filter-out $(pics_editable),\
                                 $(wildcard $(pics_dir)/*))
tex_files        := $(tex_main) $(tex_bib) $(tex_deps)
pics_files       := $(pics_editable) $(pics_addl)

py_modules_resid := $(addsuffix /__pycache__,$(py_modules))

cover_letter      := cover-letter.pdf
cover_letter_deps := $(wildcard $(cover_letter_dir)/config/*.cls) \
                     $(wildcard $(cover_letter_dir)/config/*.sty) \
		     $(wildcard $(cover_letter_dir)/config/*.tex)

#### End of automatic dependency generation section. ####

#### Start of main recipes section. ####

.PHONY : all

all : $(output) $(cover_letter)

$(output) : $(tex_files) $(pics_files)
	$(call build_tex,$@,$<)

$(cover_letter) : $(cover_letter_src) $(cover_letter_deps)
	$(call build_tex,$@,$<)

#### End of main recipes section. ####

#### Start of cleaning recipes section. ####

.PHONY : cleanall clean cleanresidues cleantex cleanpy cleanpics

cleanall : clean
	@rm -f $(output)
	@rm -f $(cover_letter)

clean : cleanresidues cleanpics

cleanresidues : cleantex cleanpy

cleantex :
	$(call clean_tex,$(tex_main))
	$(foreach texpicsrc,$(pics_tex_src),$(call clean_tex,$(texpicsrc)))
	$(call clean_tex,$(cover_letter_src))

cleanpy :
	@rm -rf $(py_modules_resid)

cleanpics :
	@rm -f $(pics_editable)

#### End of cleaning recipes section. ####

#### Start of TeX recipes section. ####

define build_tex =
  @cd $(dir $(2)) && \
  $(TEX) $(TEX_BUILD_FLAGS) $(notdir $(2))
  @mv $(basename $(2)).pdf $(1)
endef

define clean_tex =
  @cd $(dir $(1)) && \
  $(TEX) $(TEX_DEL_FLAGS) $(notdir $(1)) && \
  rm -f $(tex_resid)
endef

#### End of TeX recipes section. ####

#### Start of pictures recipes section. ####

.PHONY : pics

pics : $(pics_editable)

# TeX pictures.
define pics_tex_eval =
  $(1) : $(patsubst %$(3),\
                    %.tex,\
                    $(addprefix $(2)/,$(notdir $(1)))) \
         $(wildcard $(basename $(addprefix $(2)/,\
	                                   $(notdir $(1))))-src*) \
	 $(4)
endef

$(foreach texpic,$(pics_tex),$(eval $(call pics_tex_eval,$(texpic),$(pics_src_dir),$(pics_tex_ext),$(pics_tex_deps))))

$(pics_tex) :
	$(call build_tex,$@,$<)

# Python pictures.
define pics_py_eval =
  $(1) : $(patsubst %$(3),\
                    %.py,\
                    $(addprefix $(2)/,$(subst -,_,$(notdir $(1))))) \
         $(wildcard $(basename $(addprefix $(2)/,\
	   	                           $(subst -,_,$(notdir $(1)))))-src*) \
         $(4)
endef

$(foreach pypic,$(pics_py),$(eval $(call pics_py_eval,$(pypic),$(pics_src_dir),$(pics_py_ext),$(pics_py_deps))))

$(pics_py) :
	@echo Making $(notdir $<)
	@cd $(dir $<) && \
	$(PY) $(notdir $<)

# Pictures compression.
.PHONY : compresspics

pics2comp =
compresspics : $(pics2comp)
$(pics2comp) :
	@echo Compressing $@
	@$(PDF_COMPRESS) $(basename $(pics_dir)/$@)-comp.pdf $(pics_dir)/$@
	@mv $(basename $(pics_dir)/$@)-comp.pdf $(pics_dir)/$@

#### End of pictures recipes section. ####
