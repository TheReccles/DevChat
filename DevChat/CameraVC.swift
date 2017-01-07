//
//  CameraVC.swift
//  DevChat
//
//  Created by Richard Eccles on 1/3/17.
//  Copyright © 2017 Richard Eccles. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: CameraViewController, CameraViewControllerDelegate {

    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    
    override func viewDidLoad() {
        _previewView = previewView
        
        super.viewDidLoad()
        
        delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //check to see if someone is logged in or not
        performSegue(withIdentifier: "LoginVC", sender: nil)
//        guard FIRAuth.auth()?.currentUser != nil else {
//            //load loginVC
//            performSegue(withIdentifier: "LoginVC", sender: nil)
//            return
//        }
    }

    @IBAction func recordBtnPressed(_ sender: Any) {
        toggleMovieRecording()
        
    }

    @IBAction func changeCameraBtnPressed(_ sender: Any) {
        
        changeCamera()
    }
    
    func shouldEnableCameraUI(enabled: Bool) {
        cameraButton.isEnabled = enabled
        print("should enable camera ui: \(enabled)")
    }
    
    func shouldEnableRecordUI(enabled: Bool) {
        recordButton.isEnabled = enabled
        print("should enable record ui: \(enabled)")
    }
    
    func recordingHasStarted() {
        print("recording has started")
    }
    
    func canStartRecording() {
        print("can start recording")
        
    }
}

