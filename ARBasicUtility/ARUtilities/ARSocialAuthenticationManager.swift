//
//  SocialSignupManager.swift
//  MowMowApp
//
//  Created by iOS developer on 27/12/18.
//  Copyright © 2018 Vikash Kumar. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import TwitterKit

class ARSocialAuthenticationManager : NSObject {
    
    //MARK:- Variable Declarations
    private var completionBlock: ((SocialMediaData?) -> Void)!
    weak private var viewController:UIViewController!
    
}

//MARK:- Facebook login
extension ARSocialAuthenticationManager{
    
    func facebook(viewController:UIViewController,completion:@escaping(SocialMediaData?,String)->()){
        let fbLoginManager = FBSDKLoginManager()
        
        
        fbLoginManager.logOut()
        
        fbLoginManager.logIn(withReadPermissions: ["email","public_profile"], from: viewController) { (result, error) -> Void in
            if error != nil{
                completion(nil,error!.localizedDescription)
            }else{
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                
                if (result?.isCancelled)!{
                    print("cancel by user")
                    completion(nil,"")
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    
                    if((FBSDKAccessToken.current()) != nil) {
                        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                            if (error == nil){
                                guard let first_name = (result as! [String:AnyObject])["first_name"] as? String else { return }
                                guard let last_name = (result as! [String:AnyObject])["last_name"] as? String else { return }
                                guard let email = (result as! [String:AnyObject])["email"] as? String else { return }
                                guard let social_id = (result as! [String:AnyObject])["id"] as? String else { return }
                                let data = SocialMediaData.init(firstName: first_name, lastName: last_name, socialID: social_id, emailID: email)
                                completion(data,"")
                                
                            }
                        })
                    }
                } else {
                    completion(nil,"")
                }
            }
        }
    }
}

//MARK:- Google login
extension ARSocialAuthenticationManager: GIDSignInDelegate, GIDSignInUIDelegate{
    
    func google(controller:UIViewController,completion:@escaping(SocialMediaData?)->()){
        viewController = controller
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.signIn()
        self.completionBlock = completion
    }
    
    
    
    //MARK:- Google Sign In Delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil{
            let data = SocialMediaData.init(firstName: user.profile.name, lastName: user.profile.familyName, socialID: user.authentication.idToken, emailID: user.profile.email)
            print(data)
            completionBlock(data)
        }else{
            completionBlock(nil)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        completionBlock(nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        viewController.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
}


//MARK:- Twitter Logins
extension ARSocialAuthenticationManager{
    func twitter(completion:@escaping ((SocialMediaData?) -> Void)){
        
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if (session != nil) {
                print("signed in as \(session!.userName)");
                let data = SocialMediaData(firstName: (session!.userName), lastName: "", socialID: session!.userID, emailID: "")
                completion(data)
            } else {
                print("error: \(error!.localizedDescription)");
                completion(nil)
            }
        }
    }
}
