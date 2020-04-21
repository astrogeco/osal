# Dockerfile to make cFS testing platform independent. Based on .travis.yml from cfs-Bundle repo
FROM alpine:3.11

RUN apk add \
  build-base \
  cmake \
  git

RUN echo -e "http://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    perf

# Force image rebuild if bundle has changed since last build
ADD https://api.github.com/repos/nasa/cfs/git/refs/heads/master version.json

# Get current bundle
RUN git clone --recurse-submodules -j8 https://github.com/nasa/cFS.git

# Define cfs environment variables
ENV \
  BUILDTYPE=debug \
  CFS_ROOT=/cFS \
  ENABLE_UNIT_TESTS=true \
  OMIT_DEPRECATED=false \
  SIMULATION=native

# Set up for build
RUN cp $CFS_ROOT/cfe/cmake/Makefile.sample $CFS_ROOT/Makefile
RUN cp -r $CFS_ROOT/cfe/cmake/sample_defs $CFS_ROOT/sample_defs


# RUN make -C $CFS_ROOT prep
#
# RUN make -C $CFS_ROOT
#
# RUN make -C $CFS_ROOT install

# Place test script in cFS directory
COPY ./docker-dir/test-cfs.sh $CFS_ROOT/test-cfs.sh
#
RUN chmod +x $CFS_ROOT/test-cfs.sh
