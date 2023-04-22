#include "esp_http_server.h"
#include "esp_camera.h"
#include "img_converters.h"
#include "Arduino.h"

typedef struct
{
    httpd_req_t *req;
    size_t len;
} jpg_chunking_t;

static size_t jpg_encode_stream(void *arg, size_t index, const void *data, size_t len)
{
    jpg_chunking_t *j = (jpg_chunking_t *)arg;
    if (!index)
    {
        j->len = 0;
    }
    if (httpd_resp_send_chunk(j->req, (const char *)data, len) != ESP_OK)
    {
        return 0;
    }
    j->len += len;
    return len;
}

static httpd_handle_t camera_httpd = NULL;

static esp_err_t capture_handler(httpd_req_t *req)
{
    camera_fb_t *fb = nullptr;
    esp_err_t res = ESP_OK;

    fb = esp_camera_fb_get();

    if (!fb)
    {
        auto err_str = "failed getting framebuffer";
        httpd_resp_set_status(req, "500 Internal Server Error");
        httpd_resp_send(req, err_str, strlen(err_str));

        return ESP_FAIL;
    }

    httpd_resp_set_type(req, "image/jpeg");
    httpd_resp_set_hdr(req, "Content-Disposition", "inline; filename=capture.jpg");
    httpd_resp_set_hdr(req, "Access-Control-Allow-Origin", "*");

    char ts[32];
    snprintf(ts, 32, "%ld.%06ld", fb->timestamp.tv_sec, fb->timestamp.tv_usec);
    httpd_resp_set_hdr(req, "X-Timestamp", (const char *)ts);

    if (fb->format == PIXFORMAT_JPEG)
    {
        res = httpd_resp_send(req, (const char *)fb->buf, fb->len);
    }
    else
    {
        jpg_chunking_t jchunk = {req, 0};
        res = frame2jpg_cb(fb, 80, jpg_encode_stream, &jchunk) ? ESP_OK : ESP_FAIL;
        httpd_resp_send_chunk(req, NULL, 0);
    }
    esp_camera_fb_return(fb);
    return res;
}

void startCameraServer()
{
    httpd_config_t config = HTTPD_DEFAULT_CONFIG();
    config.max_uri_handlers = 16;

    httpd_uri_t capture_uri = {
        .uri = "/capture",
        .method = HTTP_GET,
        .handler = capture_handler,
    };

    if (httpd_start(&camera_httpd, &config) == ESP_OK)
    {
        Serial.println("Initialized HTTP server.");
        auto err = httpd_register_uri_handler(camera_httpd, &capture_uri);
        if (err != ESP_OK) {
            Serial.printf("Failed adding URI handler: 0x%x\r\n", err);
        }
    }
}