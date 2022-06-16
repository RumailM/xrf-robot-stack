# Install script for directory: /home/r/tool_ws/src/iiwa_stack/iiwa_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/r/tool_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/r/tool_ws/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/r/tool_ws/install" TYPE PROGRAM FILES "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/r/tool_ws/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/r/tool_ws/install" TYPE PROGRAM FILES "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/r/tool_ws/install/setup.bash;/home/r/tool_ws/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/r/tool_ws/install" TYPE FILE FILES
    "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/setup.bash"
    "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/r/tool_ws/install/setup.sh;/home/r/tool_ws/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/r/tool_ws/install" TYPE FILE FILES
    "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/setup.sh"
    "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/r/tool_ws/install/setup.zsh;/home/r/tool_ws/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/r/tool_ws/install" TYPE FILE FILES
    "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/setup.zsh"
    "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/r/tool_ws/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/r/tool_ws/install" TYPE FILE FILES "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/.rosinstall")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/iiwa_msgs/msg" TYPE FILE FILES
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/CartesianControlModeLimits.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/CartesianEulerPose.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/CartesianImpedanceControlMode.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/CartesianPlane.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/CartesianPose.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/CartesianQuantity.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/CartesianVelocity.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/CartesianWrench.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/ControlMode.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/DOF.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/DesiredForceControlMode.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/JointDamping.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/JointImpedanceControlMode.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/JointPosition.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/JointPositionVelocity.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/JointQuantity.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/JointStiffness.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/JointTorque.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/JointVelocity.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/RedundancyInformation.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/SinePatternControlMode.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/Spline.msg"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/msg/SplineSegment.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/iiwa_msgs/srv" TYPE FILE FILES
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/srv/ConfigureControlMode.srv"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/srv/SetEndpointFrame.srv"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/srv/SetPTPCartesianSpeedLimits.srv"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/srv/SetPTPJointSpeedLimits.srv"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/srv/SetSmartServoJointSpeedLimits.srv"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/srv/SetSmartServoLinSpeedLimits.srv"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/srv/SetSpeedOverride.srv"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/srv/SetWorkpiece.srv"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/srv/TimeToDestination.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/iiwa_msgs/action" TYPE FILE FILES
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/action/MoveAlongSpline.action"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/action/MoveToCartesianPose.action"
    "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/action/MoveToJointPosition.action"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/iiwa_msgs/msg" TYPE FILE FILES
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveAlongSplineAction.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveAlongSplineActionGoal.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveAlongSplineActionResult.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveAlongSplineActionFeedback.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveAlongSplineGoal.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveAlongSplineResult.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveAlongSplineFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/iiwa_msgs/msg" TYPE FILE FILES
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToCartesianPoseAction.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToCartesianPoseActionGoal.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToCartesianPoseActionResult.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToCartesianPoseActionFeedback.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToCartesianPoseGoal.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToCartesianPoseResult.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToCartesianPoseFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/iiwa_msgs/msg" TYPE FILE FILES
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToJointPositionAction.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToJointPositionActionGoal.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToJointPositionActionResult.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToJointPositionActionFeedback.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToJointPositionGoal.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToJointPositionResult.msg"
    "/home/r/tool_ws/devel/.private/iiwa_msgs/share/iiwa_msgs/msg/MoveToJointPositionFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/iiwa_msgs/cmake" TYPE FILE FILES "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/iiwa_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/r/tool_ws/devel/.private/iiwa_msgs/include/iiwa_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/r/tool_ws/devel/.private/iiwa_msgs/share/roseus/ros/iiwa_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/r/tool_ws/devel/.private/iiwa_msgs/share/common-lisp/ros/iiwa_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/r/tool_ws/devel/.private/iiwa_msgs/share/gennodejs/ros/iiwa_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/r/tool_ws/devel/.private/iiwa_msgs/lib/python2.7/dist-packages/iiwa_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/r/tool_ws/devel/.private/iiwa_msgs/lib/python2.7/dist-packages/iiwa_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/iiwa_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/iiwa_msgs/cmake" TYPE FILE FILES "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/iiwa_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/iiwa_msgs/cmake" TYPE FILE FILES
    "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/iiwa_msgsConfig.cmake"
    "/home/r/tool_ws/build/iiwa_msgs/catkin_generated/installspace/iiwa_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/iiwa_msgs" TYPE FILE FILES "/home/r/tool_ws/src/iiwa_stack/iiwa_msgs/package.xml")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/r/tool_ws/build/iiwa_msgs/gtest/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/r/tool_ws/build/iiwa_msgs/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
