# Copyright (c) 2018, Ruslan Baratov
# All rights reserved.

include(CMakeParseArguments)

function(android_sdk_packer_unified_install)
  cmake_parse_arguments(x "" "DESTINATION" "OBJECTS" ${ARGV})
  # -> x_DESTINATION
  # -> x_OBJECTS

  string(COMPARE NOTEQUAL "${x_UNPARSED_ARGUMENTS}" "" has_unparsed)
  if(has_unparsed)
    message(FATAL_ERROR "Unparsed: ${x_UNPARSED_ARGUMENTS}")
  endif()

  set(dest "android-sdk/${x_DESTINATION}")

  foreach(object ${x_OBJECTS})
    if(NOT EXISTS "${object}")
      message(FATAL_ERROR "Object not exists: ${object}")
    endif()
    if(IS_DIRECTORY "${object}")
      install(DIRECTORY "${object}" DESTINATION "${dest}")
    else()
      install(
          FILES "${object}"
          DESTINATION "${dest}"
          PERMISSIONS
              OWNER_WRITE
              OWNER_READ GROUP_READ WORLD_READ
              OWNER_EXECUTE GROUP_EXECUTE WORLD_EXECUTE
      )
    endif()
  endforeach()
endfunction()
