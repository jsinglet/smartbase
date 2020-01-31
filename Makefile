all : build run

.PHONY : force

build-linux : force
	gprbuild -Psmartbase.gpr -Xmode=any-cross 

run :
	./obj/main

clean :
	gnatclean -r -Psmartbase.gpr

#export GPR_PROJECT_PATH = ../Example_4/Gnat_Project
