#! /bin/sh

ls /home/dosbox/em-dosbox/src/programs

echo "Log File/Temporary Index Page" | tee -a log.md
echo "=============================" | tee -a log.md
echo "" | tee -a log.md
echo "This is a temporary index page generated from the log file." | tee -a log.md
echo "" | tee -a log.md

markdown log.md | tee log.html

darkhttpd /home/dosbox/em-dosbox/src/ --index log.html --log log.txt &

for f in $(find /home/dosbox/em-dosbox/src/programs -maxdepth 1 -mindepth 1 -type d ); do
    c=$(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/||g')
    d=$(echo "$f" | sed 's|/home/dosbox/em-dosbox/src/programs/|/home/dosbox/em-dosbox/src/|g')
    e=$(find "$f" | grep -vi cwsdpmi | grep -i exe | sed "s|/home/dosbox/em-dosbox/src/programs/$c/||g" )

    echo "" | tee -a "$c.md"
    echo "Configuring $c" | tee -a "$c.md"
    echo "--------------" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    echo "  * c=$c" | tee -a "$c.md"
    echo "  * d=$d" | tee -a "$c.md"
    echo "  * e=$e" | tee -a "$c.md"
    echo "  * f=$f" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    echo "#### linking files" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    ln -sf "$f" "$d" | tee -a "$c.md"
    echo "  ln -sf $f" "$d" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    echo "#### hashing files" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    md5sum "$d/$e" | tee -a "$c.md" | tee "$c.md5sum"
    echo "" | tee -a "$c.md"
    echo "  md5sum $d/$e" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    sha1sum "$d/$e" | tee -a "$c.md" | tee "$c.sha1sum"
    echo "" | tee -a "$c.md"
    echo "  sha1sum $d/$e" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    sha256sum "$d/$e" | tee -a "$c.md" | tee "$c.sha256sum"
    echo "" | tee -a "$c.md"
    echo "  sha256sum $d/$e" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    echo "#### packaging files" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    ./packager.py "$c" "$c" "$e" | tee -a "$c.md"
    echo "  ./packager.py $c $c $e" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    echo "### access game at:" | tee -a "$c.md"
    echo "" | tee -a "$c.md"
    echo "[$c.html]($c.html)" | tee -a "$c.md"
    echo "" | tee -a "$c.md"

    cat "$c.md" | tee -a log.md

    markdown log.md | tee log.html

done

markdown log.md | tee log.html

ls *.html

tail -f log.txt
