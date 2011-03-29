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

message ( STATUS "Preparing the metalua libraries" )

file ( COPY ${SRC}/lib/ DESTINATION ${LIB} PATTERN ".in" EXCLUDE )
configure_file ( ${SRC}/lib/metalua/package2.lua.in ${LIB}/metalua/package2.lua )
configure_file ( ${SRC}/compiler/metalua.mlua.in ${LIB}/metalua.mlua )

message ( STATUS "Compiling the parts of the compiler written in plain Lua" )

execute_process (
  COMMAND ${LUAC} -o ${LIB}/metalua/bytecode.luac
    lopcodes.lua lcode.lua ldump.lua compile.lua
  COMMAND ${LUAC} -o ${LIB}/metalua/mlp.luac
    lexer.lua gg.lua mlp_lexer.lua mlp_misc.lua mlp_table.lua mlp_meta.lua mlp_expr.lua mlp_stat.lua mlp_ext.lua
  WORKING_DIRECTORY ${SRC}/compiler )

message ( STATUS "Bootstrap the parts of the compiler written in metalua" )

execute_process (
  COMMAND ${LUA} ${SRC}/build-utils/bootstrap.lua ${SRC}/compiler/mlc.mlua output=${LIB}/metalua/mlc.luac
  COMMAND ${LUA} ${SRC}/build-utils/bootstrap.lua ${LIB}/metalua.mlua output=${LIB}/metalua.luac
  WORKING_DIRECTORY ${LIB} )

message ( STATUS "Finish the bootstrap: recompile the metalua parts of the compiler with itself" )
  
execute_process (
  COMMAND ${LUA} ${LIB}/metalua.luac -vb -f ${SRC}/compiler/mlc.mlua -o ${LIB}/metalua/mlc.luac
  COMMAND ${LUA} ${LIB}/metalua.luac -vb -f ${LIB}/metalua.mlua -o ${LIB}/metalua.luac
  WORKING_DIRECTORY ${LIB} )

message ( STATUS "Precompile metalua libraries" )

file ( GLOB_RECURSE SRCS RELATIVE ${LIB} "${LIB}/*.mlua")
foreach ( S ${SRCS} )
  get_filename_component ( P ${S} PATH )
  get_filename_component ( D ${S} NAME_WE )
  message ( STATUS "Compiling ${S} to ${P}/${D}.luac" )
  execute_process (
    COMMAND ${LUA} ${LIB}/metalua.luac ${S} -o ${P}/${D}.luac
    WORKING_DIRECTORY ${LIB} )
endforeach ( S )

install_lua_executable ( metalua ${LIB}/metalua.luac )
install ( DIRECTORY ${LIB}/ DESTINATION ${INSTALL_LMOD} PATTERN "*.in" EXCLUDE)
install_doc ( doc/ )
install_foo ( junk/ )
install_data ( INSTALL.TXT README.TXT LICENSE )