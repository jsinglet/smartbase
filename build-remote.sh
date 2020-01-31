# -- can update includes with -cargs:c -I../libs/rpi_ws281x/
rsync -rva ../smartbase-ada pi@smart-meter:/home/pi/Projects/ && ssh -l pi smart-meter "cd /home/pi/Projects/smartbase-ada && gprbuild -Xmode=linux-pi  && sudo /home/pi/Projects/smartbase-ada/obj/main"
