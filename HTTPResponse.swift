//
//  HTTPResponse.swift
//  Saloon User
//
//  Created by Shivang Mishra on 01/04/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let defaultResponseClosure = {() -> () in  }

enum Success : Int {
    
    case adminBlock = -2
    case accessTokenErr = -1
    case fail = 0
    case success = 1
    case appVersion = 5
}

enum StatusCode : Int {
    
    case success = 200
    case badRequest = 400
    case paramMissing = 402
    case serverErr = 500
    case accessTokenRequired = 401
}

//MARK: - API Result
public enum APIResult {
    
    case failure
    case success
    case internetDown
    
    func `is`(success : Int?) -> Bool {
        
        guard let successE = Success(rawValue: /success) else { return false }
        let isSuccess = successE == .success ? true : false
        return isSuccess
    }
    
    func `is`(versioning : Int?) -> Bool {
        
        guard let successE = Success(rawValue: /versioning) else { return false }
        let isSuccess = successE == .appVersion ? true : false
        return isSuccess
    }
    
    func `is`(sessionExpired : Int?) -> Bool {
        
        guard let sessionExpE = Success(rawValue: /sessionExpired) else { return false }
        let isSessionExp = sessionExpE == .accessTokenErr ? true : false
        return isSessionExp
    }
    
    func `is`(paramMissing : Int?) -> Bool {
        
        guard let statusE = StatusCode(rawValue: /paramMissing) else { return false }
        let isparamMissing = statusE == .paramMissing ? true : false
        return isparamMissing
    }
    
    public typealias resultClosures = () -> ()
    
    public func handleResponse(sender : UIViewController?, titleOfalert : AlertTitle = AlertTitle(), msgOfalert : AlertMessage = AlertMessage(), response : Any?, successFailAlert : Bool = true, failureBlock : @escaping resultClosures = defaultResponseClosure, successBlock : @escaping resultClosures = defaultResponseClosure, noInternetBlock : @escaping resultClosures = defaultResponseClosure, successFailBlock : @escaping resultClosures = defaultResponseClosure) {
        
        DispatchQueue.main.async {
            
            switch self {
                
            case .failure:
                
                if let _ = response as? EmptyResponse {
                    if let msg = msgOfalert.error {
                        Alert().show(title: titleOfalert.error, message: msg, viewController: sender, okAction: {
                            failureBlock()
                        })
                    }
                    else { failureBlock() }
                }
                else {
                    Alert().show(title: GlobalConstants.AppDetails.appName, message: ErrorMessage.somethingWentWrong, viewController: sender)
                }
            case .success:
                
                if let success = response as? BaseResponse {
                    
                    if self.is(success: success.success) {
                        
                        if let msg = msgOfalert.success {
                            
                            Alert().show(title: titleOfalert.success, message: msg, viewController: sender, okAction: {
                                successBlock()
                            })
                        }
                        else { successBlock() }
                    }
                    else if self.is(versioning : success.success) {
                        
                        Alert().show(title: titleOfalert.success, message: success.msg, viewController: sender, okAction: {
                            
                        })
                    }
                    else if self.is(sessionExpired: success.success) {
                        
                        Alert().show(title: nil, message: success.msg, viewController: sender, okAction: {
                            sender?.logout()
                        })
                    }
                    else {
                        if !successFailAlert { successFailBlock() }
                        else {
                            Alert().show(title: titleOfalert.success, message: success.msg ?? ErrorMessage.somethingWentWrong, viewController: sender, okAction: {
                                successFailBlock()
                            })
                        }
                    }
                }
                
            case .internetDown:
                
                if let msg = msgOfalert.noInternet {
                    Alert().show(title: titleOfalert.noInternet, message: msg, viewController: sender, okAction: {
                        noInternetBlock()
                    })
                }
                else { noInternetBlock() }
            }
        }
    }
}
