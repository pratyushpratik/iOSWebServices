//
//  WebServiceUtil.swift
//  Bar Finder
//
//  Created by Shivang Mishra on 01/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation

//MARK: - HTTP Handler
public class HTTPHandler {
    
    public static var header : [String : String]? {
        let accessToken = LocalStore.accessToken
        return ["authorization" : "bearer \(/accessToken)"]
    }
    
    typealias ApiHandlerCompletion = ( _ responseObject : Any?, _ result : APIResult) -> ()
    
    static func handleAPICallFor<R : Unwind>(requestParam : Any?,imagesToSend : [PostWithImageRequest]? = nil, shouldAddHeader : Bool = false, responseObj : R?, receive responseOnCompletion : @escaping ApiHandlerCompletion) {
        
        DispatchQueue.global(qos: .background).async {
            
            /*
             If no internet, return empty response with internetDown status
             */
            
            if !ReachabilityManager.shared.connectedToNetwork() {
                responseOnCompletion(EmptyResponse(with: .internetDown), .internetDown)
            }
            /*
             Validation of request
             */
            guard let validParams = requestParam else {
                responseOnCompletion(EmptyResponse(with: .failure), .failure)
                return
            }
            
            /*
             Parse raw request to http format [param, method, url]
             */
            
            let parsedRequest = HTTPParser.parseRequest(request: validParams)
            
            /*
             Call Rest Api of Http Client
             */
            
            HTTPClient.callRestApi(Of: parsedRequest.ApiMethod, with: parsedRequest.paramDict,imagesToSend : imagesToSend, on: parsedRequest.ApiUrl, with: shouldAddHeader ? header : nil) { (response, error,result) in
                
                if let e = error {
                    responseOnCompletion(EmptyResponse(with: .failure), .failure)
                    debugPrint("The error is : \(e)")
                }
                else {
                    /*
                     Parse raw Json to response
                     */
                    
                    let parsedResponse = HTTPParser.parseResponse(response: response, responseclass: responseObj, error: error, result: result)
                    responseOnCompletion(parsedResponse.model, parsedResponse.result)
                }
            }
        }
    }
}
