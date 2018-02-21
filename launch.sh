#! /bin/sh

ls /home/dosbox/em-dosbox/src/programs/

for f in $(find /home/dosbox/em-dosbox/src/programs -maxdepth 1 -mindepth 1 -type d ); do
    c=$(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/||g')
    d=$(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/|/home/dosbox/em-dosbox/src/|g')
    e=$(find "$f" | grep -vi cwsdpmi | grep -i exe | sed "s|/home/dosbox/em-dosbox/src/programs/$c/||g" )

    echo "Configure" | tee -a log.md
    echo "=========" | tee -a log.md
    echo "" | tee -a log.md
    echo " c=$c" | tee -a log.md
    echo " d=$d" | tee -a log.md
    echo " e=$e" | tee -a log.md
    echo " f=$f" | tee -a log.md
    echo "" | tee -a log.md
    echo "###moving files" | tee -a log.md
    echo "" | tee -a log.md
    echo "  mv $f" "$d" | tee -a log.md
    echo "" | tee -a log.md
    echo "### packaging files" | tee -a log.md
    echo "" | tee -a log.md
    echo "  ./packager.py $c $c $e" | tee -a log.md
    echo "" | tee -a log.md
    echo "access game at:" | tee -a log.md
    echo "---------------" | tee -a log.md
    echo "" | tee -a log.md
    echo "[$c.html]($c.html)" | tee -a log.md
    echo "" | tee -a log.md

    mv "$f" "$d" | tee -a log.md
    ./packager.py "$c" "$c" "$e" | tee -a log.md
done

markdown log.md

ls *.html

darkhttpd /home/dosbox/em-dosbox/src/
