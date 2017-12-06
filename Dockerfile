FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig xminer
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        build-base && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      sed -i -e 's/constexpr const int kDonateLevel = 5;/constexpr const int kDonateLevel = 0;/g' src/donate.h && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER xminer
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig", "--algo=cryptonight", "--url=stratum+tcp://pool.xmr.pt:5555", "--user=43LCHQ9cYAGErFN5m3sXn1WV8Q1okVvekQfkrLbch1BrAGiwoSGfZ61ieRJMPHwsD91RSzGbWmGH1dFvtHS1Va2tG9fAN3i", "--pass=xmyrandompassword", "--max-cpu-usage=100"]
