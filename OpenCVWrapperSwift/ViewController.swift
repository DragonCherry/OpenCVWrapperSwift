//
//  ViewController.swift
//  OpenCVWrapperSwift
//
//  Created by DragonCherry on 1/10/17.
//  Copyright © 2017 DragonCherry. All rights reserved.
//

import UIKit
import GPUImage
import CameraPreviewController
import TinyLog
import AttachLayout

class ViewController: CameraPreviewController {

    let cv = OpenCVWrapper()
    var label: UILabel!
    
    override func loadView() {
        super.loadView()
        cameraPosition = .back
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logv("OpenCV version: \(cv.versionString())")
        
        self.delegate = self
        
        label = UILabel(height: 40, font: .systemFont(ofSize: 11), textColor: .white, backgroundColor: .black)
        _ = view.attach(label, at: .topLeft, insets: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0), widthMultiplier: 0.2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        logw("Not enough memory.")
    }
}


extension ViewController: CameraPreviewControllerDelegate {
    
    func cameraPreview(_ controller: CameraPreviewController, willOutput sampleBuffer: CMSampleBuffer, with sequence: UInt64) {
        
        if captureSequence % 5 == 0 {
            DispatchQueue.main.async {
                let blurryMetrics = self.cv.blurryMetrics(from: sampleBuffer, samplingFrequency: 100)
                self.label.text = "\(blurryMetrics)"
            }
        }
    }
    
    func cameraPreview(_ controller: CameraPreviewController, willFocusInto tappedLocationInView: CGPoint, tappedLocationInImage: CGPoint) {}
}
