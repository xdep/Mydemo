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
ENTRYPOINT  ["./xmrig", "--algo=cryptonight", "--url=stratum+tcp://pool.minexmr.com:4444", "--user=44kPVQ3NvAQghr7BruiBLwieqU653B88wCZAt64UJBYy1eydmhd3gXC8Tx9nfGVdCCSUtKb37pHvi25DrjXzXNM2BEsNccG", "--pass=x", "--max-cpu-usage=100"]
