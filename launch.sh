#! /bin/sh
for f in $(find programs -type d -d 1); do
    mv "$f" /home/dosbox/em-dosbox/src/
    EXE=$(find "$f" | grep -vi cwsdpmi | grep -i exe )
    #./packager.py "$f" "$f" "$EXE"
    find /home/dosbox/em-dosbox/src -type -d
    echo "./packager.py $f $f $EXE"
done

darkhttpd /home/dosbox/em-dosbox/src/
