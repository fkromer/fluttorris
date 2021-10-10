#!/bin/sh

cd fluttorris
export CHROME_EXECUTABLE=/snap/bin/chromium
flutter build web --release
cd ..
cp -R ./fluttorris/build/web/ ./docs/
git add docs/
git commit -m "update pages docs directory"
git push