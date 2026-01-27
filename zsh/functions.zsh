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

# Give square image rounded corners
# img_round avatar.png 120
# 120 is optional
img2rounded () {
  input="$1"
  radius="${2:-40}" # default radius if not provided
  output="${input%.*}-rounded.png"

  size=$(magick identify -format "%wx%h" "$input")

  magick "$input" \
    \( -size "$size" xc:none -draw "roundrectangle 0,0 ${size/x/,} $radius,$radius" \) \
    -compose DstIn -composite \
    "$output"
}

pbcopy() { wl-copy; }
pbpaste() { wl-paste; }
