cmake_minimum_required(VERSION 3.5)
set(MUJOCO_VERSION 3.3.5)
project(mujoco VERSION ${MUJOCO_VERSION})

find_package(catkin REQUIRED)

include(ExternalProject)

ExternalProject_Add(
  mujoco
  GIT_REPOSITORY https://github.com/google-deepmind/mujoco.git
  GIT_TAG ${MUJOCO_VERSION}
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CATKIN_DEVEL_PREFIX}
  )

file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/include/${PROJECT_NAME}) # Ensure include directory exists for install step
catkin_package(
  INCLUDE_DIRS ${CATKIN_DEVEL_PREFIX}/include/${PROJECT_NAME}
  LIBRARIES mujoco
  CFG_EXTRAS mujoco-extras.cmake
  )

file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/lib/${PROJECT_NAME})
add_custom_command(TARGET mujoco
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_directory ${CATKIN_DEVEL_PREFIX}/bin
  ${CATKIN_DEVEL_PREFIX}/lib/${PROJECT_NAME}
  COMMENT "Copying mujoco binaries to catkin package lib directory for rosrun"
  )

install(DIRECTORY ${CATKIN_DEVEL_PREFIX}/include/mujoco
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  )

install(DIRECTORY ${CATKIN_DEVEL_PREFIX}/lib
  DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  )

install(DIRECTORY ${CATKIN_DEVEL_PREFIX}/bin
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
  )
