FROM gcc:7.4.0

RUN wget https://github.com/Kitware/CMake/releases/download/v3.15.5/cmake-3.15.5-Linux-x86_64.sh \
      -q -O /tmp/cmake-install.sh \
      && chmod u+x /tmp/cmake-install.sh \
      && mkdir /usr/bin/cmake \
      && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
      && rm /tmp/cmake-install.sh

ENV PATH="/usr/bin/cmake/bin:${PATH}"


# Force image rebuild if bundle has changed since last build 
ADD https://api.github.com/repos/nasa/cfs/git/refs/heads/master version.json

# Get current bundle
RUN git clone --recurse-submodules -j8 https://github.com/nasa/cFS.git

ENV \
  BUILDTYPE=debug \
  CFS_ROOT=/cFS \
  ENABLE_UNIT_TESTS=true \
  OMIT_DEPRECATED=false \
  SIMULATION=native


RUN cp $CFS_ROOT/cfe/cmake/Makefile.sample $CFS_ROOT/Makefile

RUN cp -r $CFS_ROOT/cfe/cmake/sample_defs $CFS_ROOT/sample_defs

RUN make -C $CFS_ROOT prep

RUN make -C $CFS_ROOT

RUN make -C $CFS_ROOT install

COPY ./test-cfs.sh $CFS_ROOT/test-cfs.sh

RUN chmod +x $CFS_ROOT/test-cfs.sh
