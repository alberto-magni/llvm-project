# Main API.
add_mlir_library(MLIRCAPIIR
  AffineMap.cpp
  IR.cpp
  StandardAttributes.cpp
  StandardTypes.cpp
  Support.cpp

  EXCLUDE_FROM_LIBMLIR

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir-c

  LINK_LIBS PUBLIC
  MLIRIR
  MLIRParser
  MLIRSupport
  )
