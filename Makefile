STDOUT="${HOME}/make.out"
STDERR="${HOME}/make.err"

.PHONY: all clean packages

all :
	(cd build_jeksterslabRterm && make)
	Rscript r_packages.R
	Rscript -e 'styler::style_dir()'
	(cd jeksterslabRutils && make)
	(cd jeksterslabRterm && make)
	(cd jeksterslabRpkg && make)
	(cd jeksterslabRds && make)
	(cd jeksterslabRlib && make)
	(cd jeksterslabRdoc && make)
	(cd build_boilerplatePackage && make)
	-git init
	-git add -A
	-git commit -m "BUILD."
	-git push

clean :
	-(cd build_jeksterslabRterm && make clean)
	-(cd jeksterslabRutils && make clean)
	-(cd jeksterslabRterm && make)
	-(cd jeksterslabRpkg && make clean)
	-(cd jeksterslabRds && make)
	-(cd jeksterslabRlib && make clean)
	-(cd jeksterslabRdoc && make clean)
	-(cd build_boilerplatePackage && make clean)

packages :
	(cd build_jeksterslabRterm && make)
	Rscript r_packages.R
