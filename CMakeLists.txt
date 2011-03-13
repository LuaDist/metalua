# Copyright (C) 2011 LuaDist.
# Submited by Michal Kottman
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

PROJECT(metalua NONE)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
INCLUDE(dist.cmake)

FIND_PACKAGE(Lua51 REQUIRED)
FIND_PROGRAM(LUA NAMES lua lua.bat)
FIND_PROGRAM(LUAC NAMES luac luac.bat)

SET(SRC ${CMAKE_CURRENT_SOURCE_DIR}/src)

if(UNIX)
    MESSAGE(STATUS "Compiling Metalua...")
    CONFIGURE_FILE(${SRC}/make.sh.in ${SRC}/make.sh @ONLY)
    EXECUTE_PROCESS(COMMAND chmod +x ${SRC}/make.sh)
    EXECUTE_PROCESS(COMMAND ${SRC}/make.sh WORKING_DIRECTORY ${SRC} RESULT_VARIABLE res OUTPUT_QUIET)

    CONFIGURE_FILE(${SRC}/metalua.in ${SRC}/metalua @ONLY)
else(UNIX)
    # TODO: Windows build
endif(UNIX)

INSTALL(PROGRAMS ${SRC}/metalua DESTINATION ${INSTALL_BIN})
INSTALL(DIRECTORY doc/ DESTINATION ${INSTALL_DOC})
INSTALL(FILES INSTALL.TXT LICENSE README.TXT DESTINATION ${INSTALL_DATA})
INSTALL(DIRECTORY src/samples DESTINATION ${INSTALL_DATA})

