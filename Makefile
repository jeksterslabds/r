PREFIX=/media/jeksterslab/scripts/r
stdoutboilerplate=$(PREFIX)/.stdoutboilerplate
stderrboilerplate=$(PREFIX)/.stderrboilerplate
stdoutterm=$(PREFIX)/.stdoutterm
stderrterm=$(PREFIX)/.stderrterm
stdoutstyle=$(PREFIX)/.stdoutstyle
stderrstyle=$(PREFIX)/.stderrstyle
stdoutpkg=$(PREFIX)/.stdoutpkg
stderrpkg=$(PREFIX)/.stderrpkg
stdoutuserlib=$(PREFIX)/.stdoutuserlib
stderruserlib=$(PREFIX)/.stderruserlib
stdouttermclean=$(PREFIX)/.stdouttermclean
stderrtermclean=$(PREFIX)/.stderrtermclean
stdoutboilerplateclean=$(PREFIX)/.stdoutboilerplateclean
stderrboilerplateclean=$(PREFIX)/.stderrboilerplateclean
stdoutR=$(PREFIX)/.stdoutR
stderrR=$(PREFIX)/.stderrR
stdoutRdoc=$(PREFIX)/.stdoutRdoc
stderrRdoc=$(PREFIX)/.stderrRdoc
stdoutRds=$(PREFIX)/.stdoutRds
stderrRds=$(PREFIX)/.stderrRds
stdoutRlib=$(PREFIX)/.stdoutRlib
stderrRlib=$(PREFIX)/.stderrRlib
stdoutRnotes=$(PREFIX)/.stdoutRnotes
stderrRnotes=$(PREFIX)/.stderrRnotes
stdoutRterm=$(PREFIX)/.stdoutRterm
stderrRterm=$(PREFIX)/.stderrRterm
stdoutRpkg=$(PREFIX)/.stdoutRpkg
stderrRpkg=$(PREFIX)/.stderrRpkg
stdoutRutils=$(PREFIX)/.stdoutRutils
stderrRutils=$(PREFIX)/.stderrRutils

.PHONY: all rgit build rbuild boilerplate term Rdoc Rds Rlib Rnotes Rterm Rpkg Rutils style pkg userlib deepclean termclean clean boilerplateclean

all : rgit

rgit : build
	-git add --all
	-git commit -m "Automated build."
	-git push

build : boilerplate R term Rdoc Rds Rlib Rnotes

rbuild : R Rterm Rdoc Rds Rlib Rnotes

boilerplate: Rpkg
	(cd build_boilerplatePackage && make > ${stdoutboilerplate} 2> ${stderrboilerplate})

term : Rterm
	(cd build_jeksterslabRterm && make > ${stdoutterm} 2> ${stderrterm})

R : Rpkg
	(cd jeksterslabR && make > ${stdoutR} 2> ${stderrR})

Rdoc : Rpkg
	(cd jeksterslabRdoc && make > ${stdoutRdoc} 2> ${stderrRdoc})

Rds : Rpkg
	(cd jeksterslabRds && make > ${stdoutRds} 2> ${stderrRds})

Rlib : Rpkg
	(cd jeksterslabRlib && make > ${stdoutRlib} 2> ${stderrRlib})

Rnotes : Rpkg
	(cd jeksterslabRnotes && make > ${stdoutRnotes} 2> ${stderrRnotes})

Rterm : Rpkg
	(cd jeksterslabRterm && make > ${stdoutRterm} 2> ${stderrRterm})

Rpkg : Rutils
	(cd jeksterslabRpkg && make > ${stdoutRpkg} 2> ${stderrRpkg})

Rutils : pkg style
	(cd jeksterslabRutils && make > ${stdoutRutils} 2> ${stderrRutils})

style : userlib
	Rscript -e 'if (!require("styler")) install.packages("styler", repos = "https://cran.rstudio.org")'
	Rscript -e 'if (!require("remotes")) install.packages("remotes", repos = "https://cran.rstudio.org")'
	Rscript -e 'if (!require("jeksterslabRutils")) remotes::install_github("jeksterslabds/jeksterslabRutils")'
	Rscript -e 'jeksterslabRutils::util_style(dir = getwd(), recursive = TRUE, par = TRUE, ncores = NULL)' > ${stdoutstyle} 2> ${stderrstyle}

pkg : userlib
	Rscript 02_r_packages.R > ${stdoutpkg} 2> ${stderrpkg}

userlib : rm
	Rscript 01_user_lib.R > ${stdoutuserlib} 2> ${stderruserlib}

deepclean : termclean

termclean : clean
	(cd build_jeksterslabRterm && make clean > ${stdouttermclean} 2> ${stderrtermclean})

clean : boilerplateclean
	-./run.sh clean

boilerplateclean : rm
	(cd build_boilerplatePackage && make clean > ${stdoutboilerplateclean} 2> ${stderrboilerplateclean})

rm :
	-rm .std*
