//
//  ViewController.swift
//  iOS Utilities
//
//  Created by iOS developer on 27/11/18.
//  Copyright © 2018 Ronak Adeshara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnSubmit: ARLoadingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
    }
    
    //MARK:- Get current location string
    func getCurrentLocation(){
        ARLocationManager.shared.getMyLocation { (result) in
            switch result{
            case .success(let manager,_):
                ARLocationManager.shared.getAddress(coords: (manager.location?.coordinate)!, handler: { (address) in
                    print(address)
                })
                break
            case .erorr(let error):
                print(error.localizedDescription)
                break
            case .noPermission:
                break
            }
        }
    }
    
    //MARK:- Loading in uibutton
    @IBAction func btnSubmit(_ sender: ARLoadingButton) {
        sender.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            sender.hideLoading()
        }
    }
}

