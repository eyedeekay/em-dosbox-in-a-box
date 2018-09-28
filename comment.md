This was directly copied from an issue that was raised. It's the closest thing
to documentation for this that I've written for this so far. Since I'm revising
it, I better just keep it here until I have something better.

I created the issue. My bad. I'm going to try and fix it a couple different ways
before I push up a new version, but it'll be fixed soon. I forgot to document
how to get the actual programs into the folder where the launcher script
generates looks for files to generate data from, which is
/home/dosbox/em-dosbox/src/programs and the pages will be generated in
/home/dosbox/em-dosbox/src/.

I've pretty much taken to doing anything I have to do with emscripten in Docker
containers(Actually that's the reason for how this was set up). Alpine linux,
which is commonly used for Docker containers, has up-to-date emscripten
packages in it's edge branch. It's not how you're "supposed" to use it, but if
you wanted to get a minimal alpine userspace with the latest emscripten
packages and some common toolchain components, you could:

``` Dockerfile
FROM alpine:edge
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" | tee -a
/etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" | tee -a
/etc/apk/repositories
RUN apk update -U
RUN apk add bash emscripten-fastcomp emscripten emscripten-optimizer \
    emscripten-libs-asmjs emscripten-libs-wasm make autoconf autoconf-archive \
    automake darkhttpd git glib-dev glib markdown
CMD bash -i
```

docker build -t hokuco/alpine-emscripten .

and then, whenever you needed your emscripten tools, you could drop into the
container by running

docker run -i --name alpine-emscripten hokuco/alpine-emscripten

That's a little shortcut around your toolchain issues. It's also a fairly
comprehensive set of emscripten tools to use as the basis for future
containers. Docker users are kind of notorious for assuming that the solution
to every problem is more Docker, but when it comes to emscripten, this really
helps keep things together.

I couldn't remember how I did this, and I'm working my way back through it now
but I really did a poor job naming the variables in this thing. What happens is
that launch.sh starts darkhttpd with a placeholder page, then loops over all
the folders in /home/dosbox/em-dosbox/src/programs to find DOS programs to
package with emscripten. While doing so, it redirects the log files to format
the output as a markdown document. Then it puts them all together, emits a new
home page, and restarts darkhttpd. The files that are generated are placed in
/home/dosbox/em-dosbox/src. The launch.sh script is the only significant
component of this and it is due for a revision.
