cmake_minimum_required (VERSION 3.8.1)
project (TENSORFLOWTEST)

# enable c++ exceptions
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /EHsc")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /EHsc")
set(CMAKE_CXX_FLAGS_MINSIZEREL "${CMAKE_CXX_FLAGS_MINSIZEREL} /EHsc")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} /EHsc")

set(TENSORFLOW_ROOT_DIR "C:/Repos/tensorflow")
set(TENSORFLOW_BUILD_DIR ${TENSORFLOW_ROOT_DIR}/tensorflow/contrib/cmake/build)

include_directories(
	${TENSORFLOW_ROOT_DIR}
	${TENSORFLOW_ROOT_DIR}/tensorflow/contrib/cmake/build
	${TENSORFLOW_ROOT_DIR}/tensorflow/contrib/cmake/build/external/eigen_archive
	${TENSORFLOW_ROOT_DIR}/third_party/eigen3
	${TENSORFLOW_ROOT_DIR}/tensorflow/contrib/cmake/build/protobuf/src/protobuf/src
)

# Suppress compiler warnings
add_definitions(/wd4267 /wd4244 /wd4554)

set(TENSORFLOWTEST_SRCS
	main.cpp
)

set(TENSORFLOWTEST_HDRS
	main.h
)

add_executable(TENSORFLOWTEST ${TENSORFLOWTEST_SRCS} ${TENSORFLOWTEST_HDRS})

link_directories(${TENSORFLOW_BUILD_DIR})

target_link_libraries(TENSORFLOWTEST 
	${TENSORFLOW_BUILD_DIR}/zlib/install/lib/zlibstatic.lib
	${TENSORFLOW_BUILD_DIR}/gif/install/lib/giflib.lib
	${TENSORFLOW_BUILD_DIR}/png/install/lib/libpng12_static.lib
	${TENSORFLOW_BUILD_DIR}/lmdb/install/lib/lmdb.lib
	${TENSORFLOW_BUILD_DIR}/jsoncpp/src/jsoncpp/src/lib_json/$(Configuration)/jsoncpp.lib
	${TENSORFLOW_BUILD_DIR}/farmhash/install/lib/farmhash.lib
	${TENSORFLOW_BUILD_DIR}/fft2d/src/lib/fft2d.lib
	${TENSORFLOW_BUILD_DIR}/highwayhash/install/lib/highwayhash.lib
	${TENSORFLOW_BUILD_DIR}/protobuf/src/protobuf/$(Configuration)/libprotobuf.lib

	${TENSORFLOW_BUILD_DIR}/$(Configuration)/tf_protos_cc.lib
	${TENSORFLOW_BUILD_DIR}/tf_cc.dir/$(Configuration)/tf_cc.lib
	${TENSORFLOW_BUILD_DIR}/tf_cc_ops.dir/$(Configuration)/tf_cc_ops.lib
	${TENSORFLOW_BUILD_DIR}/tf_cc_framework.dir/$(Configuration)/tf_cc_framework.lib
	${TENSORFLOW_BUILD_DIR}/tf_core_cpu.dir/$(Configuration)/tf_core_cpu.lib
	${TENSORFLOW_BUILD_DIR}/tf_core_direct_session.dir/$(Configuration)/tf_core_direct_session.lib
	${TENSORFLOW_BUILD_DIR}/tf_core_framework.dir/$(Configuration)/tf_core_framework.lib
	${TENSORFLOW_BUILD_DIR}/tf_core_kernels.dir/$(Configuration)/tf_core_kernels.lib
	${TENSORFLOW_BUILD_DIR}/tf_core_lib.dir/$(Configuration)/tf_core_lib.lib
	${TENSORFLOW_BUILD_DIR}/tf_core_ops.dir/$(Configuration)/tf_core_ops.lib
	${TENSORFLOW_BUILD_DIR}/jpeg/install/lib/libjpeg.lib

	${TENSORFLOW_BUILD_DIR}/re2/install/lib/re2.lib
	${TENSORFLOW_BUILD_DIR}/nsync/src/nsync/$(Configuration)/nsync.lib
	${TENSORFLOW_BUILD_DIR}/snappy/src/snappy/$(Configuration)/snappy.lib
	${TENSORFLOW_BUILD_DIR}/sqlite/src/sqlite-build/$(Configuration)/sqlite.lib
	${TENSORFLOW_BUILD_DIR}/tf_cc_while_loop.dir/$(Configuration)/tf_cc_while_loop.lib
)

set_target_properties(TENSORFLOWTEST PROPERTIES LINK_FLAGS 
	"/ignore:4217 /ignore:4049
	/WHOLEARCHIVE:tf_cc.lib 
	/WHOLEARCHIVE:tf_cc_framework.lib
	/WHOLEARCHIVE:tf_cc_ops.lib 
	/WHOLEARCHIVE:tf_core_cpu.lib
	/WHOLEARCHIVE:tf_core_direct_session.lib 
	/WHOLEARCHIVE:tf_core_framework.lib
	/WHOLEARCHIVE:tf_core_lib.lib
	/WHOLEARCHIVE:tf_core_ops.lib 
	/WHOLEARCHIVE:libjpeg.lib 
	/WHOLEARCHIVE:tf_core_kernels.lib"
)