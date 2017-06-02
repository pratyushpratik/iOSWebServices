//
//  HTTPParser.swift
//  Bar Finder
//
//  Created by Shivang Mishra on 03/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation

//MARK: - HTTP Parser
public class HTTPParser {
    
    static func parseResponse<R : Unwind>(response : Any?,responseclass : R?, error : Error?, result : APIResult) -> (model : Any?, result : APIResult) {
        
        guard let _ = responseclass, let _response = response else {
            return (EmptyResponse(with: .failure),.failure)
        }
        
        switch result {
            
            case .failure,.internetDown:
                return (EmptyResponse(with: .failure),.failure)
            case .success:
                let obj = R(with: _response)
                return (obj,.success)
        }
    }
    
    static func parseRequest(request : Any) -> (paramDict : [String:Any]?, ApiUrl : String?, ApiMethod : APIMethod?) {
        
        var params : [String : Any]?
        var url : String?
        var method : APIMethod?
        
        if let jsonableRequest = request as? JSONAble {
            
            params = jsonableRequest.toDict()
            if let baserequest = request as? BaseRequest {
                url = APIUrl.base.description + /baserequest.url?.description 
                method = baserequest.method
            }
        }
        return (paramDict : params, ApiUrl : url, ApiMethod : method)
    }
}
