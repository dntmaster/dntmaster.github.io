#!/bin/sh
dpkg-scanpackages ./debs/ > Packages
sed -i -e '/^SHA/d' ./Packages
bzip2 -c9k ./Packages > ./Packages.bz2
printf "Origin: DNTmaster's Repo\nLabel: DNTmaster\nSuite: stable\nVersion: 1.0\nCodename: DNTmaster\nArchitecture: iphoneos-arm\nComponents: main\nDescription: DNTmaster's Tweaks\nmd5sum:\n "$(cat ./Packages | md5sum -c | cut -d ' ' -f 1)" "$(stat -f%z Packages)" Packages\n "$(cat ./Packages.bz2 | md5sum -c | cut -d ' ' -f 1)" "$(stat -f%z Packages.bz2)" Packages.bz2\n" >Release;
python3 generate_packageinfo.py
printf "\nUpdating 'latest tweaks' file"
bash last_updates.sh
printf "\nPushing to github..."
#git add *
#git commit -m "add tweak(s)"
#git push -u origin master
printf "Done\n"
exit 0
