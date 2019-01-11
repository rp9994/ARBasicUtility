//
//  SocialMediaData.swift
//  MowMowApp
//
//  Created by iOS developer on 27/12/18.
//  Copyright © 2018 Vikash Kumar. All rights reserved.
//

import Foundation

class SocialMediaData:NSObject{
    
    var first_name = String()
    var last_name = String()
    var social_id = String()
    var email = String()
    
    init(firstName:String,lastName:String,socialID:String,emailID:String) {
        first_name = firstName
        last_name = lastName
        social_id = socialID
        email = emailID
    }
    
}
