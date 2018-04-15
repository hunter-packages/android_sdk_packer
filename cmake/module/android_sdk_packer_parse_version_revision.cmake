# Copyright (c) 2018, Ruslan Baratov
# All rights reserved.

include(CMakeParseArguments)

function(android_sdk_packer_parse_version_revision)
  set(one FULL VERSION REVISION)
  cmake_parse_arguments(x "" "${one}" "" "${ARGV}")
  # x_FULL (in) full string with version (e.g. '22_r01')
  # x_VERSION (out)
  # x_REVISION (out)

  string(COMPARE EQUAL "${x_FULL}" "" is_empty)
  if(is_empty)
    message(FATAL_ERROR "Expected FULL")
  endif()

  string(COMPARE EQUAL "${x_VERSION}" "" is_empty)
  if(is_empty)
    message(FATAL_ERROR "Expected VERSION")
  endif()

  string(COMPARE EQUAL "${x_REVISION}" "" is_empty)
  if(is_empty)
    message(FATAL_ERROR "Expected REVISION")
  endif()

  string(COMPARE NOTEQUAL "${x_UNPARSED_ARGUMENTS}" "" has_unparsed)
  if(has_unparsed)
    message(FATAL_ERROR "Unparsed: ${x_UNPARSED_ARGUMENTS}")
  endif()

  if(NOT x_FULL MATCHES "^([0-9]+)_r([0-9]+)$")
    message(FATAL_ERROR "Incorrect version: ${x_FULL}")
  endif()

  set(version "${CMAKE_MATCH_1}")
  set(revision "${CMAKE_MATCH_2}")

  string(REGEX REPLACE "^0" "" revision "${revision}") # 01 -> 1

  set("${x_VERSION}" "${version}" PARENT_SCOPE)
  set("${x_REVISION}" "${revision}" PARENT_SCOPE)
endfunction()
