#!/usr/bin/env bash

build_dir=../../models

./smart_classroom_demo \
-cam_w 4096 \ #4096, 1080 \
-cam_h 2160 \ #2160, 720 \
-cam_f 20 \
\ #-m_act  $build_dir/person-detection-action-recognition-0006.xml \
-m_fd   $build_dir/FP32/face-detection-adas-0001.xml \
-m_reid $build_dir/FP32/face-reidentification-retail-0095.xml \
-m_lm   $build_dir/FP32/landmarks-regression-retail-0009.xml \
-fg ./faces_gallery.json \
-out_v ./out.mp4 \
-no_show \
-last_frame 90
#-d_fd GPU
#-ss_t 5




#/opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Retail/action_detection/pedestrian/rmnet_ssd/0028_tf/dldt/FP32/person-detection-action-recognition-0006.xml
#/opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/FP32/face-detection-adas-0001.xml
#/opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Retail/object_reidentification/face/mobilenet_based/dldt/FP32/face-reidentification-retail-0095.xml
#/opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Retail/object_attributes/landmarks_regression/0009/dldt/FP32/landmarks-regression-retail-0009.xml