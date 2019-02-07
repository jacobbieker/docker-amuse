FROM ubuntu:16.04

# Pull AMUSE from Github
RUN apt-get update && apt-get install -y git 
RUN apt-get install -y build-essential curl g++ gfortran gettext zlib1g-dev
RUN git clone https://github.com/amusecode/amuse.git

RUN mkdir /amuse/prerequisites

ENV PREFIX /amuse/prerequisites
ENV PATH ${PREFIX}/bin:${PATH}
ENV LD_LIBRARY_PATH ${PREFIX}/lib:${LD_LIBRARY_PATH}
ENV FC gfortran
ENV F77 gfortran

RUN cd /amuse/doc/install && ./install-python.sh 
RUN cd /amuse/doc/install && ./install.py install

RUN cd /amuse/ && ./configure

RUN cd /amuse/ && make

ENTRYPOINT ["/amuse/"]
CMD ["amuse"]
