//
//  OCRThread.h
//  videoGrabberExample
//
//  Created by Tetsuro Kato on 12/06/17.
//  Copyright (c) 2012年 KATO Tetsuro. All rights reserved.
//

#ifndef videoGrabberExample_OCRThread_h
#define videoGrabberExample_OCRThread_h

#include "ofMain.h"
#include "ofxTesseract.h"

class OCRThread : public ofThread {
private:
    ofxTesseract tess;
    bool shouldFindText;
    ofPixels pixels;
    string text;
    bool processing;
    
public:
    void setup();
    void setImage(ofImage image);
    void threadedFunction();
    string getText();
    void stop();
};

#endif
