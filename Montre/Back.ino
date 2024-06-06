#include <Encoder.h>
#include <TFT_eSPI.h>
#include <SPI.h>
#include <WiFi.h>
#include <time.h>
#include <BluetoothSerial.h>

TFT_eSPI tft = TFT_eSPI();
BluetoothSerial SerialBT;

Encoder myEnc(17, 16);

String selectedMood = ""; 
String ssid = ""; 
String password = "";

const int numEmoticons = 5; 
int currentEmoticon = 0;    
long oldPosition  = -999;  

void setup() {
  tft.init();
  tft.setRotation(1);
  tft.fillScreen(TFT_BLACK);
  tft.setTextColor(TFT_WHITE, TFT_BLACK); 

  SerialBT.begin("Feelings"); 

  configTime(0, 0, "pool.ntp.org");

  oldPosition = myEnc.read();
}

void loop() {
  long newPosition = myEnc.read();
  if (newPosition != oldPosition) {
    oldPosition = newPosition;
    currentEmoticon = (newPosition / 4) % numEmoticons; 
    if (currentEmoticon < 0) currentEmoticon += numEmoticons;

    tft.fillScreen(TFT_BLACK);
    tft.setCursor(40, 120);
    tft.setTextSize(4);
    tft.printf("Emoticon %d", currentEmoticon + 1);
  }

  if (digitalRead(15) == LOW) {
    String message = "Humeur: " + String(currentEmoticon + 1);
    SerialBT.println(message);
    delay(500); 
  }

  if (SerialBT.available()) {
    String receivedData = SerialBT.readStringUntil('\n');
    int separatorIndex = receivedData.indexOf(',');
    if (separatorIndex != -1) {
      ssid = receivedData.substring(0, separatorIndex);
      password = receivedData.substring(separatorIndex + 1);
      connectToWiFi(ssid, password);
    }
  }

  delay(100); 
}

void connectToWiFi(String ssid, String password) {
  tft.fillScreen(TFT_BLACK);
  tft.setCursor(20, 50);
  tft.setTextSize(2);
  tft.println("Tentative de connexion au WiFi...");

  WiFi.begin(ssid.c_str(), password.c_str());
  int attempts = 0;
  while (WiFi.status() != WL_CONNECTED && attempts < 30) {
    delay(1000);
    attempts++;
  }

  if (WiFi.status() == WL_CONNECTED) {
    tft.fillScreen(TFT_BLACK);
    tft.setCursor(20, 50);
    tft.setTextSize(2);
    tft.println("Connexion WiFi réussie !");
  } else {
    tft.fillScreen(TFT_BLACK);
    tft.setCursor(20, 50);
    tft.setTextSize(2);
    tft.println("Échec de la connexion WiFi !");
  }
}
