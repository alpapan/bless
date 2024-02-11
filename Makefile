CC = mpicc
CXX = mpicxx
PROG = bless

BLESS_PATH := $(shell conda env list -q | grep '*' | awk '{print $$3}')

CFLAGS = -O3 -I$(BLESS_PATH)/include -I./klib -fopenmp
CXXFLAGS = $(CFLAGS) -std=c++11

LDFLAGS = -L$(BLESS_PATH)/lib -lboost_iostreams -lboost_filesystem -lboost_system -lkmc -lz -lcurl -ldl

CSRC = $(wildcard klib/*.c)
CPPSRC = murmurhash3/src/MurmurHash3.cpp src/check_inputs.cpp src/correct_errors.cpp src/count_solid_kmers.cpp src/main.cpp src/parse_args.cpp

COBJ = $(CSRC:.c=.o)
CPPOBJ = $(CPPSRC:.cpp=.o)
OBJS = $(COBJ) $(CPPOBJ)

$(PROG): $(OBJS)
	$(CXX) -fopenmp $(OBJS) -o $@ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(PROG) $(OBJS)
