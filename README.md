PyCharm in Docker
=================

There are a couple of reasons for running PyCharm in Docker:
1) To minimize the impact of installing backdoored packages.
2) To make it easier to investigate when you or the IDE installs packages by mistake/bugs (I'm looking at you PyCharm).
3) To always start from a clean environment with better control over which libs and versions are used.
4) To be able to use the IDE in offline mode, if needed, to avoid leaking sensitive info etc (answer No when starting).

Building the image
-------------------------

1. `$ docker build . -t localhost/pycharm:latest`

### Installation 
Copy the script `pycharm` to somewhere in your `$PATH` such as `/usr/local/bin` and start by running `$ pycharm your_code_dir`

### Replace pycharms typing with a updated version, needed for example with the 'redis' lib
Add this to the Dockerfile

RUN echo "Fix for some type annotations, for example in the redis package" \
  && echo "https://github.com/redis/redis-py/issues/2249#issuecomment-1172943002" \
  && cd /opt/pycharm/plugins/python-ce/helpers/ && rm -rf typeshed && git clone https://github.com/python/typeshed.git
