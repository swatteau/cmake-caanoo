# CMake module to find the DaVinci Game Engine (DGE)
#
# This module defines the following variables:
#
#   DGE_FOUND         - was DGE found?
#   DGE_INCLUDE_DIR   - the DGE include directory
#   DGE_LIBRARIES     - DGE libraries
#

# Depending on whether we are cross-compiling or not, we need to set the
# appropriate compiler flags and location for the libraries
if (CMAKE_CROSSCOMPILING)
    add_definitions ("-D_GPH_CAANOO_")
    set (_lib_subdir "target")
else ()
    add_definitions ("-D_PC_LINUX_")
    set (_lib_subdir "host")
endif ()

# This macro finds a particular DGE library
macro (_find_dge_library _var)
    find_library (${_var}
        NAMES ${ARGN}
        PATHS $ENV{GPH_SDK_ROOT}/DGE/lib
              $ENV{GPH_SDK_ROOT}/lib
        PATH_SUFFIXES ${_lib_subdir}
        NO_CMAKE_FIND_ROOT_PATH
        NO_DEFAULT_PATH
    )
    mark_as_advanced (${_var})
endmacro ()

# Find all the DGE libraries
_find_dge_library (DGE_DGT_LIBRARY       dgt20)
_find_dge_library (DGE_DGX_LIBRARY       dgx20)
_find_dge_library (DGE_DGE_LIBRARY       dge20)
_find_dge_library (DGE_LUA_LIBRARY       lua503)
_find_dge_library (DGE_OPENAL_LIBRARY    openal11)
_find_dge_library (DGE_OPENALUT_LIBRARY  openalut11)
_find_dge_library (Z_LIBRARY             z)
_find_dge_library (PNG_LIBRARY           png)
_find_dge_library (FREETYPE_LIBRARY      freetype)
list (APPEND _dge_libs
    DGE_DGT_LIBRARY DGE_DGX_LIBRARY DGE_DGE_LIBRARY
    DGE_LUA_LIBRARY DGE_OPENAL_LIBRARY DGE_OPENALUT_LIBRARY
    Z_LIBRARY PNG_LIBRARY FREETYPE_LIBRARY)

if (CMAKE_CROSSCOMPILING)
    _find_dge_library (DGE_INKADRM_LIBRARY        inkadrm)
    _find_dge_library (DGE_DRMCODE_LIBRARY        drmcode)
    _find_dge_library (DGE_GLPORT_LIBRARY         glport)
    _find_dge_library (DGE_OPENGLES_LITE_LIBRARY  opengles_lite)
    _find_dge_library (TS_LIBRARY                 ts)
    list (APPEND _dge_libs DGE_INKADRM_LIBRARY DGE_DRMCODE_LIBRARY
        DGE_GLPORT_LIBRARY DGE_OPENGLES_LITE_LIBRARY TS_LIBRARY)
else ()
    find_package (OpenGL)
    if (OPENGL_FOUND)
        list (APPEND _dge_libs OPENGL_LIBRARIES)
    endif ()
endif ()

# Find the Pthreads library
set (CMAKE_THREAD_PREFER_PTHREADS TRUE)
find_package (Threads)
if (Threads_FOUND AND CMAKE_USE_PTHREADS_INIT)
    list (APPEND _dge_libs CMAKE_THREAD_LIBS_INIT)
endif ()

# Find the include directories
find_path (DGE_INCLUDE_DIR DGE_Base.h
    PATHS $ENV{GPH_SDK_ROOT}/DGE/include
    NO_CMAKE_FIND_ROOT_PATH
)
mark_as_advanced (DGE_INCLUDE_DIR)

# handle the QUIETLY and REQUIRED arguments and set DGE_FOUND to TRUE if
# all listed variables are TRUE
include (FindPackageHandleStandardArgs)
find_package_handle_standard_args (DGE DEFAULT_MSG
    ${_dge_libs}
    DGE_INCLUDE_DIR
)

if (DGE_FOUND)
    # Define the needed variables
    foreach (_lib ${_dge_libs})
        list (APPEND DGE_LIBRARIES ${${_lib}})
    endforeach ()
endif ()
