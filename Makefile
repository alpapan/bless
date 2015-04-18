CC=mpicxx
PROG=bless
BOOST_LIB=/home/yunheo1/library/boost/v1p57p0/install/lib
CFLAGS=-Wall -O3 -I ./google-sparsehash -I ./kmc/kmc_api -fopenmp -std=c++11
LDFLAGS=-L $(BOOST_LIB) ./boost/libboost_filesystem.a ./boost/libboost_system.a ./boost/libboost_iostreams.a ./zlib/install/lib/libz.a -fopenmp -std=c++11

SRCS=kmc/kmc_api/kmc_file.cpp kmc/kmc_api/kmer_api.cpp kmc/kmc_api/mmer.cpp murmurhash3/MurmurHash3.cpp check_inputs.cpp correct_errors.cpp count_solid_kmers.cpp main.cpp parse_args.cpp
OBJS=$(SRCS:.cpp=.o)

$(PROG): $(OBJS)
	cd zlib; ./compile
	$(CC) $(OBJS) -o $@ $(LDFLAGS)
	cd kmc; make CC=$(CC)
	cd pigz/pigz-2.3.3; make

kmc/kmc_api/%.o: kmc/kmc_api/%.cpp
	$(CC) $(CFLAGS) -c $(DEF) $? -o $@

%.o: %.cpp
	$(CC) $(CFLAGS) -c $(DEF) $? -o $@

clean:
	rm -rf $(PROG) $(OBJS)
	cd kmc; make clean; cd ..
	cd zlib; rm -rf install; cd zlib-1.2.8; make clean; cd ../..
	cd pigz/pigz-2.3.3; make clean; cd ../..
