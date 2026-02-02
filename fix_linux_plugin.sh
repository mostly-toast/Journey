#!/bin/bash
# Fix flutter_sound plugin for Linux builds
# This script patches the generated files to match the actual plugin implementation

set -e

echo "Fixing flutter_sound plugin configuration for Linux..."

# Fix generated_plugin_registrant.cc - replace flutter_sound header with taudio header
REGISTRANT_FILE="linux/flutter/generated_plugin_registrant.cc"
if [ -f "$REGISTRANT_FILE" ]; then
    sed -i 's|#include <flutter_sound/flutter_sound_plugin.h>|#include <taudio/taudio_plugin.h>|g' "$REGISTRANT_FILE"
    sed -i 's|FlutterSoundPlugin|TaudioPlugin|g' "$REGISTRANT_FILE"
    sed -i 's|flutter_sound_plugin_register_with_registrar|taudio_plugin_register_with_registrar|g' "$REGISTRANT_FILE"
    echo "✓ Fixed $REGISTRANT_FILE"
fi

# Fix generated_plugin_registrant.h
REGISTRANT_HEADER="linux/flutter/generated_plugin_registrant.h"
if [ -f "$REGISTRANT_HEADER" ]; then
    # Usually this file doesn't need changes, but let's be safe
    echo "✓ Checked $REGISTRANT_HEADER"
fi

echo "Done! You can now run 'flutter run -d linux'"
