#!/usr/bin/env bash

build_dir=./models

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
\ #-i cam \
-i    /home/steve/Videos/nccu/201.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
\ #-m_hp $build_dir/FP32/head-pose-estimation-adas-0001.xml \
\ #-m_ag $build_dir/FP32/age-gender-recognition-retail-0013.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    201.mp4 \
\ #-fps 25 \
-r \
-no_show | tee 201.csv

#-m /opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/FP32/face-detection-adas-0001.xml 
#-m_hp //opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Transportation/object_attributes/headpose/vanilla_cnn/dldt/FP32/head-pose-estimation-adas-0001.xml
#-m_ag /opt/intel/openvino/./deployment_tools/open_model_zoo/tools/downloader/Retail/object_attributes/age_gender/dldt/FP32/age-gender-recognition-retail-0013.xml 
#-m_em /opt/intel/openvino/deployment_tools/open_model_zoo/tools/downloader/Retail/object_attributes/emotions_recognition/0003/dldt/FP32/emotions-recognition-retail-0003.xml

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/202.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    202.mp4 \
-r \
-no_show | tee 202.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/203.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    203.mp4 \
-r \
-no_show | tee 203.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/204.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    204.mp4 \
-r \
-no_show | tee 204.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/205.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    205.mp4 \
-r \
-no_show | tee 205.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/206.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    206.mp4 \
-r \
-no_show | tee 206.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/207.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    207.mp4 \
-r \
-no_show | tee 207.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/208.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    208.mp4 \
-r \
-no_show | tee 208.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/209.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    209.mp4 \
-r \
-no_show | tee 209.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/210.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    210.mp4 \
-r \
-no_show | tee 210.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/301.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    301.mp4 \
-r \
-no_show | tee 301.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/302.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    302.mp4 \
-r \
-no_show | tee 302.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/303.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    303.mp4 \
-r \
-no_show | tee 303.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/304.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    304.mp4 \
-r \
-no_show | tee 304.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/305.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
\ #-o    305.mp4 \
-r \
-no_show | tee 305.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/306.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    306.mp4 \
-r \
-no_show | tee 306.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/307.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    307.mp4 \
-r \
-no_show | tee 307.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/308.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    308.mp4 \
-r \
-no_show | tee 308.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/309.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    309.mp4 \
-r \
-no_show | tee 309.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/310.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    310.mp4 \
-r \
-no_show | tee 310.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/401.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    401.mp4 \
-r \
-no_show | tee 401.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/402.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    402.mp4 \
-r \
-no_show | tee 402.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/403.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    403.mp4 \
-r \
-no_show | tee 403.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/404.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    404.mp4 \
-r \
-no_show | tee 404.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/405.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    405.mp4 \
-r \
-no_show | tee 405.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/406.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    406.mp4 \
-r \
-no_show | tee 406.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/407.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    407.mp4 \
-r \
-no_show | tee 407.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/408.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    408.mp4 \
-r \
-no_show | tee 408.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/409.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    409.mp4 \
-r \
-no_show | tee 409.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/410.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    410.mp4 \
-r \
-no_show | tee 410.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/501.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    501.mp4 \
-r \
-no_show | tee 501.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/502.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    502.mp4 \
-r \
-no_show | tee 502.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/503.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    503.mp4 \
-r \
-no_show | tee 503.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/504.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    504.mp4 \
-r \
-no_show | tee 504.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/505.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    505.mp4 \
-r \
-no_show | tee 505.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/506.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    506.mp4 \
-r \
-no_show | tee 506.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/507.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    507.mp4 \
-r \
-no_show | tee 507.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/508.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    508.mp4 \
-r \
-no_show | tee 508.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/509.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    509.mp4 \
-r \
-no_show | tee 509.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/510.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    510.mp4 \
-r \
-no_show | tee 510.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/601.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    601.mp4 \
-r \
-no_show | tee 601.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/602.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    602.mp4 \
-r \
-no_show | tee 602.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/603.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    603.mp4 \
-r \
-no_show | tee 603.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/604.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    604.mp4 \
-r \
-no_show | tee 604.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/605.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    605.mp4 \
-r \
-no_show | tee 605.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/606.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    606.mp4 \
-r \
-no_show | tee 606.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/607.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    607.mp4 \
-r \
-no_show | tee 607.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/608.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    608.mp4 \
-r \
-no_show | tee 608.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/609.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    609.mp4 \
-r \
-no_show | tee 609.csv

../CPUInferFaceRun/intel64/Release/interactive_face_detection_demo \
-i    /home/steve/Videos/nccu/610.MOV \
-m    $build_dir/FP32/face-detection-retail-0044.xml \
-m_em $build_dir/FP32/emotions-recognition-retail-0003.xml \
-no_show_emotion_bar \
-o    610.mp4 \
-r \
-no_show | tee 610.csv