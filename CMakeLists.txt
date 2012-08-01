# Copyright (C) 2011 LuaDist.
# Submited by Michal Kottman, Peter Drahos
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( metalua NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

find_program ( LUA NAMES lua lua.bat )
find_program ( LUAC NAMES luac luac.bat )

set ( SRC ${CMAKE_CURRENT_SOURCE_DIR}/src )
set ( BIN ${CMAKE_CURRENT_BINARY_DIR} )
set ( LIB ${BIN}/lib )

file ( COPY ${SRC}/lib/ DESTINATION ${LIB} )

add_custom_target ( bootstrap ALL COMMAND ${LUAC} -o ${LIB}/metalua/bytecode.lua 
  ${SRC}/compiler/lopcodes.lua ${SRC}/compiler/lcode.lua ${SRC}/compiler/ldump.lua 
  ${SRC}/compiler/compile.lua COMMAND ${LUAC} -o ${LIB}/metalua/mlp.lua ${SRC}/compiler/lexer.lua 
  ${SRC}/compiler/gg.lua ${SRC}/compiler/mlp_lexer.lua ${SRC}/compiler/mlp_misc.lua 
  ${SRC}/compiler/mlp_table.lua ${SRC}/compiler/mlp_meta.lua ${SRC}/compiler/mlp_expr.lua 
  ${SRC}/compiler/mlp_stat.lua ${SRC}/compiler/mlp_ext.lua COMMAND ${LUA} ${SRC}/build-utils/bootstrap.lua 
  ${SRC}/compiler/mlc.mlua output=${LIB}/metalua/mlc.lua COMMAND ${LUA} ${SRC}/build-utils/bootstrap.lua 
  ${SRC}/compiler/metalua.mlua output=${LIB}/metalua.lua COMMAND ${LUA} ${LIB}/metalua.lua 
  -vb -f ${SRC}/compiler/mlc.mlua -o ${LIB}/metalua/mlc.lua COMMAND ${LUA} ${LIB}/metalua.lua 
  -vb -f ${SRC}/compiler/metalua.mlua -o ${LIB}/metalua.lua WORKING_DIRECTORY ${LIB} 
  VERBATIM )

file ( GLOB_RECURSE SRCS RELATIVE ${LIB} "${LIB}/*.mlua" )
foreach ( S ${SRCS} )
get_filename_component ( P ${S} PATH )
get_filename_component ( D ${S} NAME_WE )
add_custom_command ( OUTPUT ${P}/${D}.lua COMMAND ${LUA} ${LIB}/metalua.lua ${S} -o ${P}/${D}.lua WORKING_DIRECTORY ${LIB} DEPENDS bootstrap )
endforeach ( )

install_lua_executable ( metalua ${LIB}/metalua.lua )
add_dependencies ( metalua bootstrap )

install ( DIRECTORY ${LIB}/ DESTINATION ${INSTALL_LMOD} COMPONENT Runtime PATTERN "*.in" EXCLUDE )
install_doc ( doc/ )
install_foo ( junk/ )
install_data ( INSTALL.TXT README.TXT LICENSE )
