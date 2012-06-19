#include "testApp.h"

int length = 480*360;
ofRectangle targetRect(100, 120, 280, 120);

//--------------------------------------------------------------
void testApp::setup(){
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);

	ofSetFrameRate(30);

	grabber.initGrabber(480, 360, OF_PIXELS_RGB);
    gray.allocate(480, 360, OF_IMAGE_GRAYSCALE);
    ocrThread.setup();
//    text.loadImage("text.jpg");text.setImageType(OF_IMAGE_GRAYSCALE);
}

//--------------------------------------------------------------
void testApp::update(){
	ofBackground(255,255,255);	
	
	grabber.update();
	if (grabber.isFrameNew()) {
        unsigned char* grayPixels = gray.getPixels();
        unsigned char* rgbPixxels = grabber.getPixels();
        for (int i=0; i<length; ++i) {
            grayPixels[i] = rgbPixxels[i*3]*0.299 + rgbPixxels[i*3+1]*0.587 + rgbPixxels[i*3+2]*0.114;
        }
        gray.update();
        ocrThread.setImage(gray);
    }
}

//--------------------------------------------------------------
void testApp::draw(){
	ofSetColor(255);
	grabber.draw(0, 0);
    ofNoFill();
    ofRect(targetRect);
    gray.draw(0, 0, 120, 90);
    ofDrawBitmapString(ocrThread.getText(), 10, 10);
}

//--------------------------------------------------------------
void testApp::exit(){
    ocrThread.stop();
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::lostFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
    
}


