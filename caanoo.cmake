set (CAANOO_ROOT $ENV{CAANOO_ROOT})
if (NOT CAANOO_ROOT)
    message (FATAL_ERROR "Please set the CAANOO_ROOT environment variable to your SDK path.")
endif (NOT CAANOO_ROOT)

# Set the path to the toolchain
set (CAANOO_TOOLCHAIN ${CAANOO_ROOT}/tools/gcc-4.2.4-glibc-2.7-eabi)

# Set a flag to indicate that we are compiling for Caanoo
set (CAANOO TRUE)

# Set the system name
set (CMAKE_SYSTEM_NAME "Linux")

# Set the paths to the compilers
set (CMAKE_C_COMPILER    ${CAANOO_TOOLCHAIN}/bin/arm-gph-linux-gnueabi-gcc)
set (CMAKE_CXX_COMPILER  ${CAANOO_TOOLCHAIN}/bin/arm-gph-linux-gnueabi-g++)

# Define some compiler flags
add_definitions ("-fno-common")
add_definitions ("-march=armv5te")
add_definitions ("-mtune=arm9tdmi")
add_definitions ("-mapcs")
add_definitions ("-msoft-float")

# Define the root paths for searching files
set (SYS_ROOT ${CAANOO_TOOLCHAIN}/arm-gph-linux-gnueabi/sys-root)
set (CMAKE_FIND_ROOT_PATH ${SYS_ROOT})

# Search for programs in both target and host environments
set (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)

# Search for headers and libraries only in target environment
set (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)

# Tell CMake where to find the specific CMake modules for Caanoo development
set (CMAKE_MODULE_PATH ${CAANOO_ROOT}/cmake)
