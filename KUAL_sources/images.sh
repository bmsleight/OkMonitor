

# wget https://svn.ak-team.com/svn/Configs/trunk/Kindle/Touch_Hacks/ScreenSavers/src/linkss/etc/kindle_colors.gif
# https://fa2png.app/ tv-solid 100px

convert tv-solid.png -background white \
		-gravity center  -extent 1024x758 \
		-gravity North -pointsize 48 -annotate +0+200 'Monitor' \
		-rotate 270 monitor.png 

convert tv-solid.png -background white \
		-gravity center  -extent 1024x758 \
		-gravity North -pointsize 48 -annotate +0+200 'Monitor 1' \
		-rotate 270 monitor1.png 

convert tv-solid.png -background white \
		-gravity center  -extent 1024x758 \
		-gravity North -pointsize 48 -annotate +0+200 'Monitor 2' \
		-rotate 90 monitor2.png 

convert tv-solid.png -background white \
		-gravity center  -extent 1024x758 \
		-gravity North -pointsize 48 -annotate +0+200 'Monitor 3' \
		-rotate 270 monitor3.png 

convert tv-solid.png -background white \
		-gravity center  -extent 1024x758 \
		-gravity North -pointsize 48 -annotate +0+200 'Monitor 4' \
		-rotate 90 monitor4.png 


convert tv-solid.png -background white \
		-gravity center  -extent 1024x758 \
		-gravity North -pointsize 48 -annotate +0+200 'Waiting to connect' \
		-rotate 270 monitor13_wait.png 

convert tv-solid.png -background white \
		-gravity center  -extent 1024x758 \
		-gravity North -pointsize 48 -annotate +0+200 'Waiting to connect' \
		-rotate 90 monitor24_wait.png 


# To Kindle format
for file in monitor*.png
do 
	convert ${file} -filter LanczosSharp -resize 758x1024 \
	-background black -gravity center -extent 758x1024 \
	-colorspace Gray -dither FloydSteinberg -remap kindle_colors.gif \
	-quality 75 -define png:color-type=0 -define png:bit-depth=8 \
	info_${file}; \
done
