#
# A) Define the package (assuming no subpackages)
#
tribits_package(Sam)

tribits_add_debug_option()

#
# B) Define the globals
#

# For some odd reason, our PACKAGE_SOURCE_DIR is not the current directory. It's ../ ??

# Global variables
GLOBAL_SET(Sam_DEFAULT_UNIT_TEST_MAIN
  "${PACKAGE_SOURCE_DIR}/sam/tests/unit_tests/DefaultUnitTestMain.cpp")

# For now, we enable all subpackages of Sam by default. They can be disabled by the user
# if they are not needed.
GLOBAL_SET(Sam_ENABLE_ALL_OPTIONAL_PACKAGES ON)

#
# C) Define the header and source files
#

# Headers are relative to the tribits_include_directory
# We don't recommend typing these by hand. Use 
# find include/ -type f -name "*.hpp" | sed 's/^.\/\///' | sort
# find src/ -type f -name "*.cpp" | sed 's/^.\/\///' | sort
SET(NOINSTALLHEADERS 
  sam/hello.hpp
  )

SET(SOURCES 
  sam/hello.cpp
  )

tribits_configure_file(${PACKAGE_NAME}_config.hpp)
tribits_include_directories(${PACKAGE_SOURCE_DIR})

#
# D) Add the libraries, tests, and examples
#

# Add a standard library
mundy_tribits_add_library(
  lib_sam
  HEADERS ${CMAKE_CURRENT_BINARY_DIR}/${PACKAGE_NAME}_config.hpp
  NOINSTALLHEADERS ${NOINSTALLHEADERS}
  DIRECTORIES ${PACKAGE_SOURCE_DIR}
  FILES_MATCHING PATTERN "*.hpp"
  SOURCES ${SOURCES}
  )

tribits_add_test_directories(${PACKAGE_SOURCE_DIR}/sam/tests
                             ${PACKAGE_SOURCE_DIR}/sam/examples)

#
# E) Do standard post processing
#

tribits_package_postprocess()
