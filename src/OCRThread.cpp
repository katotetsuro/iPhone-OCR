//
//  OCRThread.cpp
//  videoGrabberExample
//
//  Created by Tetsuro Kato on 12/06/17.
//  Copyright (c) 2012年 KATO Tetsuro. All rights reserved.
//

#include "OCRThread.h"

ofRectangle tr(100, 120, 280, 120);

void OCRThread::setup() {
    shouldFindText = false;
    processing = false;
    text = "";
    tess.setup();
    tess.setWhitelist("abcdefghijklmnopqrstuvwxyz:/."); //-0123456789
    tess.setMode(ofxTesseract::WORD/*ofxTesseract::LINE*/);
    startThread(true, false);
}

void OCRThread::setImage(ofImage image) {
    if (processing) {
        return;
    }
    if (lock()) {
        pixels.setFromPixels(image.getPixels(), image.width, image.height, 1);
        shouldFindText = true;
        unlock();
    }
}

void OCRThread::threadedFunction() {
    while (isThreadRunning()) {
        if ( shouldFindText ) {
            if (lock()) {
                processing = true;
                if (pixels.isAllocated()) {
                    text = tess.findText(pixels, tr);
                }
                unlock();
                shouldFindText = false;
                processing = false;
            }
        } else {
            
        }
    }
}

string OCRThread::getText() {
    return text;
}

void OCRThread::stop() {
    if (isThreadRunning()) {
        waitForThread();
    }
}