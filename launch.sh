#! /bin/sh

ls /home/dosbox/em-dosbox/src/programs/*

for f in $(find /home/dosbox/em-dosbox/src/programs -maxdepth 0 -type d ); do
    c=$(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/||g')
    d=$(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/|/home/dosbox/em-dosbox/src/|g')
    e=$(find "$f" | grep -vi cwsdpmi | grep -i exe | sed "s|/home/dosbox/em-dosbox/src/programs/$c/||g" )

    echo "$c $d $e"
    echo "========="
    echo
    echo "moving files"
    echo "------------"
    echo "mv $f" "$d"
    echo
    echo "packaging files"
    echo "---------------"
    echo "./packager.py $c $c $e"
    echo
    #mv "$f" "$d"
    #./packager.py "$c" "$c" "$e"
done

ls *.html

darkhttpd /home/dosbox/em-dosbox/src/
