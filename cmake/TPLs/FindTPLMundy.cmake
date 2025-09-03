FIND_PACKAGE(Mundy REQUIRED
    CONFIG
    HINTS
      ${TPL_Mundy_DIR}/lib/cmake/Mundy
      ${TPL_Mundy_DIR}
    COMPONENTS
      ${${PACKAGE_NAME}_Mundy_REQUIRED_COMPONENTS}
    OPTIONAL_COMPONENTS
      ${${PACKAGE_NAME}_Mundy_OPTIONAL_COMPONENTS}
)

# Create the TriBITS-compliant <tplName>Config.cmake wrapper file
# This appears to be the minimal requirement to load in a TriBITS-compliant TPL.
tribits_extpkgwit_create_package_config_file(
  Mundy
  INNER_FIND_PACKAGE_NAME Mundy
  IMPORTED_TARGETS_FOR_ALL_LIBS Mundy::all_libs)
