FIND_PACKAGE(GTest REQUIRED
    HINTS
      ${TPL_GTest_DIR}/lib/cmake/GTest
      ${TPL_GTest_DIR}
)

tribits_extpkg_create_imported_all_libs_target_and_config_file(
  GTest
  INNER_FIND_PACKAGE_NAME GTest
  IMPORTED_TARGETS_FOR_ALL_LIBS GTest::gtest GTest::gtest_main GTest::gmock GTest::gmock_main)
