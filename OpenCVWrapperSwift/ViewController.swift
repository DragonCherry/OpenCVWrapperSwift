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
        
        label = UILabel(height: 50)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}


extension ViewController: CameraPreviewControllerDelegate {
    
    func cameraPreviewWillOutputSampleBuffer(buffer: CMSampleBuffer) {
    }
    
    func cameraPreviewNeedsLayout(preview: GPUImageView) {
        
    }
    
    func cameraPreviewPreferredFillMode(preview: GPUImageView) -> Bool {
        return false
    }
    
    func cameraPreviewDetectedFaces(preview: GPUImageView, features: [CIFeature]?, aperture: CGRect, orientation: UIDeviceOrientation) {
        
    }
}
