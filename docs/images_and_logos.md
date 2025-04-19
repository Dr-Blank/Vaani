this is how i converted my png to svg

`convert -background White vaani_logo.png vaani_logo.pbm`


`potrace -b svg -i vaani_logo.pbm -o vaani_logo.svg`

`-i` flag was needed so that it took white as the svgs and black as background