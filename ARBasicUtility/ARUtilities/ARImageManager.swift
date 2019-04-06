//
//  ARImageManager.swift
//  RPBasic
//
//  Created by Ronak Adeshara on 06/04/19.
//  Copyright © 2019 Ronak Adeshara. All rights reserved.
//

import Foundation
import UIKit
import Photos

class ARImageManager: NSObject {
    
    static let shared = ARImageManager()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let imagePicker = UIImagePickerController()
    
    enum ImagePickResult {
        case noPermission(String)
        case cancel
        case success(UIImage?)
    }
    
    //MARK:- Variable declaration
    private var completionBlock: ((ImagePickResult) -> Void)!
//    var imageManager:CLLocationManager?
    
    
    func showImagePicker(completion: @escaping (ImagePickResult) -> Void) {
        self.completionBlock = completion
        
        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
                self.showCamera()
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default , handler:{ (UIAlertAction)in
                self.showPhotoLibray()
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
            
        }))
        
        appDelegate.window?.rootViewController?.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    
    private func showCamera() {
        if isCameraAccessForAllowed() {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            
            appDelegate.window?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        } else {
            completionBlock(.noPermission(ValidationMessages.noCameraAccess))
        }
    }
    
    private func showPhotoLibray() {
        if isgallryAccessAllowed() {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            
            appDelegate.window?.rootViewController?.present(imagePicker, animated: true, completion: nil)
            
        } else {
            completionBlock(.noPermission(ValidationMessages.noGalleryAccess))
        }
    }
    
    func isgallryAccessAllowed() -> Bool {
        
        // Get the current authorization state.
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            return true
        }
            
        else if (status == PHAuthorizationStatus.denied) {
            return false
        }
            
        else if (status == PHAuthorizationStatus.notDetermined) {
            return true
        }
            
        else if (status == PHAuthorizationStatus.restricted) {
            return false
        }
        return false
    }
    
    func isCameraAccessForAllowed() -> Bool {
        
        
        let status =  AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        if (status == AVAuthorizationStatus.authorized) {
            return true
        }
            
        else if (status == AVAuthorizationStatus.denied) {
            return false
        }
            
        else if (status == AVAuthorizationStatus.notDetermined) {
            return true
        }
            
        else if (status == AVAuthorizationStatus.restricted) {
            return false
        }
        return false
        
    }
    
}


extension ARImageManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            completionBlock(.success(image))
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        completionBlock(.cancel)
        picker.dismiss(animated: true, completion: nil)
    }
    
}
