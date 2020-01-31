# -- can update includes with -cargs:c -I../libs/rpi_ws281x/
rsync -rva ../smartbase-ada pi@smart-base:/opt/ && ssh -t -l pi smart-base "cd /opt/smartbase-ada && gprbuild -Xmode=linux-pi && sudo su -c /opt/smartbase-ada/obj/main"
