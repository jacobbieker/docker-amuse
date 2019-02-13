FROM nvidia/cuda:10.0-devel-ubuntu16.04

# Pull AMUSE from Github
RUN apt-get update && apt-get install -y git wget
RUN apt-get install -y build-essential curl g++ gfortran gettext zlib1g-dev
#RUN git clone https://github.com/amusecode/amuse.git

RUN wget https://github.com/amusecode/amuse/archive/release-11.2.tar.gz
RUN tar -xf release-11.2.tar.gz
RUN mv amuse-release-11.2/ /amuse/

RUN apt-get install -y build-essential gfortran python3-dev \
  mpich libmpich-dev \
  libgsl0-dev cmake libfftw3-3 libfftw3-dev \
  libgmp3-dev libmpfr4 libmpfr-dev \
  libhdf5-serial-dev hdf5-tools \
  python3-nose python3-numpy python3-setuptools python3-docutils \
  python3-h5py python3-setuptools git openjdk-8-jdk python3-pip

RUN pip3 install cython scipy matplotlib mpi4py
RUN pip3 install numpy

ENV FC gfortran
ENV F77 gfortran

RUN whereis python3
RUN cd /amuse/ && ./configure --enable-cuda PYTHON=/usr/bin/python3 --with-hdf5=/usr/lib/x86_64-linux-gnu/hdf5/serial

RUN cd /amuse/ && make build3 DOWNLOAD_CODES=1

RUN cd /amuse/ && python3 setup.py install

ENV PATH /amuse/:${PATH}
CMD ["python3"]
