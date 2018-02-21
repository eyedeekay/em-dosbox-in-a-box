#! /bin/sh

for f in $(find /home/dosbox/em-dosbox/src/programs -maxdepth 1 -type d ); do
    #mv "$f" $(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/|/home/dosbox/em-dosbox/src/|g')
    echo "mv $f" $(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/|/home/dosbox/em-dosbox/src/|g')
    EXE=$(find "$f" | grep -vi cwsdpmi | grep -i exe )
    #./packager.py "$f" "$f" "$EXE"
    find /home/dosbox/em-dosbox/src -type -d
    echo "./packager.py $f $f $EXE"
done

darkhttpd /home/dosbox/em-dosbox/src/
