# @HEADER
# ************************************************************************
#
#            TriBITS: Tribal Build, Integrate, and Test System
#                    Copyright 2013 Sandia Corporation
#
# Under the terms of Contract DE-AC04-94AL85000 with Sandia Corporation,
# the U.S. Government retains certain rights in this software.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
#
# 3. Neither the name of the Corporation nor the names of the
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY SANDIA CORPORATION "AS IS" AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL SANDIA CORPORATION OR THE
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ************************************************************************
# @HEADER


include(CMakeParseArguments)


# @FUNCTION: mundy_tribits_install_headers()
#
# Function used to (optionally) install header files using ``install()``
# command.
#
# Usage::
#
#   mundy_tribits_install_headers(
#     HEADERS <h0> <h1> ...
#     [INSTALL_SUBDIR <subdir>]
#     [COMPONENT <component>]
#     )
#
# The formal arguments are:
#
#   ``HEADERS <h0> <h1> ...``
#
#     List of header files to install.  By default, these header files are
#     assumed to be in the current source directory.  They can also contain
#     the relative path or absolute path to the files if they are not in the
#     current source directory.
#
#   ``INSTALL_SUBDIR <subdir>``
#
#     Optional subdirectory that the headers will be installed under the
#     standard installation directory.  If ``<subdir>!=""``, then the headers
#     will be installed under
#     ``${PROJECT_NAME}_INSTALL_INCLUDE_DIR}/<subdir>``.  Otherwise, they will
#     be installed under ``${PROJECT_NAME}_INSTALL_INCLUDE_DIR}/``.
#
#   ``COMPONENT <component>``
#
#     If specified, then ``COMPONENT <component>`` will be passed into
#     ``install()``.  Otherwise, ``COMPONENT ${PROJECT_NAME}`` will get used.
#
# If `${PROJECT_NAME}_INSTALL_LIBRARIES_AND_HEADERS`_ is ``FALSE``, then the
# headers will not get installed.
#
function(mundy_tribits_install_directories)

  if (${PROJECT_NAME}_VERBOSE_CONFIGURE)
    set(TRIBITS_INSTALL_DIRECTORIES_DEBUG_DUMP  TRUE)
  endif()

  if (TRIBITS_INSTALL_DIRECTORIES_DEBUG_DUMP)
    message("\nTRIBITS_INSTALL_DIRECTORIES: ${ARGN}")
  endif()

  cmake_parse_arguments(
    #prefix
    PARSE
    #Options
    "FILES_MATCHING"
    #one_value_keywords
    ""
    #multi_value_keywords
    "DIRECTORIES;INSTALL_SUBDIR;PATTERN;REGEX;EXCLUDE_PATTERN;EXCLUDE_REGEX;PERMISSIONS;COMPONENT"
    ${ARGN}
    )

  tribits_check_for_unparsed_arguments()

  # ToDo: Assert PARSE_INSTALL_DIR has 0 or 1 arguments!
  # ToDo: Assert PARSE_COMPONENT has 0 or 1 arguments!

  if (PARSE_INSTALL_SUBDIR)
    set(INSTALL_DIR "${${PROJECT_NAME}_INSTALL_INCLUDE_DIR}/${PARSE_INSTALL_SUBDIR}")
  else()
    set(INSTALL_DIR "${${PROJECT_NAME}_INSTALL_INCLUDE_DIR}")
  endif()

  if (PARSE_COMPONENT)
    set(COMPONENT ${PARSE_COMPONENT})
  else()
    set(COMPONENT ${PROJECT_NAME})
  endif()

  if (${PROJECT_NAME}_INSTALL_LIBRARIES_AND_HEADERS)
    if (TRIBITS_INSTALL_DIRECTORIES_DEBUG_DUMP)
      message("\nTRIBITS_INSTALL_DIRECTORIES: Installing directories into '${INSTALL_DIR}'")
    endif()
    
    # Install the given directories into the install directory
    set(install_directories_optional_args "")

    if (PARSE_FILES_MATCHING)
      list(APPEND install_directories_optional_args FILES_MATCHING)
      
      if ((PARSE_PATTERN OR PARSE_EXCLUDE_PATTERN) AND (PARSE_REGEX OR PARSE_EXCLUDE_REGEX))
        message(FATAL_ERROR "The PATTERN and REGEX tokens of FILES_MATCHING (and their EXCLUDE counterparts) are mutually exclusive. Please specify only patterns OR regexes.")
      endif()

      if (PARSE_PATTERN)
        list(APPEND install_directories_optional_args PATTERN ${PARSE_PATTERN})
      endif()
      if (PARSE_EXCLUDE_PATTERN)
        list(APPEND install_directories_optional_args PATTERN ${PARSE_EXCLUDE_PATTERN} EXCLUDE)
      endif()
      if (PARSE_REGEX)
        list(APPEND install_directories_optional_args REGEX ${PARSE_REGEX})
      endif()
      if (PARSE_EXCLUDE_REGEX)
        list(APPEND install_directories_optional_args REGEX ${PARSE_EXCLUDE_REGEX} EXCLUDE)
      endif()
      if (PARSE_PERMISSIONS)
        list(APPEND install_directories_optional_args PERMISSIONS ${PARSE_PERMISSIONS})
      endif()
    endif()  
    
    install(
      DIRECTORY ${PARSE_DIRECTORIES}
      DESTINATION "${INSTALL_DIR}"
      COMPONENT ${COMPONENT}
      ${install_directories_optional_args}
      )
    endif()  

endfunction()