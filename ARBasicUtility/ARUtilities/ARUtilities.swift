//
//  Utilities.swift
//  BaseDemo
//
//  Created by Intelivita IOS Senior on 19/06/18.
//  Copyright © 2018 Ronak. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import CoreLocation
import Photos

class ARUtilities{

    //MARK:- Alert functions
    class func showAlert(view:UIViewController,message:String){
        let actionSheetController = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in}
        actionSheetController.addAction(noAction)
        view.present(actionSheetController, animated: true, completion: nil)
        actionSheetController.setUI(.white, tintColor: .black)
    }
    
    class func showAlertView(view:UIViewController,message:String,completion:@escaping () -> ()){
        let actionSheetController = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            completion()
        }
        actionSheetController.addAction(noAction)
        view.present(actionSheetController, animated: true, completion: nil)
        actionSheetController.setUI(.white, tintColor: .black)
    }
    
    //MARK:- Color Functions
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    class func RGBColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    //MARK:- Date functions
    class func stringFromDate (date: Date, strFormatter strDateFormatter: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter
        
        let convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
    
    class func dateFromString (strDate: String, strFormatter strDateFormatter: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter
        
        let convertedDate = dateFormatter.date(from: strDate)
        
        return convertedDate!
    }
    
    class func timeAgoSinceDate(_ date:Date,currentDate:Date, numericDates:Bool) -> String {
        
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) || (components.year! >= 1){
            return self.stringFromDate(date: date, strFormatter: "dd MMMM yyyy hh:mm a")
        }else if (components.month! >= 2) || (components.month! >= 1) || (components.weekOfYear! >= 2) || (components.weekOfYear! >= 1) || (components.day! >= 2) {
            return self.stringFromDate(date: date, strFormatter: "dd MMMM hh:mm a")
        }else if (components.day! >= 1){
            if (numericDates){
                return "1 day"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) HR"
        } else if (components.hour! >= 1){
            return "1 HR"
        } else if (components.minute! >= 2) {
            return "\(components.minute!)MINS"
        } else if (components.minute! >= 1){
            return "1M"
        } else if (components.second! >= 3) {
            return "\(components.second!)S"
        } else {
            return "Just now"
        }
    }
    
    class func secondsToHoursMinutes (_ seconds : Int) -> (Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60)
    }
    
    class func isgallryAccessAllowed() -> Bool {
        
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
    
    class func isCamraAccessForAllowed() -> Bool {
        
        
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
    
    class func getAddress(coords: CLLocationCoordinate2D,handler: @escaping (String) -> Void)
    {
        var address: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coords.latitude, longitude: coords.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            
            if let locationName = placeMark?.name{
                address += locationName + ", "
            }
            
            if let street = placeMark?.subLocality{
                address += street + ", "
            }
            
            if let city = placeMark?.locality{
                address += city + ", "
            }
            
            if let country = placeMark?.country{
                address += country
            }
            
            handler(address)
        })
    }
    
    //MARK:- Video Thumb
    class func thumbnailImageForFileUrl(_ fileUrl: URL) -> UIImage? {
        let asset = AVAsset(url: fileUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            
            let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailCGImage)
            
        } catch let err {
            print(err)
        }
        
        return nil
    }
    
    class func delay(delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    class func mainTask(closure: @escaping () -> ()) {
        DispatchQueue.main.async {
            closure()
        }
    }
}
