
#include "face_analytics_sdk.hpp"
#include "detectors.hpp"
#include "face.hpp"

#include <inference_engine.hpp>
#include <samples/slog.hpp>
#include <opencv2/opencv.hpp>

/*  config for face detection  */
    bool        FLAGS_async = true;
    //bool        FLAGS_no_smooth = false;
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
    bool isFaceAnalyticsEnabled = false;
    cv::Mat img;
    int img_w = 0;
    int img_h = 0;
    int face_id = 0;
    std::list<Face::Ptr> faces;

    FaceAnalyticsHandle()
        : fd_hnd(FLAGS_m, FLAGS_d, 1, false, FLAGS_async, FLAGS_t, false, static_cast<float>(FLAGS_bb_enlarge_coef), static_cast<float>(FLAGS_dx_coef), static_cast<float>(FLAGS_dy_coef))
        , fe_hnd(FLAGS_m_em, FLAGS_d_em, FLAGS_n_em, FLAGS_dyn_em, FLAGS_async, FLAGS_r)
        {
    };
};

HANDLE face_analytics_open(void)
{
    slog::info << "face_analytics_open +"<< slog::endl;

    // check license

    FaceAnalyticsHandle* sdk_hnd = new FaceAnalyticsHandle();

    try {
        // --------------------------- 1. Load Inference Engine -----------------------------
        slog::info << "Loading device CPU" << slog::endl;
        std::cout << sdk_hnd->ie.GetVersions(deviceName) << std::endl;
        sdk_hnd->ie.AddExtension(std::make_shared<Extensions::Cpu::CpuExtensions>(), "CPU");

        Load(sdk_hnd->fd_hnd).into(sdk_hnd->ie, FLAGS_d, false);
        Load(sdk_hnd->fe_hnd).into(sdk_hnd->ie, FLAGS_d_em, FLAGS_dyn_em);

        // if function is disable, set null to model path, ex FLAGS_m_em
        sdk_hnd->isFaceAnalyticsEnabled = sdk_hnd->fe_hnd.enabled();
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

    slog::info << "face_analytics_open -"<< slog::endl;
    return static_cast<void*> (sdk_hnd);
}



int    face_analytics_submit(HANDLE hnd, void* image, int image_w, int image_h)
{
    slog::info << "face_analytics_submit +"<< slog::endl;

    try {
        // --------------------------- 2. Submit Processing Image -----------------------------
        FaceAnalyticsHandle* sdk_hnd = static_cast<FaceAnalyticsHandle*> (hnd);

        // Convert the image into opencv format.
        sdk_hnd->img = cv::Mat(image_h, image_w, CV_8UC3, image, 0);
        // Check the continuity of the image buffer.
        if(!sdk_hnd->img.isContinuous())
            sdk_hnd->img = sdk_hnd->img.clone();
        
        sdk_hnd->img_w = image_w;
        sdk_hnd->img_h = image_h;
        
        // Resize the image if needed.

        sdk_hnd->fd_hnd.enqueue(sdk_hnd->img);
        sdk_hnd->fd_hnd.submitRequest();

    }
    catch (const std::exception& error) {
        slog::err << error.what() << slog::endl;
        return 1;
    }
    catch (...) {
        slog::err << "Unknown/internal exception happened." << slog::endl;
        return 1;
    }

    slog::info << "face_analytics_submit -"<< slog::endl;
    return 0;
}



int    face_analytics_infer(HANDLE hnd)
{
    slog::info << "face_analytics_infer +"<< slog::endl;

    try {
        // --------------------------- 3. Infer The Image -----------------------------
        FaceAnalyticsHandle* sdk_hnd = static_cast<FaceAnalyticsHandle*> (hnd);

        sdk_hnd->fd_hnd.wait();
        sdk_hnd->fd_hnd.fetchResults();
        auto fd_results = sdk_hnd->fd_hnd.results;

        if (sdk_hnd->isFaceAnalyticsEnabled) {
            for (auto &&result : fd_results) {
                auto clippedRect = result.location & cv::Rect(0, 0, sdk_hnd->img_w, sdk_hnd->img_h);
                cv::Mat face = sdk_hnd->img(clippedRect);
                sdk_hnd->fe_hnd.enqueue(face);
                //ageGenderDetector.enqueue(face);
                //headPoseDetector.enqueue(face);
                //facialLandmarksDetector.enqueue(face);
            }
        }
    }
    catch (const std::exception& error) {
        slog::err << error.what() << slog::endl;
        return 1;
    }
    catch (...) {
        slog::err << "Unknown/internal exception happened." << slog::endl;
        return 1;
    }

    slog::info << "face_analytics_infer -"<< slog::endl;
    return 1;
}



int    face_analytics_wait(HANDLE hnd)
{
    slog::info << "face_analytics_wait +"<< slog::endl;

    try {
        // --------------------------- 4. Wait for The Image Inference Finished -----------------------------
        FaceAnalyticsHandle* sdk_hnd = static_cast<FaceAnalyticsHandle*> (hnd);

        sdk_hnd->fe_hnd.wait();
    }
    catch (const std::exception& error) {
        slog::err << error.what() << slog::endl;
        return 1;
    }
    catch (...) {
        slog::err << "Unknown/internal exception happened." << slog::endl;
        return 1;
    }

    slog::info << "face_analytics_wait -"<< slog::endl;
    return 1;
}



int    face_analytics_get_result(HANDLE hnd)
{
    slog::info << "face_analytics_get_result +"<< slog::endl;

    try {
        // --------------------------- 5. Get The Image Inference Result -----------------------------
        FaceAnalyticsHandle* sdk_hnd = static_cast<FaceAnalyticsHandle*> (hnd);

        auto fd_results = sdk_hnd->fd_hnd.results;
        for (size_t i = 0; i < fd_results.size(); i++) {
            auto& result = fd_results[i];
            cv::Rect rect = result.location & cv::Rect(0, 0, sdk_hnd->img_w, sdk_hnd->img_h);
            Face::Ptr face;
            /*
            if (!FLAGS_no_smooth) {
                face = matchFace(rect, prev_faces);
                float intensity_mean = calcMean(prev_frame(rect));

                if ((face == nullptr) ||
                    ((face != nullptr) && ((std::abs(intensity_mean - face->_intensity_mean) / face->_intensity_mean) > 0.07f))) {
                    face = std::make_shared<Face>(sdk_hnd->face_id++, rect);
                } else {
                    prev_faces.remove(face);
                }

                face->_intensity_mean = intensity_mean;
                face->_location = rect;
            } else {
                face = std::make_shared<Face>(sdk_hnd->face_id++, rect);
            }
            */
            face = std::make_shared<Face>(sdk_hnd->face_id++, rect);

            face->emotionsEnable((sdk_hnd->fe_hnd.enabled() && i < sdk_hnd->fe_hnd.maxBatch));
            if (face->isEmotionsEnabled()) {
                face->updateEmotions(sdk_hnd->fe_hnd[i]);
                auto emotion = face->getMainEmotion();
                std::cout << "," << emotion.first << "," << emotion.second ;
            }

            sdk_hnd->faces.push_back(face);
        }
    }
    catch (const std::exception& error) {
        slog::err << error.what() << slog::endl;
        return 1;
    }
    catch (...) {
        slog::err << "Unknown/internal exception happened." << slog::endl;
        return 1;
    }

    slog::info << "face_analytics_get_result -"<< slog::endl;
    return 1;
}



int    face_analytics_close(HANDLE hnd)
{
    slog::info << "face_analytics_close +"<< slog::endl;

    try {
        // --------------------------- 6. Unload Inference Engine -----------------------------
        FaceAnalyticsHandle* sdk_hnd = static_cast<FaceAnalyticsHandle*> (hnd);
        delete sdk_hnd;
    }
    catch (const std::exception& error) {
        slog::err << error.what() << slog::endl;
        return 1;
    }
    catch (...) {
        slog::err << "Unknown/internal exception happened." << slog::endl;
        return 1;
    }

    slog::info << "face_analytics_close -"<< slog::endl;
    return 1;
}