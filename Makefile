.PHONY: all clean

all :
	Rscript r_packages.R
	Rscript -e 'styler::style_dir()'
	(cd jeksterslabRpkg && make)
	(cd jeksterslabRterm && make)
	(cd jeksterslabRutils && make)
	(cd jeksterslabRlib && make)
	(cd build_boilerplatePackage && make)

clean :
	Rscript r_packages.R
	Rscript -e 'styler::style_dir()'
	(cd jeksterslabRpkg && make clean)
	(cd jeksterslabRterm && make)
	(cd jeksterslabRutils && make clean)
	(cd jeksterslabRlib && make clean)
	(cd build_boilerplatePackage && make clean)
