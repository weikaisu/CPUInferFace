# Copyright (C) 2018-2019 Intel Corporation
# SPDX-License-Identifier: Apache-2.0
#

file (GLOB MAIN_SRC ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
file (GLOB MAIN_HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h*)

ie_add_sample(NAME interactive_face_detection_demo
              SOURCES ${MAIN_SRC}
              HEADERS ${MAIN_HEADERS}
              OPENCV_DEPENDENCIES highgui)
 
add_library(face_analytics_sdk STATIC ${CMAKE_CURRENT_SOURCE_DIR}/face_analytics_sdk.cpp ${IE_SAMPLES_HEADERS})
#target_include_directories(face_analytics_sdk
#	PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
#	PRIVATE ${IE_SAMPLES_HEADERS})