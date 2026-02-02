#!/bin/bash
# Auto-patch script for flutter_sound plugin
# This is called by CMakeLists.txt during configuration

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "Warning: $FILE not found, skipping patch"
    exit 0
fi

# Check if already patched
if grep -q "taudio/taudio_plugin.h" "$FILE"; then
    echo "Already patched: $FILE"
    exit 0
fi

# Apply patches
sed -i 's|<flutter_sound/flutter_sound_plugin.h>|<taudio/taudio_plugin.h>|g' "$FILE"
sed -i 's|"FlutterSoundPlugin"|"TaudioPlugin"|g' "$FILE"
sed -i 's|flutter_sound_plugin_register_with_registrar|taudio_plugin_register_with_registrar|g' "$FILE"

echo "Patched: $FILE"
