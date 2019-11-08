#!/usr/bin/env bash

build_dir=./models

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
\ #-i cam \
-i    /home/steve/Videos/20191101_817_720P.mov \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
\ #-m_hp $build_dir/FP32/head-pose-estimation-adas-0001.xml \
\ #-m_ag $build_dir/FP32/age-gender-recognition-retail-0013.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o   20191101_817_720P_analyzed.mp4 \
-fps 30 \
-r \
-no_show | tee 2020191101_817_720P.csv

#-m /opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/FP32/face-detection-adas-0001.xml 
#-m_hp //opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Transportation/object_attributes/headpose/vanilla_cnn/dldt/FP32/head-pose-estimation-adas-0001.xml
#-m_ag /opt/intel/openvino/./deployment_tools/open_model_zoo/tools/downloader/Retail/object_attributes/age_gender/dldt/FP32/age-gender-recognition-retail-0013.xml 
#-m_em /opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Retail/object_attributes/emotions_recognition/0003/dldt/FP32/emotions-recognition-retail-0003.xml
