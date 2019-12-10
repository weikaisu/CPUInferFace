set MODEL_DIR=C:\Users\user\source\CPUInferFace\models
set SAMPLE_DIR=C:\Users\user\Documents\Intel\OpenVINO\Samples
set PIC_DIR=C:\Users\user\source\CPUInferFace\run

C:\Users\user\Documents\Intel\OpenVINO\CPUInferFace\intel64\Release\smart_classroom_demo.exe ^
-cam_w  4096 ^
-cam_h  2160 ^
-cam_f  10 ^
-m_fd   %MODEL_DIR%\FP32\face-detection-retail-0044.xml ^
-m_reid %MODEL_DIR%\FP32\face-reidentification-retail-0095.xml ^
-m_lm   %MODEL_DIR%\FP32\landmarks-regression-retail-0009.xml ^
-m_em   %MODEL_DIR%\FP32\emotions-recognition-retail-0003.xml ^
-fg     %PIC_DIR%\faces_gallery.json ^
-t_fd   0.5 ^
-t_reid 0.4 ^
-crop_gallery ^
-min_size_fr 90 ^
-d_reid   GPU
::-no_show
::-d_fd     GPU
::-d_reid   GPU
::-last_frame 90
::-ss_t     5



:: 4096, 1920, 1080 
:: 2160, 1080, 720
::-i      %SAMPLE_DIR%\IMG_0586.mp4 ^
::-i ~/Videos/classroom-children.mp4 ^
::-i /home/steve/Videos/to_steve/kasijia/kasijia_image/1354.jpg ^
::-i ~/Videos/to_steve/shandong/shandong_benchmark/7-3/videos/68/output.mp4 ^
::-i ~/Videos/HuddlyIQ.mp4 ^
::-i ~/Videos/out-face-recognition.mp4 ^
::-i ./test02.jpg ^
::-m_fd   $build_dir/FP32/version-RFB-320_ncnn_slim.xml \
::-m_act  $build_dir/FP32/person-detection-action-recognition-0006.xml \
::-m_ag $build_dir/FP32/age-gender-recognition-retail-0013.xml \
::-m_hp $build_dir/FP32/head-pose-estimation-adas-0001.xml \
::-out_csv attendees.csv \
::-no_smooth 1 \
::-a_top 9 \
::-out_v ./out.jpg \


:: -m_reid 
:: face-reidentification-retail-0095.xml
:: face-recognition-resnet100-arcface.xml

:: Intel Corporation Iris Plus Graphics 655