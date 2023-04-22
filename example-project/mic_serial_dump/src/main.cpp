#include <Arduino.h>
#include <I2S.h>

void setup()
{
    Serial.begin(115200);
    I2S.setAllPins(-1, 42, 41, -1, -1);
    if (I2S.begin(PDM_MONO_MODE, 16000, 16) == false) {
        Serial.println("Failed initializing microphone");
        while (1);
    }
}

void loop()
{
    int sample = I2S.read();
    if (sample && sample != -1 && sample != 1) {
        Serial.println(sample);
    }
}