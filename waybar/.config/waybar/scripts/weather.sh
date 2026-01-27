#!/bin/bash

# --- CONFIGURATION ---
API_KEY="YOUR_ACTUAL_API_KEY_HERE" # Paste your key here
LAT="40.712776"  # Replace with your Latitude
LON="-74.005974" # Replace with your Longitude
UNITS="imperial" # Use "metric" for Celsius, "imperial" for Fahrenheit
# ---------------------

if [ -z "$LAT" ] || [ -z "$LON" ] || [ -z "$UNITS" ] || [ -z "$API_KEY" ]; then
    echo "Config missing"
    exit 1
fi

RESPONSE=$(curl -s "https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&appid=${API_KEY}&units=${UNITS}")

# Check if curl failed
if [ -z "$RESPONSE" ]; then
    echo "No connection"
    exit 1
fi

# 1. Get the Temperature (rounded)
TEMP=$(echo "$RESPONSE" | jq '.main.temp | round')

# 2. Get the Description (for tooltip)
DESC=$(echo "$RESPONSE" | jq -r '.weather[0].description')

# 3. Get the Icon Code (e.g., "01d", "10n")
ICON_CODE=$(echo "$RESPONSE" | jq -r '.weather[0].icon')

# 4. Map the Icon Code to an Emoji
# OpenWeatherMap Icon Codes: https://openweathermap.org/weather-conditions
case $ICON_CODE in
    "01d") ICON="☀️";;  # Clear sky day
    "01n") ICON="🌙";;  # Clear sky night
    "02d") ICON="⛅";;  # Few clouds day
    "02n") ICON="☁️";;  # Few clouds night
    "03d"|"03n") ICON="☁️";; # Scattered clouds
    "04d"|"04n") ICON="☁️";; # Broken clouds
    "09d"|"09n") ICON="🌧️";; # Shower rain
    "10d") ICON="🌦️";; # Rain day
    "10n") ICON="🌧️";; # Rain night
    "11d"|"11n") ICON="⛈️";; # Thunderstorm
    "13d"|"13n") ICON="❄️";; # Snow
    "50d"|"50n") ICON="🌫️";; # Mist
    *) ICON="❓";;      # Default/Unknown
esac

# Output for Waybar
# Example Output: {"text": "☀️ 22°F", "tooltip": "clear sky"}
echo "{\"text\": \"${ICON} ${TEMP}°\", \"tooltip\": \"${DESC}\"}"
