if(NOT TARGET mujoco::mujoco)
  add_library(mujoco::mujoco INTERFACE IMPORTED)

  set_target_properties(mujoco::mujoco PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${mujoco_INCLUDE_DIRS}"
    INTERFACE_LINK_LIBRARIES "${mujoco_LIBRARIES}"
  )
endif()
