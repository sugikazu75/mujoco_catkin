cmake_minimum_required(VERSION 3.5)
set(MUJOCO_VERSION 3.3.5)
project(mujoco VERSION ${MUJOCO_VERSION})

find_package(catkin REQUIRED)

include(ExternalProject)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
  set(MUJOCO_ARCH "linux-x86_64")
  message(STATUS "Detected architecture: x86_64")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64")
  set(MUJOCO_ARCH "linux-aarch64")
  message(STATUS "Detected architecture: aarch64")
else()
  message(FATAL_ERROR "Unsupported architecture: ${CMAKE_SYSTEM_PROCESSOR}")
endif()

set(MUJOCO_URL "https://github.com/google-deepmind/mujoco/releases/download/${MUJOCO_VERSION}/mujoco-${MUJOCO_VERSION}-${MUJOCO_ARCH}.tar.gz")

ExternalProject_Add(
  mujoco
  URL ${MUJOCO_URL}
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/include ${CATKIN_DEVEL_PREFIX}/include
  COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/lib ${CATKIN_DEVEL_PREFIX}/lib
  COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/bin ${CATKIN_DEVEL_PREFIX}/lib/${PROJECT_NAME}
  )

file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/include/${PROJECT_NAME}) # Ensure include directory exists for install step
catkin_package(
  INCLUDE_DIRS ${CATKIN_DEVEL_PREFIX}/include
  LIBRARIES mujoco
  CFG_EXTRAS mujoco-extras.cmake
  )
