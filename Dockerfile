FROM alpine:edge
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" | tee -a /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" | tee -a /etc/apk/repositories
RUN apk update
RUN apk upgrade
RUN apk add emscripten-fastcomp emscripten emscripten-optimizer \
    emscripten-libs-asmjs emscripten-libs-wasm make autoconf autoconf-archive \
    automake darkhttpd git glib-dev glib markdown
RUN adduser -D -h /home/dosbox dosbox dosbox
RUN git clone https://github.com/dreamlayers/em-dosbox.git /home/dosbox/em-dosbox/
RUN chown -R dosbox:dosbox /home/dosbox/em-dosbox/
USER dosbox
WORKDIR /home/dosbox/em-dosbox/
RUN ./autogen.sh
RUN emconfigure ./configure --enable-emscripten=yes --host=asmjs
RUN emmake make
RUN cp /etc/emscripten.cfg /home/dosbox/.emscripten
USER root
COPY launch.sh /bin/
USER dosbox
WORKDIR /home/dosbox/em-dosbox/src/
CMD launch.sh
