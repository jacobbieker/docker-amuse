FROM ubuntu:16.04

# Pull AMUSE from Github
RUN apt-get update && apt-get install -y git wget
RUN apt-get install -y build-essential curl g++ gfortran gettext zlib1g-dev
#RUN git clone https://github.com/amusecode/amuse.git

RUN wget https://github.com/amusecode/amuse/archive/release-11.2.tar.gz
RUN tar -xf release-11.2.tar.gz
RUN mv amuse-release-11.2/ /amuse/

RUN apt-get install -y build-essential gfortran python-dev \
  mpich libmpich-dev \
  libgsl0-dev cmake libfftw3-3 libfftw3-dev \
  libgmp3-dev libmpfr4 libmpfr-dev \
  libhdf5-serial-dev hdf5-tools \
  python-nose python-numpy python-setuptools python-docutils \
  python-h5py python-setuptools git openjdk-8-jdk python-pip

RUN pip install cython
RUN easy_install mpi4py

#RUN mkdir /amuse/prerequisites

#ENV PREFIX /amuse/prerequisites
#ENV PATH ${PREFIX}/bin:${PATH}
#ENV LD_LIBRARY_PATH ${PREFIX}/lib:${LD_LIBRARY_PATH}
ENV FC gfortran
ENV F77 gfortran

#RUN cd /amuse/doc/install && ./install-python.sh 
#RUN cd /amuse/doc/install && ./install.py install

RUN cd /amuse/ && ./configure

RUN cd /amuse/ && make

RUN cd /amuse/ && mpiexec nosetests -v

ENTRYPOINT ["/amuse/"]
CMD ["amuse.sh"]
