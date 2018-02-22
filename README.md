# em-dosbox-in-a-box

Self-deploying, self-hosted web/em-dosbox based DOS games.

## Detailed Description:

This set of scripts makes it easy to deploy a self-contained instance of
em-dosbox with a collection of games. Because it uses Emscripten, it can be
deployed on a machine with very limited resources and rely instead on the
resources of the clients. This makes it convenient for me since I mostly do
casual, tablet-centric gaming.

### Dependencies:

    docker, make

## Usage:

Thiss should work on any linux distribution with docker and make, and also on
MacOS with docker and make, and probably on Windows with docker via the Windows
subsystem for Linux or cygwin, in order to use Make. You will need a collection
of DOS game files collected into a directory, with one game per subdirectory. Since
most DOS game collections seem to be organized like this anyway, this is the
structure I used. It has the benefit of being very predictable for the packager
script as well.

### Step one: Edit config.mk

The settings file is config.mk, and there is only one setting that you may need
to change. This setting is called MOUNT\_PROGRAMS\_FOLDER and it is a directory
containing your collection of DOS games. By default, it looks for this directory
in a directory called "programs" in the parent directory and mounts the volume
read-only in the docker container. You'll probably need to change the path, but
leaving it read-only is probably a good idea.

        MOUNT_PROGRAMS_FOLDER=--volume $(PWD)/../programs:/home/dosbox/em-dosbox/src/programs:ro

As you can see, MOUNT\_PROGRAMS\_FOLDER is just a docker run --volume option.
The first part is the directory on the host, the second is the mountpoint in
the container, and ro is the read-only permissions. Most people will only need
to change the first part.

### Step two: Deploy

The deployment is simple. Once you've edited your config.mk, run the following
commands:

        make config
        make

and wait. Emscripten, em-dosbox, and DOS game pages will be compiled and
generated, and will be made available on the container at port 8080 and on the
host at port 405.

## Copying to LEDE: WIP

