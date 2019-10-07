#!/usr/bin/env bash

build_dir=../../models

./interactive_face_detection_demo \
-i cam \
\ #-i    /home/sun/Downloads/OpenVINO/NCCU/20190925_125231.mp4 \
-m    $build_dir/FP32/face-detection-adas-0001.xml \
-m_hp $build_dir/FP32/head-pose-estimation-adas-0001.xml \
-m_ag $build_dir/FP32/age-gender-recognition-retail-0013.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-o    face_out.mp4

#-m /opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/FP32/face-detection-adas-0001.xml 
#-m_hp //opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Transportation/object_attributes/headpose/vanilla_cnn/dldt/FP32/head-pose-estimation-adas-0001.xml
#-m_ag /opt/intel/openvino/./deployment_tools/open_model_zoo/tools/downloader/Retail/object_attributes/age_gender/dldt/FP32/age-gender-recognition-retail-0013.xml 
#-m_em /opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Retail/object_attributes/emotions_recognition/0003/dldt/FP32/emotions-recognition-retail-0003.xml