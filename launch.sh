#! /bin/sh

for f in $(find /home/dosbox/em-dosbox/src/programs -maxdepth 1 -type d ); do
    c=$(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/||g')
    d=$(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/|/home/dosbox/em-dosbox/src/|g')
    #mv "$f" "$d"
    echo "mv $f" "$d"
    e=$(find "$f" | grep -vi cwsdpmi | grep -i exe | sed "s|/home/dosbox/em-dosbox/src/programs/$c/||g" )
    #./packager.py "$f" "$f" "$EXE"
    ls *.html
    echo "./packager.py $c $c $e"
done

darkhttpd /home/dosbox/em-dosbox/src/
