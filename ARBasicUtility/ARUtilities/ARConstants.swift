//
//  Constants.swift
//  ARBasic
//
//  Created by Ronak Adeshara on 17/11/18.
//  Copyright © 2018 Ronak Adeshara. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Basics
let APP_NAME = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
let APP_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let APP_STORE_URL = ""

struct ValidationMessages {
    static let somethingWrong = "Internet connection seems to be slow, or problem with connecting to server"
    static let noNetwork = "Seems like you don't have an active internet connection"
    
    static let allFieldBlank = "All fields are mandatory"
    
    static let enterFname = "Please enter your first name"
    static let enterLname = "Please enter your last name"
    static let enterFullName = "Please enter your full name"
    static let enterEmail = "Please enter your email address"
    static let enterPassword = "Please enter password"
    static let enterOldPassword = "Please enter old password"
    static let enterNewPassword = "Please enter new password"
    static let enterConfirmPassword = "Please enter confirm password"
    static let enterPhoneNumber = "Please enter your phone number"
    
    static let invalidFname = "Please enter valid first name"
    static let invalidLname = "Please enter valid last name"
    static let invalidFullName = "Please enter valid full name"
    static let invalidEmail = "Please enter valid email address"
    static let invalidPhoneNumebr = "Please enter valid phone number"
    
    static let  invalidPassword6 = "Password must be atleast 6 character or more"
    static let invalidPassword8 = "Password must be atleast 8 character or more"
    
    static let invalidOldPassword6 = "Old Password must be atleast 6 character or more"
    static let invalidOldPassword8 = "Old Password must be atleast 8 character or more"
    
    static let invalidNewPassword6 = "New Password must be atleast 6 character or more"
    static let invalidNewPassword8 = "New Password must be atleast 8 character or more"
    
    static let invalidConfirmPassword6 = "Confirm Password must be atleast 6 character or more"
    static let invalidCofirmPassword8 = "Confirm Password must be atleast 8 character or more"
    
    static let invalidPasswordMatch = "Password and confirm password must be same"
    static let invalidOldAndNewMatch = "Old Password and new password must be different"
    
    static let logoutConfirmation = "Are you sure want to logout?"
    static let deleteConfirmation = "Are you sure want to delete?"
    
    static let successfulLogin = "You are successfully login to \(APP_NAME)"
    static let successfulRegistration = "You are successfully register to \(APP_NAME)"
    
    static let noCameraAccess = "You have denied the camera persmission. Please change it from Setting -> \(APP_NAME)"
    static let noGalleryAccess = "You have denied the photo library persmission. Please change it permission from Setting -> \(APP_NAME)"
    
    static let validOTP = "Your Phone number Verfied Successfully."
    static let invalidaOTP = "One time password is incorrect. Please try again."
    static let otpSent = "One time password has been sent to your Mobile for verify the Account."
    static let invalidVerficationCode = "Please Enter Verification Code."
}

