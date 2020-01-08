
// Copyright (C) 2015-2019 Emotibot Corporation

# pragma once
#include <iostream>

struct FaceAnalyticsResult {
    float x;
    float y;
    float w;
    float h;
    std::string emotion;
};

void* face_analytics_open(void);
int   face_analytics_submit(void* handle);
int   face_analytics_infer(void* handle);
int   face_analytics_wait(void* handle);
int   face_analytics_get_result(void* handle);
int   face_analytics_close(void* handle);