# Copyright (c) 2021, 2024, Oracle and/or its affiliates.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License, version 2.0, as
# published by the Free Software Foundation.
#
# This program is designed to work with certain software (including
# but not limited to OpenSSL) that is licensed under separate terms, as
# designated in a particular file or component or in included license
# documentation. The authors of MySQL hereby grant you an additional
# permission to link the program and your derivative works with the
# separately licensed software that they have either included with
# the program or referenced in the documentation.
#
# Without limiting anything contained in the foregoing, this file,
# which is part of Connector/C++, is also subject to the
# Universal FOSS Exception, version 1.0, a copy of which can be found at
# https://oss.oracle.com/licenses/universal-foss-exception.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License, version 2.0, for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

#
# This is a cmake script that drives external builds configured using
# add_ext() command. See dependency.cmake.
#
# The build is done only once, protected by a stamp file.
#

#message("Build location: ${BIN_DIR}")
#message("Building config: ${CONFIG}")
#message("Build options: ${OPTS}")

set(stamp ${BIN_DIR}/build.${CONFIG}.stamp)


if(EXISTS ${stamp})
  return()
endif()

message("== Running extrnal build at: ${BIN_DIR} (${CONFIG})")

execute_process(
  COMMAND ${CMAKE_COMMAND} --build ${BIN_DIR} --config ${CONFIG} ${OPTS}
  RESULT_VARIABLE res
)

if(res)
  message(FATAL_ERROR
    "External build failed: ${res}"
  )
endif()

# Note: When minimal cmake version is upgraded to 3.12 then
# file(TOUCH) can be used instead.

file(WRITE ${stamp} "")

message("== Extrnal build done")

