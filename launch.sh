#! /bin/sh

for f in $(find /home/dosbox/em-dosbox/src/programs -maxdepth 1 -type d ); do
    #mv "$f" $(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/|/home/dosbox/em-dosbox/src/|g')
    c=$(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/||g')
    d=$(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/|/home/dosbox/em-dosbox/src/|g')
    echo "mv $f" "$d"
    e=$(find "$f" | grep -vi cwsdpmi | grep -i exe | sed "s|/home/dosbox/em-dosbox/src/programs/$c||g" )
    #./packager.py "$f" "$f" "$EXE"
    find /home/dosbox/em-dosbox/src/ -maxdepth 1 *.html
    echo "./packager.py $c $c $e"
done

darkhttpd /home/dosbox/em-dosbox/src/
