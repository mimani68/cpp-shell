# synatx
# -----------------
# https://www3.ntu.edu.sg/home/ehchua/programming/cpp/gcc_make.html#zz-2.2
# -----------------
# 
# target: pre-req-1 pre-req-2 ...
# 	command
# 
# or
# 
# target1 [target2 ...]: [pre-req-1 pre-req-2 ...]
# 	[command1
# 	 command2
# 	 ......]

all: build

build: clean
	g++ -Wall -g -std=c++11 -O3 -Iinclude -o main main.cpp
	# cp main ~/Desktop/
	# ~/Desktop/main

build-wasm: clean
	emcc -O3 -s WASM=1 -s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap"]' \
    -I libwebp \
    main.cpp \
    libwebp/src/{dec,dsp,demux,enc,mux,utils}/*.cpp

clean:
	rm -rf main