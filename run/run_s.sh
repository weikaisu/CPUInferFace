#!/usr/bin/env bash

build_dir=./models

../CPUInferFaceRun/intel64/Release/smart_classroom_demo \
\ #../CPUInferFaceRun/intel64/Debug/smart_classroom_demo \
\ #-i ~/Videos/classroom-children.mp4 \
-cam_w 1920 \ #4096, 1080 \
-cam_h 1080 \ #2160, 720 \
-cam_f 10 \
\ #-m_act  $build_dir/person-detection-action-recognition-0006.xml \
-m_fd   $build_dir/FP32/face-detection-retail-0044.xml \
-m_reid $build_dir/FP32/face-recognition-resnet50-arcface.xml \
-m_lm   $build_dir/FP32/landmarks-regression-retail-0009.xml \
-m_em   $build_dir/FP32/emotions-recognition-retail-0003.xml \
-fg ./run/faces_gallery.json \
#-d_reid GPU
#-out_v ./out.mp4 \
#-no_show \
#-last_frame 90
#-d_fd GPU
#-ss_t 5

# Intel Corporation HD Graphics 630 (rev 04) 

# std::cout << __LINE__ << std::endl;

# -m_reid 
# face-reidentification-retail-0095.xml
# face-recognition-resnet100-arcface.xml