PREFIX=/media/jeksterslab/scripts/r
OUTPKG=$(PREFIX)/.stdoutpkg
ERRPKG=$(PREFIX)/.stderrpkg
OUTTRM=$(PREFIX)/.stdouttrm
ERRTRM=$(PREFIX)/.stderrtrm

.PHONY: all build clean deepclean boilerplate boilerplateclean packages packagesclean term termclean style

all : build
	Rscript r_packages.R > ${OUTPKG} 2> ${ERRPKG}

build : boilerplate
	./run.sh all

clean : packages
	./run.sh clean

deepclean : boilerplateclean
	./run.sh clean

boilerplateclean : packagesclean
	(cd build_boilerplatePackage && make clean)

boilerplate: packages
	(cd jeksterslabRpkg && make)
	(cd build_boilerplatePackage && make)

packagesclean : termclean
	Rscript r_packages.R > ${OUTPKG} 2> ${ERRPKG}
	Rscript -e 'jeksterslabRutils::util_style(dir = getwd(), recursive = TRUE, par = TRUE, ncores = NULL)'

packages : term style
	Rscript r_packages.R > ${OUTPKG} 2> ${ERRPKG}

term :
	(cd build_jeksterslabRterm && make > ${OUTTRM} 2> ${ERRTRM})

termclean :
	(cd build_jeksterslabRterm && make clean > ${OUTTRM} 2> ${ERRTRM})

style :
	Rscript -e 'if (!require("styler")) install.packages("styler", repos = repos)'
	Rscript -e 'jeksterslabRutils::util_style(dir = getwd(), recursive = TRUE, par = TRUE, ncores = NULL)'
