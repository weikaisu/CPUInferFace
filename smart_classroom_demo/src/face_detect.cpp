// Copyright (C) 2018-2019 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#include "face_detect.hpp"

#include <algorithm>
#include <string>
#include <map>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <inference_engine.hpp>

using namespace InferenceEngine;

#define SSD_EMPTY_DETECTIONS_INDICATOR -1.0

using namespace detection;

namespace {
cv::Rect TruncateToValidRect(const cv::Rect& rect,
                             const cv::Size& size) {
    auto tl = rect.tl(), br = rect.br();
    tl.x = std::max(0, std::min(size.width - 1, tl.x));
    tl.y = std::max(0, std::min(size.height - 1, tl.y));
    br.x = std::max(0, std::min(size.width, br.x));
    br.y = std::max(0, std::min(size.height, br.y));
    int w = std::max(0, br.x - tl.x);
    int h = std::max(0, br.y - tl.y);
    return cv::Rect(tl.x, tl.y, w, h);
}

cv::Rect IncreaseRect(const cv::Rect& r, float coeff_x,
                      float coeff_y)  {
    cv::Point2f tl = r.tl();
    cv::Point2f br = r.br();
    cv::Point2f c = (tl * 0.5f) + (br * 0.5f);
    cv::Point2f diff = c - tl;
    cv::Point2f new_diff{diff.x * coeff_x, diff.y * coeff_y};
    cv::Point2f new_tl = c - new_diff;
    cv::Point2f new_br = c + new_diff;

    cv::Point new_tl_int {static_cast<int>(std::floor(new_tl.x)), static_cast<int>(std::floor(new_tl.y))};
    cv::Point new_br_int {static_cast<int>(std::ceil(new_br.x)), static_cast<int>(std::ceil(new_br.y))};

    return cv::Rect(new_tl_int, new_br_int);
}
}  // namespace

void FaceDetection::submitRequest() {
    if (!enqueued_frames_) return;
    enqueued_frames_ = 0;
    results_fetched_ = false;
    results.clear();
    BaseCnnDetection::submitRequest();
}

void FaceDetection::enqueue(const cv::Mat &frame) {
    if (!enabled()) return;

    if (!request) {
        request = net_.CreateInferRequestPtr();
    }

    width_ = static_cast<float>(frame.cols);
    height_ = static_cast<float>(frame.rows);

    Blob::Ptr inputBlob = request->GetBlob(input_name_);

    matU8ToBlob<uint8_t>(frame, inputBlob);

    enqueued_frames_ = 1;
}

FaceDetection::FaceDetection(const DetectorConfig& config) :
    BaseCnnDetection(config.enabled, config.is_async), config_(config) {
    if (config.enabled) {
        topoName = "face detector";
        CNNNetReader net_reader;
        net_reader.ReadNetwork(config.path_to_model);
        net_reader.ReadWeights(config.path_to_weights);
        if (!net_reader.isParseSuccess()) {
            THROW_IE_EXCEPTION << "Cannot load model";
        }

        // ---------------------------Check inputs -------------------------------------------------------------
        InputsDataMap inputInfo(net_reader.getNetwork().getInputsInfo());
        if (inputInfo.size() != 1) {
            THROW_IE_EXCEPTION << "Face Detection network should have only one input";
        }
        InputInfo::Ptr inputInfoFirst = inputInfo.begin()->second;
        inputInfoFirst->setPrecision(Precision::U8);
        inputInfoFirst->getInputData()->setLayout(Layout::NCHW);
        //inputInfoFirst->getPreProcess().setResizeAlgorithm(RESIZE_BILINEAR);
        //inputInfoFirst->getPreProcess().setColorFormat(ColorFormat::NV12);

        SizeVector input_dims = inputInfoFirst->getInputData()->getTensorDesc().getDims();
        input_dims[2] = config_.input_h;
        input_dims[3] = config_.input_w;
        std::map<std::string, SizeVector> input_shapes;
        input_shapes[inputInfo.begin()->first] = input_dims;
        net_reader.getNetwork().reshape(input_shapes);
        // -----------------------------------------------------------------------------------------------------

        // ---------------------------Check outputs ------------------------------------------------------------
        OutputsDataMap outputInfo(net_reader.getNetwork().getOutputsInfo());
        if (0) { //(outputInfo.size() != 1) {
            THROW_IE_EXCEPTION << "Face Detection network should have only one output" << outputInfo.size();
        }
        DataPtr& _output = outputInfo.begin()->second;
        output_name_ = outputInfo.begin()->first;

        #if 0
        for (auto && output : outputInfo) {
            std::cout << output.first << std::endl;
            const SizeVector outputDims = output.second->getTensorDesc().getDims();
            std::cout << " " << outputDims.size()
            << " " << outputDims[0]
            << " " << outputDims[1]
            << " " << outputDims[2]
            << " " << outputDims[3]
            << " " << outputDims[4] << std::endl;
        }
        #endif

        #if 0 // for new fd
        auto it = outputInfo.begin();
        output_name_boxes = it->first;
        max_detections_count_boxes = 4420;
        object_size_boxes = 4;
        it++;
        output_name_scores = it->first;
        max_detections_count_scores = 4420;
        object_size_scores = 2;
        std::cout<< "output_name : " << output_name_boxes << "," << max_detections_count_boxes << "," << object_size_boxes << std::endl;
        std::cout<< "output_name : " << output_name_scores << "," << max_detections_count_scores << "," << object_size_scores << std::endl;
        #endif

        const CNNLayerPtr outputLayer = net_reader.getNetwork().getLayerByName(output_name_.c_str());
        if (0) { //(outputLayer->type != "DetectionOutput") {
            THROW_IE_EXCEPTION << "Face Detection network output layer(" + outputLayer->name +
                                  ") should be DetectionOutput, but was " +  outputLayer->type;
        }

        if (0) { //(outputLayer->params.find("num_classes") == outputLayer->params.end()) {
            THROW_IE_EXCEPTION << "Face Detection network output layer (" +
                                  output_name_ + ") should have num_classes integer attribute";
        }

        const SizeVector outputDims = _output->getTensorDesc().getDims();
        max_detections_count_ = outputDims[2];
        object_size_ = outputDims[3];
        if (0) { //(object_size_ != 7) {
            THROW_IE_EXCEPTION << "Face Detection network output layer should have 7 as a last dimension" ;
        }
        if (0) { //(outputDims.size() != 4) {
            THROW_IE_EXCEPTION << "Face Detection network output dimensions not compatible shoulld be 4, but was " +
                                  std::to_string(outputDims.size());
        }
        _output->setPrecision(Precision::FP32);
        _output->setLayout(TensorDesc::getLayoutByDims(_output->getDims()));

        input_name_ = inputInfo.begin()->first;
        net_ = config_.ie.LoadNetwork(net_reader.getNetwork(), config_.deviceName);

        #if 0 // for new fd
        int input_size = 320;
        switch (input_size) {
            case 128: {
                in_w = 128;
                in_h = 96;
                num_anchors = 708;
                featuremap_size = {{16, 8, 4, 2},
                                {12, 6, 3, 2}};
                break;
            }
            case 160: {
                in_w = 160;
                in_h = 120;
                num_anchors = 1118;
                featuremap_size = {{20, 10, 5, 3},
                                {15, 8,  4, 2}};
                break;
            }
            case 320: {
                in_w = 320;
                in_h = 240;
                num_anchors = 4420;
                featuremap_size = {{40, 20, 10, 5},
                                {30, 15, 8,  4}};
                break;
            }
            case 480: {
                in_w = 480;
                in_h = 360;
                num_anchors = 9984;
                featuremap_size = {{60, 30, 15, 8},
                                {45, 23, 12, 6}};
                break;
            }
            case 640: {
                in_w = 640;
                in_h = 480;
                num_anchors = 17640;
                featuremap_size = {{80, 40, 20, 10},
                                {60, 30, 15, 8}};
                break;
            }
            case 1280: {
                in_w = 1280;
                in_h = 960;
                num_anchors = 70500;
                featuremap_size = {{160, 80, 40, 20},
                                {120, 60, 30, 15}};
                break;
            }
            default: {
                printf("unknown input size.");
                exit(-1);
            }
        }
        w_h_list = {in_w, in_h};
        for (int i = 0; i < 2; ++i) {
            std::vector<float> shrinkage_item;
            for (unsigned int j = 0; j < featuremap_size[i].size(); ++j) {
                shrinkage_item.push_back(w_h_list[i] / featuremap_size[i][j]);
            }
            shrinkage_size.push_back(shrinkage_item);
        }

        /* generate prior anchors */
        for (int index = 0; index < num_featuremap; index++) {
            float scale_w = in_w / shrinkage_size[0][index];
            float scale_h = in_h / shrinkage_size[1][index];
            for (int j = 0; j < featuremap_size[1][index]; j++) {
                for (int i = 0; i < featuremap_size[0][index]; i++) {
                    float x_center = (i + 0.5) / scale_w;
                    float y_center = (j + 0.5) / scale_h;

                    for (unsigned int k = 0; k < min_boxes[index].size(); k++) {
                        float w = min_boxes[index][k] / in_w;
                        float h = min_boxes[index][k] / in_h;
                        priors.push_back({clip(x_center, 1), clip(y_center, 1), clip(w, 1), clip(h, 1)});
                    }
                }
            }
        }
        /* generate prior anchors finished */
        #endif
    }
}

void FaceDetection::fetchResults() {
    if (!enabled()) return;
    results.clear();
    if (results_fetched_) return;
    results_fetched_ = true;

    #if 0 // for new fd
    const float *data_scores, *data_boxes;

    data_scores = request->GetBlob(output_name_scores)->buffer().as<float *>();
    data_boxes = request->GetBlob(output_name_boxes)->buffer().as<float *>();
    int good=0, bad=0;
    for (int det_id = 0; det_id < max_detections_count_scores; ++det_id) {
        const int start_pos = det_id * object_size_scores;
        if(det_id<10) std::cout << data_scores[start_pos + 1] << std::endl;
        if (data_scores[start_pos + 1] > config_.confidence_threshold) {
            good++;
            float x_center = data_boxes[start_pos] * center_variance * priors[det_id][2] + priors[det_id][0];
            float y_center = data_boxes[start_pos + 1] * center_variance * priors[det_id][3] + priors[det_id][1];
            float w = exp(data_boxes[start_pos + 2] * size_variance) * priors[det_id][2];
            float h = exp(data_boxes[start_pos + 3] * size_variance) * priors[det_id][3];
            const float x0 = clip(x_center - w / 2.0, 1) * width_;
            const float y0 = clip(y_center - h / 2.0, 1) * height_;
            const float x1 = clip(x_center + w / 2.0, 1) * width_;
            const float y1 = clip(y_center + h / 2.0, 1) * height_;

            std::cout << "x0 : " << x0 << std::endl;
            std::cout << "y0 : " << y0 << std::endl;
            std::cout << "x1 : " << x1 << std::endl;
            std::cout << "y1 : " << y1 << std::endl;
        }
        else { bad++; }
    }
    std::cout << good << "," << bad << std::endl;
    #endif

    #if 0
    data = request->GetBlob(output_name_boxes)->buffer().as<float *>();
    for (int det_id = 0; det_id < max_detections_count_boxes; ++det_id) {
        const int start_pos = det_id * object_size_boxes;

        const float batchID = data[start_pos];
        if (batchID == SSD_EMPTY_DETECTIONS_INDICATOR) {
            break;
        }

        const float x0 = std::min(std::max(0.0f, data[start_pos]), 1.0f) * width_;
        const float y0 = std::min(std::max(0.0f, data[start_pos + 1]), 1.0f) * height_;
        const float x1 = std::min(std::max(0.0f, data[start_pos + 2]), 1.0f) * width_;
        const float y1 = std::min(std::max(0.0f, data[start_pos + 3]), 1.0f) * height_;

        std::cout << "x0 : " << x0 << std::endl;
        std::cout << "y0 : " << y0 << std::endl;
        std::cout << "x1 : " << x1 << std::endl;
        std::cout << "y1 : " << y1 << std::endl;
    }
    #endif
    
    const float *data = request->GetBlob(output_name_)->buffer().as<float *>();
    for (int det_id = 0; det_id < max_detections_count_; ++det_id) {
        const int start_pos = det_id * object_size_;

        const float batchID = data[start_pos];
        if (batchID == SSD_EMPTY_DETECTIONS_INDICATOR) {
            break;
        }

        const float score = std::min(std::max(0.0f, data[start_pos + 2]), 1.0f);
        if (score < config_.confidence_threshold) {
            continue;
        }
        const float x0 = std::min(std::max(0.0f, data[start_pos + 3]), 1.0f) * width_;
        const float y0 = std::min(std::max(0.0f, data[start_pos + 4]), 1.0f) * height_;
        const float x1 = std::min(std::max(0.0f, data[start_pos + 5]), 1.0f) * width_;
        const float y1 = std::min(std::max(0.0f, data[start_pos + 6]), 1.0f) * height_;

        DetectedObject object;
        object.confidence = score;
        object.rect = cv::Rect(cv::Point(static_cast<int>(round(static_cast<double>(x0))),
                                         static_cast<int>(round(static_cast<double>(y0)))),
                               cv::Point(static_cast<int>(round(static_cast<double>(x1))),
                                         static_cast<int>(round(static_cast<double>(y1)))));


        object.rect = TruncateToValidRect(IncreaseRect(object.rect,
                                                       config_.increase_scale_x,
                                                       config_.increase_scale_y),
                                          cv::Size(static_cast<int>(width_), static_cast<int>(height_)));

        if (object.confidence > config_.confidence_threshold && object.rect.area() > 0) {
            //std::cout << "score : " << object.confidence  << std::endl;
            results.emplace_back(object);
        }
    }
}
