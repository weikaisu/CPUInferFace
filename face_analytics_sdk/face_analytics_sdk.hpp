
// Copyright (C) 2015-2019 Emotibot Corporation

# pragma once
#include <iostream>

typedef void* HANDLE;

struct FaceAnalyticsResult {
    float x;
    float y;
    float w;
    float h;
    std::string emotion;
};

HANDLE face_analytics_open(void);
int    face_analytics_submit(HANDLE hnd, void* image, int image_w, int image_h);
int    face_analytics_infer(HANDLE hnd);
int    face_analytics_wait(HANDLE hnd);
int    face_analytics_get_result(HANDLE hnd);
int    face_analytics_close(HANDLE hnd);