PREFIX=/media/jeksterslab/scripts/r
OUTPKG=$(PREFIX)/.stdoutpkg
ERRPKG=$(PREFIX)/.stderrpkg
OUTTRM=$(PREFIX)/.stdouttrm
ERRTRM=$(PREFIX)/.stderrtrm

.PHONY: all clean deepclean boilerplate boilerplateclean packages packagesclean term termclean

all : boilerplate
	./run.sh all

clean : packages
	./run.sh clean

deepclean : boilerplateclean
	./run.sh clean

boilerplateclean : packagesclean
	(cd build_boilerplatePackage && make clean)

boilerplate: packages
	(cd build_boilerplatePackage && make)

packagesclean : termclean
	Rscript r_packages.R > ${OUTPKG} 2> ${ERRPKG}
	Rscript -e 'styler::style_dir()' >> ${OUTPKG} 2>> ${ERRPKG}

packages : term
	Rscript r_packages.R > ${OUTPKG} 2> ${ERRPKG}
	Rscript -e 'styler::style_dir()' >> ${OUTPKG} 2>> ${ERRPKG}

term :
	(cd build_jeksterslabRterm && make > ${OUTTRM} 2> ${ERRTRM})

termclean :
	(cd build_jeksterslabRterm && make clean > ${OUTTRM} 2> ${ERRTRM})

