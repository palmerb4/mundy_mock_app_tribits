FIND_PACKAGE(Kokkos REQUIRED
    CONFIG
    HINTS
      ${TPL_Kokkos_DIR}/lib/cmake/Kokkos
      ${TPL_Kokkos_DIR}
    COMPONENTS
      ${${PACKAGE_NAME}_Kokkos_REQUIRED_COMPONENTS}
    OPTIONAL_COMPONENTS
      ${${PACKAGE_NAME}_Kokkos_OPTIONAL_COMPONENTS}
)

# Create the TriBITS-compliant <tplName>Config.cmake wrapper file
# This appears to be the minimal requirement to load in a TriBITS-compliant TPL.
tribits_extpkgwit_create_package_config_file(
  Kokkos
  INNER_FIND_PACKAGE_NAME Kokkos
  IMPORTED_TARGETS_FOR_ALL_LIBS Kokkos::all_libs)
