# Copyright (C) 2011 LuaDist.
# Submited by Michal Kottman
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( metalua NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( dist.cmake )

find_package ( Lua51 REQUIRED )
find_program ( LUA NAMES lua lua.bat )
find_program ( LUAC NAMES luac luac.bat )

set ( SRC ${CMAKE_CURRENT_SOURCE_DIR}/src )
set ( BIN ${CMAKE_CURRENT_BINARY_DIR})
set ( LIB ${BIN}/lib )

message ( STATUS "Compiling metalua" )

file ( COPY ${SRC}/lib/ DESTINATION ${LIB} PATTERN ".in" EXCLUDE )
configure_file ( ${SRC}/lib/metalua/package2.lua.in ${LIB}/metalua/package2.lua )
configure_file ( ${SRC}/compiler/metalua.mlua.in ${BIN}/metalua.mlua )

execute_process (
  COMMAND ${LUAC} -o ${LIB}/metalua/bytecode.luac
    lopcodes.lua lcode.lua ldump.lua compile.lua
  WORKING_DIRECTORY ${SRC}/compiler )

execute_process (
  COMMAND ${LUAC} -o ${LIB}/metalua/mlp.luac
    lexer.lua gg.lua mlp_lexer.lua mlp_misc.lua mlp_table.lua mlp_meta.lua mlp_expr.lua mlp_stat.lua mlp_ext.lua
  WORKING_DIRECTORY ${SRC}/compiler )

execute_process (
  COMMAND ${LUA} ${SRC}/build-utils/bootstrap.lua
    ${SRC}/compiler/mlc.mlua output=${LIB}/metalua/mlc.luac
  WORKING_DIRECTORY ${SRC}/lib )

execute_process (
  COMMAND ${LUA} ${SRC}/build-utils/bootstrap.lua
    ${BIN}/metalua.mlua output=${LIB}/metalua.luac
  WORKING_DIRECTORY ${SRC}/lib )

# TODO:
#call %DISTRIB_BIN%\metalua -vb -f compiler\mlc.mlua     -o %DISTRIB_LIB%\metalua\mlc.luac
#call %DISTRIB_BIN%\metalua -vb -f compiler\metalua.mlua -o %DISTRIB_LIB%\metalua.luac
#%LUA% %BASE%\build-utils\precompile.lua directory=%DISTRIB_LIB% command=%DISTRIB_BIN%\metalua

install ( DIRECTORY ${LIB}/ DESTINATION ${INSTALL_LMOD} PATTERN "*.in" EXCLUDE)
install_lua_executable ( metalua ${BIN}/lib/metalua.luac )
install_doc ( doc/ )
install_foo ( junk/ )
install_data ( INSTALL.TXT README.TXT LICENSE )