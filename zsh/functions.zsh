# Custom user functions
# Add your personal functions here

# Transcode any image to small JPG
img2jpg-thumb() {
  magick $1 -resize 1536x\> -quality 95 -strip ${1%.*}.jpg
}
