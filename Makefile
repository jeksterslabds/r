all :
	Rscript r_packages.R
	Rscript -e 'styler::style_dir()'
	(cd jeksterslabRpkg && make)
	(cd jeksterslabRutils && make)
	(cd jeksterslabRlib && make)
