//
//  CameraViewController.swift
//  fakestagram
//
//  Created by Alan Vargas on 27.04.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class CameraViewController: UIViewController {
    var imagePicker: UIImagePickerController!
    
    let client = CreatePostClient()
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        showCamera()
    }
    
    func showCamera(){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        locationManager.stopUpdatingLocation()
    }
    
    func createPost(img:UIImage){
        guard let imgBase64 = img.encodedBase64() else { return }
        let timestamp = Date().currentTimestamp()
        client.create(title: String(timestamp), imageData: imgBase64) { post in
            print("post: \(post)")
        }
    }
    
    @IBAction func showCameraButton(_ sender: Any) {
        showCamera()
    }
}

extension CameraViewController: CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var imageToPost = UIImage()
        
        imagePicker.dismiss(animated: true, completion: nil)
        imageToPost = info[.originalImage] as! UIImage
        
        guard let imgBase64 = imageToPost.encodedBase64() else { return }
        
        let payload = CreatePostBase64(title: "ImagePicker :D", imageData: imgBase64, latitude: nil, longitude: nil)
        client.create(payload: payload) { (post) in
            let alert = UIAlertController(title: "Foto posteada!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                print("OK BUTTON")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
    }
}
