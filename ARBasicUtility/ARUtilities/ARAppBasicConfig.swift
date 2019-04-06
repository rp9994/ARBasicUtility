//
//  Constants.swift
//  VideoApp
//
//  Created by Vikash on 17/11/18.
//  Copyright © 2018 Vikash. All rights reserved.
//

import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let currentController = appDelegate.window?.rootViewController

struct AppDetails {
    static let name = "App Name"
    
    
    enum urls {
        static let live = ""
        static let local = ""
        static let socket = ""
        static let appStoreUrl = ""
    }
    
    enum version {
        static let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        static let appBuildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        
        static let versionWithBuildNumber = "v. \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String) (\(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String))"
    }
}


enum ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}


struct ValidationMessages {
    static let somethingWrong = "Internet connection seems to be slow, or problem with connecting to server"
    static let noNetwork = "Seems like you don't have an active internet connection"
    
    static let allFieldBlank = "All fields are mandatory"
    
    static let enterFname = "Please enter your first name"
    static let enterLname = "Please enter your last name"
    static let enterFullName = "Please enter your full name"
    static let enterUserName = "Please enter your user name"
    static let enterEmail = "Please enter your email address"
    static let enterPassword = "Please enter password"
    static let enterOldPassword = "Please enter old password"
    static let enterNewPassword = "Please enter new password"
    static let enterConfirmPassword = "Please enter confirm password"
    static let enterPhoneNumber = "Please enter your phone number"
    static let enterDob = "Please enter your date of birth"
    
    static let enterParentEmail = "Please enter your parent's email address"
    
    static let invalidFname = "Please enter valid first name"
    static let invalidLname = "Please enter valid last name"
    static let invalidFullName = "Please enter valid full name"
    static let invalidEmail = "Please enter valid email address"
    static let invalidPhoneNumebr = "Please enter valid phone number"
    static let parentEmailNotSameAsUserEmail = "User and parent's email should be different."
    
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
    static let passwordDoesNotMatchWithConfirmPassword = "Passwords do not match."
    
    static let logoutConfirmation = "Are you sure want to logout?"
    static let deleteConfirmation = "Are you sure want to delete?"
    
    static let successfulLogin = "You are successfully login to \(AppDetails.name)"
    static let successfulRegistration = "You are successfully register to \(AppDetails.name)"
    
    static let noCameraAccess = "You have denied the camera persmission. Please change it from Setting -> \(AppDetails.name)"
    static let noGalleryAccess = "You have denied the photo library persmission. Please change it permission from Setting -> \(AppDetails.name)"
    
    static let validOTP = "Your Phone number Verfied Successfully."
    static let invalidaOTP = "One time password is incorrect. Please try again."
    static let otpSent = "One time password has been sent to your Mobile for verify the Account."
    static let invalidVerficationCode = "Please Enter Verification Code."
}

struct ValidCharacter {
    static let onlyNumber = CharacterSet.init(charactersIn: "0123456789")
    static let onlyAlphabets = CharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
    static let onlyMobileNumber = CharacterSet.init(charactersIn: "0123456789")
    static let onlyMobileNumberWithPlus = CharacterSet.init(charactersIn: "+0123456789")
    static let onlyAlphabetsWithSpace = CharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")
    static let onlyAlphaNumericWithSpecialChar = CharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz` !@#/$%^&*()_+|}{;:><")
    static let onlyAlphaNumeric = CharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
    static let onlyAlphaNumericWithSpace = CharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ")
    static let onlyZipcodeChar = CharacterSet.init(charactersIn: "-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
    static let onlyUserName = CharacterSet.init(charactersIn: "_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
}
