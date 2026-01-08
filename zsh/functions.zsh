# Custom user functions
# Add your personal functions here

# Transcode any image to thumbnail-size JPG
img2jpg-thumb() {
  magick $1 -resize 1536x\> -quality 95 -strip ${1%.*}.jpg
}

# Transcode any image to custom-size JPG
img2jpg-custom() {
  magick $1 -resize ${2}x${3}\> -quality 95 -strip ${1%.*}.jpg
}

# Resize any image to custom size, keeping original format
img2resize() {
  magick $1 -resize ${2}x${3}\> -quality 95 -strip ${1%.*}_${2}x${3}.${1##*.}
}
