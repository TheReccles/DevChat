//
//  CameraViewControllerDelegate.swift
//  DevChat
//
//  Created by Richard Eccles on 1/6/17.
//  Copyright © 2017 Richard Eccles. All rights reserved.
//

import Foundation

protocol CameraViewControllerDelegate {
    //call when we want to enable controls
    func shouldEnableRecordUI(enabled: Bool)
    func shouldEnableCameraUI(enabled: Bool)
    func canStartRecording()
    func recordingHasStarted()
    
}
