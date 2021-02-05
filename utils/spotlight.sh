#!/bin/bash
# Copies and renames images from Windows Spotlight.

spotlight_location="/c/Users/Grzesiek/AppData/Local/Packages/Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy/LocalState/Assets"
images_destination="/c/Users/Grzesiek/Downloads/Spotlight"

echo "Spotlight images location: $spotlight_location"
if [ ! -d "$spotlight_location" ] ; then
	echo "Couldn't locate the Spotlight data."
	exit 1
fi

mkdir -p "$images_destination"

for file in "$spotlight_location"/* ; do
	filesize=$(stat -c%s "$file")
	# Images under 100 kB are unlikely to be wallpapers.
	if [ "$filesize" -ge 100000 ]; then
		new_filename="$(basename "$file").jpg"
		echo "Copying $new_filename..."
		cp "$file" "$images_destination/$new_filename"
	fi
done
