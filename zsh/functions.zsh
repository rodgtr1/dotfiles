# Custom user functions
# Add your personal functions here

# Transcode any image to thumbnail-size JPG
img2jpg-thumb() {
  magick $1 -resize 1536x\> -quality 95 -strip ${1%.*}.jpg
}
