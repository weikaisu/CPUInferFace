
#include "face_analytics_sdk.hpp"

#include <inference_engine.hpp>
#include <samples/slog.hpp>

using namespace InferenceEngine;

struct FaceAnalyticsHandle {
    Core ie;
};

int  face_analytics_open(void* handle)
{
    std::cout << "face_analytics_open +"<< std::endl;

    try {

    }
    catch (const std::exception& error) {
        slog::err << error.what() << slog::endl;
        return 1;
    }
    catch (...) {
        slog::err << "Unknown/internal exception happened." << slog::endl;
        return 1;
    }

    slog::info << "Execution successful" << slog::endl;

    std::cout << "face_analytics_open -"<< std::endl;
    return 0;
}