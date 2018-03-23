#!/usr/bin/env python

import Image,ImageDraw,ImageFont,ImageFilter
import random

def rndChar():
	return chr(random.randint(65,90))

def rndColor():
	return (random.randint(64,255),random.randint(64,255),random.randint(64,255))

def rndColor2():
		return (random.randint(32,127),random.randint(32,127),random.randint(32,127))

width = 60 * 4
heigth = 60

image = Image.new('RGB',(width,heigth),(255,255,255))
font = ImageFont.truetype('/usr/share/fonts/truetype/ubuntu-font-family/Ubuntu-B.ttf',36)	#there should be provide absolute path so that app can fild the specified font

draw = ImageDraw.Draw(image)

for x in range(width):
	for y in range(heigth):
		draw.point((x,y),fill=rndColor())

for t in range(4):
	draw.text((60 * t +10,10),rndChar(),font=font,fill=rndColor2())

image = image.filter(ImageFilter.BLUR)
image.save('code.jpg','jpeg')
