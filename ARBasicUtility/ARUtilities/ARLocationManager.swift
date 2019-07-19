//  Utilities.swift
//  ARBasic
//
//  Created by Ronak Adeshara on 17/11/18.
//  Copyright © 2018 Ronak Adeshara. All rights reserved.
//

import Foundation
import CoreLocation

class ARLocationManager: NSObject, CLLocationManagerDelegate {
    
    //MARK:- Create singlton object
    static let shared = ARLocationManager()
    
    //MARK:- class return result
    enum LocationPickResult {
        case noPermission
        case erorr(Error)
        case success((CLLocationManager,[CLLocation]))
    }
    
    //MARK:- Variable declaration
    private var completionBlock: ((LocationPickResult) -> Void)!
    var locationManager:CLLocationManager?
    
    //MARK:- Object Methods
    func setup() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
    }
    
    func getMyLocation(completion: @escaping (LocationPickResult) -> Void){
        setup()
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager?.startUpdatingLocation()
        }else{
            completion(.noPermission)
        }
        self.completionBlock = completion
    }
    
    //MARK:- Location Delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        completionBlock(.success((manager, locations)))
        locationManager?.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionBlock(.erorr(error))
    }
    //MARK:- In order to get address from latitude call this method
    func getAddress(coords: CLLocationCoordinate2D,handler: @escaping (String) -> Void)
    {
        var address: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coords.latitude, longitude: coords.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            
            if let street = placeMark?.subLocality{
                address += street + ", "
            }
            
            if let city = placeMark?.locality{
                address += city + ", "
            }
            
            if let country = placeMark?.country{
                address += country + ", "
            }
            
            if let zip = placeMark?.postalCode{
                address += zip
            }
            
            handler(address)
        })
    }
}

