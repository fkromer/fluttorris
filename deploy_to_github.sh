#!/bin/sh

cd fluttorris
export CHROME_EXECUTABLE=/snap/bin/chromium
flutter build web --release
cd ..
git checkout pages
cp -R ./fluttorris/build/web/ ./docs/
rm -r fluttorris/
git add docs/
git commit -m "update pages docs directory"
git push
git checkout main