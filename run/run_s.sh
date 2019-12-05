#!/usr/bin/env bash

build_dir=./models

../CPUInferFaceRun/intel64/Release/smart_classroom_demo \
\ #../CPUInferFaceRun/intel64/Debug/smart_classroom_demo \
\ #-i ~/Videos/classroom-children.mp4 \
-i ~/Videos/IMG_0586.MOV \
\ #-i /home/steve/Videos/to_steve/kasijia/kasijia_image/1354.jpg \
\ #-i ~/Videos/to_steve/shandong/shandong_benchmark/7-3/videos/68/output.mp4 \
\ #-i ~/Videos/HuddlyIQ.mp4 \
\ #-i ~/Videos/out-face-recognition.mp4 \
\ #-i ./test02.jpg \
-cam_w 4096 \ #4096, 1920, 1080 \
-cam_h 2160 \ #2160, 1080, 720 \
-cam_f 10 \
\ #-m_act  $build_dir/FP32/person-detection-action-recognition-0006.xml \
-m_fd   $build_dir/FP32/face-detection-retail-0044.xml \
\ #-m_fd   $build_dir/FP32/version-RFB-320_ncnn_slim.xml \
-m_reid $build_dir/FP32/face-reidentification-retail-0095.xml \
-m_lm   $build_dir/FP32/landmarks-regression-retail-0009.xml \
-m_em   $build_dir/FP32/emotions-recognition-retail-0003.xml \
\ #-m_ag $build_dir/FP32/age-gender-recognition-retail-0013.xml \
\ #-m_hp $build_dir/FP32/head-pose-estimation-adas-0001.xml \
-fg ./run/faces_gallery.json \
-t_fd 0.5 \
-t_reid 0.4 \
-crop_gallery \
-min_size_fr 90 \
\ #-out_csv attendees.csv \
\ #-no_smooth 1 \
\ #-a_top 9 \
\ #-out_v ./out.jpg \
-no_show
#-d_reid GPU
#-last_frame 90
#-d_fd GPU
#-ss_t 5

# Intel Corporation HD Graphics 630 (rev 04) 

# std::cout << __LINE__ << std::endl;

# -m_reid 
# face-reidentification-retail-0095.xml
# face-recognition-resnet100-arcface.xml