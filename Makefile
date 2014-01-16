CC = clang
CPP = clang++
CFLAGS = -Wall -c
OFLAGS = -lprotobuf
PROTOC = protoc
PROTOHDRS = fluct_site_bid_request.pb.h fluct_app_bid_request.pb.h fluct_bid_response.pb.h
PROTOSRCS = fluct_site_bid_request.pb.cc fluct_app_bid_request.pb.cc fluct_bid_response.pb.cc
OBJECTS = fluct_site_bid_request.pb.o fluct_app_bid_request.pb.o fluct_bid_response.pb.o test.o
TARGETS = test.out

all: ${TARGETS}

%.pb.h: %.proto
	${PROTOC} --cpp_out=. $^

%.pb.cc: %.proto
	${PROTOC} --cpp_out=. $^

fluct_site_bid_request.pb.o: fluct_site_bid_request.pb.h fluct_site_bid_request.pb.cc
	${CPP} ${CFLAGS} -o $@ fluct_site_bid_request.pb.cc

fluct_app_bid_request.pb.o: fluct_app_bid_request.pb.h fluct_app_bid_request.pb.cc
	${CPP} ${CFLAGS} -o $@ fluct_app_bid_request.pb.cc

fluct_bid_response.pb.o: fluct_bid_response.pb.h fluct_bid_response.pb.cc
	${CPP} ${CFLAGS} -o $@ fluct_bid_response.pb.cc

test.o: test.cc ${PROTOHDRS}
	${CPP} ${CFLAGS} -o $@ test.cc

test.out: ${OBJECTS}
	${CPP} ${OFLAGS} -o $@ $^

clean:
	rm -f *.bin
	rm -f ${PROTOSRCS} ${PROTOHDRS} ${OBJECTS} ${TARGETS}
