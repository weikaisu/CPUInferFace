
#include "face_analytics_sdk.hpp"
#include "detectors.hpp"

#include <inference_engine.hpp>
#include <samples/slog.hpp>

/*  config for face detection  */
    bool        FLAGS_async = true;
    std::string deviceName = "CPU";
/*  -------------------------  */

/*  config for face detection  */
    std::string FLAGS_m = "test";
    std::string FLAGS_d = "test";
    double      FLAGS_t = 0.9;
    float       FLAGS_bb_enlarge_coef = 0.1;
    float       FLAGS_dx_coef = 0.1;
    float       FLAGS_dy_coef = 0.1;
/*  -------------------------  */

/*  config for face emotion  */
    std::string FLAGS_m_em = "test";
    std::string FLAGS_d_em = "test";
    int         FLAGS_n_em = 1;
    bool        FLAGS_dyn_em = 0.1;
    bool        FLAGS_r = 0.1;
/*  -------------------------  */

using namespace InferenceEngine;

struct FaceAnalyticsHandle
{
    Core ie;
    FaceDetection fd_hnd;
    EmotionsDetection fe_hnd;

    FaceAnalyticsHandle()
        : fd_hnd(FLAGS_m, FLAGS_d, 1, false, FLAGS_async, FLAGS_t, false, static_cast<float>(FLAGS_bb_enlarge_coef), static_cast<float>(FLAGS_dx_coef), static_cast<float>(FLAGS_dy_coef))
        , fe_hnd(FLAGS_m_em, FLAGS_d_em, FLAGS_n_em, FLAGS_dyn_em, FLAGS_async, FLAGS_r)
        {
    };
};

HANDLE face_analytics_open(void)
{
    std::cout << "face_analytics_open +"<< std::endl;

    // if function is disable, set null to model path, ex FLAGS_m_em

    // check license

    FaceAnalyticsHandle* sdk_handle = new FaceAnalyticsHandle();

    try {
        // --------------------------- 1. Loading Inference Engine -----------------------------
        slog::info << "Loading device CPU" << slog::endl;
        std::cout << sdk_handle->ie.GetVersions(deviceName) << std::endl;
        sdk_handle->ie.AddExtension(std::make_shared<Extensions::Cpu::CpuExtensions>(), "CPU");

        Load(sdk_handle->fd_hnd).into(sdk_handle->ie, FLAGS_d, false);
        Load(sdk_handle->fe_hnd).into(sdk_handle->ie, FLAGS_d_em, FLAGS_dyn_em);
    }
    catch (const std::exception& error) {
        slog::err << error.what() << slog::endl;
        return nullptr;
    }
    catch (...) {
        slog::err << "Unknown/internal exception happened." << slog::endl;
        return nullptr;
    }

    slog::info << "Execution successful" << slog::endl;

    std::cout << "face_analytics_open -"<< std::endl;
    return static_cast<void*> (sdk_handle);
}