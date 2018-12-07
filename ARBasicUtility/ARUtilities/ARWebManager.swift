//
//  APIManager.swift
//  WashMe
//
//  Created by iOS developer on 22/08/18.
//  Copyright © 2018 Intelivita. All rights reserved.
//

import Foundation

import Alamofire
import ObjectMapper
import SystemConfiguration
import KRProgressHUD

//

class ARWebManager {
    
    static var shared = ARWebManager()
    
    func checkConnection(completion:@escaping(Bool)->()){
        checkInternet { (result) in
            if result{
                completion(true)
            }else{
                KRProgressHUD.dismiss()
                completion(false)
            }
        }
    }
    
    func checkInternet(completion:@escaping(Bool)->())
    {
        DispatchQueue.main.async {
            var request = URLRequest(url: URL(string: "https://www.google.com")!)
            request.timeoutInterval = 5.0
            
            Alamofire.request(request).response(completionHandler: { (response) in
                if response.response == nil{
                    KRProgressHUD.dismiss()
                    completion(false)
                }else{
                    if response.response!.statusCode == 200{
                        completion(true)
                    }else{
                        KRProgressHUD.dismiss()
                        completion(false)
                    }
                }
            })
        }
    }
    
    func api_formDataCall(withToken:Bool,url:String,params:[String:String],file_arr:[String:AnyObject],completion:@escaping([String:AnyObject]?,String)->()){
        checkConnection { (result) in
            if result {
                
                let headers : HTTPHeaders = [:]
                
                print("*******************************************************")
                print(url)
                print(params)
                print("*******************************************************")

                Alamofire.upload(multipartFormData: { multipartFormData in
                    for (key, value) in params{
                        multipartFormData.append(value.data(using: .utf8)!, withName: key)
                    }
                    let name = "\(Date().timeIntervalSince1970)"
                    if file_arr.count > 0{
                        for (_,element) in file_arr.enumerated(){
                            if let img = element.value as? UIImage{
                                if let imageData = img.pngData(){
                                    multipartFormData.append(imageData, withName: element.key, fileName: name + ".png", mimeType: "image/png")
                                }
                            }
                            if let url = element.value as? URL{
                                multipartFormData.append(url, withName: element.key, fileName: name + ".png", mimeType: "image/png")
                            }
                        }
                    }
                    
                }, usingThreshold: 1, to: url, method: .post, headers: headers, encodingCompletion: { encoding in
                    
                    switch encoding {
                    case .success(let upload, _, _):
                        upload.uploadProgress(closure: { (progres) in
                            print(progres.fractionCompleted * 100)
                        })
                        upload.responseJSON {
                            response in
                            print("*******************************************************")
                            print(response)
                            print("*******************************************************")
                            switch(response.result) {
                            case .success:
                                
                                if let json = response.result.value as? [String : AnyObject]
                                {
                                    var resultDict = json
                                    if let msg = json["message"] as? String{
                                        completion(json,msg)
                                    }
                                    if let msg = json["error"] as? String{
                                        resultDict["message"] = "" as AnyObject
                                        completion(resultDict,msg)
                                    }
                                }
                                
                            case .failure(let error):
                                if error.localizedDescription == "The network connection was lost."{
                                    completion(nil,ValidationMessages.somethingWrong)
                                }
                                completion(nil,error.localizedDescription)
                            }
                        }
                    case .failure(let encodingError):
                        if encodingError.localizedDescription == "The network connection was lost."{
                            completion(nil,ValidationMessages.somethingWrong)
                        }
                        completion(nil,encodingError.localizedDescription)
                    }
                })
            }else{
                ARUtilities.delay(delay: 0.1, closure: {
                    KRProgressHUD.dismiss()
                    completion(nil,ValidationMessages.noNetwork)
                })
            }
        }
    }
    
    func getAPICall(withToken:Bool,url:String,completion:@escaping([String:AnyObject]?,String)->()){
        
        checkConnection { (result) in
            if result {
                
                let headers : HTTPHeaders = [:]
                
                Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                    switch(response.result) {
                        
                    case .success:
                        print("==========================================")
                        print(response.result.value!)
                        print("==========================================")
                        if let json = response.result.value as? [String : AnyObject]{
                            
                            if let msg = json["message"] as? String{
                                completion(json,msg)
                            }
                            if let msg = json["error"] as? String{
                                completion(json,msg)
                            }
                            
                        }
                    case .failure:
                        self.cancelPreviousAPICall {
                            KRProgressHUD.dismiss()
                        }
                        completion(nil, ValidationMessages.somethingWrong)
                    }
                })
                
            }else{
                KRProgressHUD.dismiss()
                completion(nil,ValidationMessages.noNetwork)
            }
        }
    }
    
    func postAPICall(withToken:Bool,url:String, params:[String:Any],completion:@escaping([String:AnyObject]?,String)->()){
        
        checkConnection { (result) in
            if result {
                
                let headers : HTTPHeaders = [:]
                
                Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                    switch(response.result) {
                        
                    case .success:
                        print("==========================================")
                        print(response.result.value!)
                        print("==========================================")
                        if let json = response.result.value as? [String : AnyObject]{
                            
                            if let msg = json["message"] as? String{
                                completion(json,msg)
                            }
                            if let msg = json["error"] as? String{
                                completion(json,msg)
                            }
                            
                        }
                    case .failure:
                        self.cancelPreviousAPICall {
                            KRProgressHUD.dismiss()
                        }
                        completion(nil, ValidationMessages.somethingWrong)
                    }
                })
                
            }else{
                KRProgressHUD.dismiss()
                completion(nil,ValidationMessages.noNetwork)
            }
        }
    }
    
    
    func cancelPreviousAPICall(completion:@escaping ()->()) {
        
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler {
            
            dataTasks, uploadTasks, downloadTasks in dataTasks.forEach {
                $0.cancel()
            };
            uploadTasks.forEach {
                $0.cancel()
            };
            downloadTasks.forEach {
                $0.cancel()
            }
            completion()
        }
    }
    
}
