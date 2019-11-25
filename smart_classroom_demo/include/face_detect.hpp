// Copyright (C) 2018-2019 Intel Corporation
// SPDX-License-Identifier: Apache-2.0
//

#pragma once

#include <map>
#include <string>
#include <vector>

#include <opencv2/core/core.hpp>

#include "cnn.hpp"

namespace detection {

struct DetectedObject {
    cv::Rect rect;
    float confidence;

    explicit DetectedObject(const cv::Rect& rect = cv::Rect(), float confidence = -1.0f)
        : rect(rect), confidence(confidence) {}
};

using DetectedObjects = std::vector<DetectedObject>;

struct DetectorConfig : public CnnConfig {
    explicit DetectorConfig(const std::string& path_to_model,
                            const std::string& path_to_weights)
        : CnnConfig(path_to_model, path_to_weights) {}

    float confidence_threshold{0.7f};
    float increase_scale_x{1.15f};
    float increase_scale_y{1.15f};
    bool is_async = true;
    int input_h = 240; //600;
    int input_w = 320; //600;
};

#define num_featuremap 4
#define clip(x, y) (x < 0 ? 0 : (x > y ? y : x))

class FaceDetection : public BaseCnnDetection {
private:
    DetectorConfig config_;
    InferenceEngine::ExecutableNetwork net_;
    std::string input_name_;
    std::string output_name_;
    int max_detections_count_ = 0;
    int object_size_ = 0;
    int enqueued_frames_ = 0;
    float width_ = 0;
    float height_ = 0;
    bool results_fetched_ = false;

    #if 0 // for new fd
    int in_w;
    int in_h;
    int num_anchors;

    std::string output_name_boxes;
    std::string output_name_scores;
    int max_detections_count_boxes = 0;
    int max_detections_count_scores = 0;
    int object_size_boxes = 0;
    int object_size_scores = 0;

    const float mean_vals[3] = {127, 127, 127};
    const float norm_vals[3] = {1.0 / 128, 1.0 / 128, 1.0 / 128};

    const float center_variance = 0.1;
    const float size_variance = 0.2;
    const std::vector<std::vector<float>> min_boxes = {
            {10.0f,  16.0f,  24.0f},
            {32.0f,  48.0f},
            {64.0f,  96.0f},
            {128.0f, 192.0f, 256.0f}};
    std::vector<std::vector<float>> featuremap_size;
    std::vector<std::vector<float>> shrinkage_size;
    std::vector<int> w_h_list;
    std::vector<std::vector<float>> priors = {};
    #endif

public:
    explicit FaceDetection(const DetectorConfig& config);

    DetectedObjects results;
    void submitRequest() override;
    void enqueue(const cv::Mat &frame);
    void fetchResults();
};

}  // namespace detection
