//
//  ViewController.swift
//  OpenCVWrapperSwift
//
//  Created by DragonCherry on 1/10/17.
//  Copyright © 2017 DragonCherry. All rights reserved.
//

import UIKit
import CameraPreviewController
import SwiftyBeaver

class ViewController: CameraPreviewController {

    let cv = OpenCVWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log.verbose("OpenCV version: \(cv.versionString())")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

