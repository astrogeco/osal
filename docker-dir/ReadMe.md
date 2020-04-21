## Build alpine image

```
docker build --tag cfs-bundle:alpine ./docker-dir/alpine/
```

## Run alpine image
```
docker run --mount src=$(pwd),dst=/${PWD##*/},type=bind --env CFS_COMPONENT=${PWD##*/} -it --rm cfs-bundle:alpine
```

then

```
cd cFS
make prep
make
make install
./cfs-test.sh
```

This currently breaks at the make step ~50%


## Build gcc image

```
docker build --tag cfs-bundle:gcc ./docker-dir/gcc-based/
```

## Run gcc image
```
docker run --mount src=$(pwd),dst=/${PWD##*/},type=bind --env CFS_COMPONENT=${PWD##*/} -it --rm cfs-bundle:gcc
```
then

```
cd cFS
make prep
make
make install
./cfs-test.sh
```
