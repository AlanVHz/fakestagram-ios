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
    let client = CreatePostClient()
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        // Do any additional setup after loading the view.
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

    @IBAction func onTapSnap(_ sender: UIButton) {
        /*guard let img = UIImage(named: "cat"),
              let imgBase64 = img.encodedBase64() else { return }
        
        let payload = CreatePostBase64(title: "Tac - \(Date().currentTimestamp())", image_data: imgBase64)
        client.create(body: payload) { (post) in
            print("post: \(post)")
        }*/
    }
}

extension CameraViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
    }
}
