#! /bin/sh

ls /home/dosbox/em-dosbox/src/programs

echo "Log File/Temporary Index Page" | tee -a log.md
echo "=============================" | tee -a log.md
echo "" | tee -a log.md
echo "This is a temporary index page generated from the log file." | tee -a log.md
echo "" | tee -a log.md

markdown log.md | tee log.html

darkhttpd /home/dosbox/em-dosbox/src/ --index log.html --log log.txt &

for full_path in $(find /home/dosbox/em-dosbox/src/programs -maxdepth 1 -mindepth 1 -type d ); do
    game_name=$(echo "$full_path" | sed 's|/home/dosbox/em-dosbox/src/programs/||g')
    game_dir=$(echo "$full_path" | sed 's|/home/dosbox/em-dosbox/src/programs/|/home/dosbox/em-dosbox/src/|g')
    game_exe=$(find "$full_path" | grep -vi cwsdpmi | grep -i exe | sed "s|/home/dosbox/em-dosbox/src/programs/$game_name/||g" )

    echo "" | tee "$game_name.md"
    echo "Configuring $game_name" | tee -a "$game_name.md"
    echo "--------------" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    echo "  * c=$game_name" | tee -a "$game_name.md"
    echo "  * d=$game_dir" | tee -a "$game_name.md"
    echo "  * e=$game_exe" | tee -a "$game_name.md"
    echo "  * f=$full_path" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    echo "#### linking files" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    ln -sf "$full_path" "$game_dir" | tee -a "$game_name.md"
    echo "  ln -sf $full_path" "$game_dir" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    echo "#### hashing files" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    md5sum "$game_dir/$game_exe" | tee -a "$game_name.md" | tee "$game_name.md5sum"
    echo "" | tee -a "$game_name.md"
    echo "  md5sum $game_dir/$game_exe" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    sha1sum "$game_dir/$game_exe" | tee -a "$game_name.md" | tee "$game_name.sha1sum"
    echo "" | tee -a "$game_name.md"
    echo "  sha1sum $game_dir/$game_exe" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    sha256sum "$game_dir/$game_exe" | tee -a "$game_name.md" | tee "$game_name.sha256sum"
    echo "" | tee -a "$game_name.md"
    echo "  sha256sum $game_dir/$game_exe" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    echo "#### packaging files" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    ./packager.py "$game_name" "$game_name" "$game_exe" | tee -a "$game_name.md"
    echo "  ./packager.py $game_name $game_name $game_exe" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    echo "### access game at:" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"
    echo "[$game_name.html]($game_name.html)" | tee -a "$game_name.md"
    echo "" | tee -a "$game_name.md"

    log=$(cat log.md "$game_name.md")
    echo "$log" | tee log.md
    pandoc "$game_name.md" -o log.html

done

pandoc log.md -o log.html

killall darkhttpd; sleep 2
darkhttpd /home/dosbox/em-dosbox/src/ --index log.html --log log.txt &
ls *.html

tail -f log.txt
