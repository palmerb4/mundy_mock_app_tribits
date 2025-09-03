cmake .. \
-DCMAKE_BUILD_TYPE=${BUILD_TYPE:-DEBUG} \
-DCMAKE_CXX_COMPILER=mpicxx \
-DCMAKE_CXX_FLAGS="-O3 -march=native" \
-DTPL_ENABLE_MPI=ON \
-DTPL_Mundy_DIR=~/envs/MundyScratch/ \
-DTPL_GTest_DIR=~/envs/MundyScratch/ \
-DSam_ENABLE_TESTS=On