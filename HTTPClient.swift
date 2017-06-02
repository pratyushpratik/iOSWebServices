//
//  HTTPClient.swift
//  Bar Finder
//
//  Created by Shivang Mishra on 03/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation
import Alamofire

public class HTTPClient {
    
    typealias JsonResponse = (_ data : Any?,_ error : Error?,_ result : APIResult) -> ()
    
    static func callRestApi(Of method : APIMethod?,with params : [String : Any]?,imagesToSend : [PostWithImageRequest]? = nil, on url : String?, with headers: [String:String]?, rawJsonOnCompletion : @escaping JsonResponse) {
        
        guard  let _method = method else { rawJsonOnCompletion(nil, nil, .failure); return }
        switch _method {
        case .get:
            Alamofire.request(/url, method: _method.associatedHttpMethod(), parameters: params,headers : headers)
                .responseJSON { response in
                    
                    switch(response.result) {
                        
                    case .success(let data):
                        rawJsonOnCompletion(data, nil, .success)
                    case .failure(let error):
                        rawJsonOnCompletion(nil, error, .failure)
                    }
            }
        case .postWithImage:
            
            guard let _params = params else { rawJsonOnCompletion(nil, nil, .failure); return}
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                if let arrayImages = imagesToSend {
                    for sendImage in arrayImages {
                        
                        guard let imageData = UIImageJPEGRepresentation(/sendImage.image, 0.5) else {
                            return }
                        
                        multipartFormData.append(imageData, withName: /sendImage.imageParam, fileName: /sendImage.imageParam, mimeType: "image/jpg")
                    }
                }
                
                for (key, value) in _params {
                    
                    guard let val = ((value as? String)?.data(using: String.Encoding.utf8)) else { return }
                    multipartFormData.append(val, withName: key)
                }
                
            }, to: /url) { (encodingResult) in
                switch encodingResult {
                case .success(let upload,_,_):
                    
                    upload.responseJSON { response in
                        switch response.result {
                        case .success(let data):
                            rawJsonOnCompletion(data, nil, .success)
                        case .failure(let error):
                            rawJsonOnCompletion(nil, error, .failure)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    rawJsonOnCompletion(nil, encodingError, .failure)
                }
            }
        default:
            
            Alamofire.request(/url, method: _method.associatedHttpMethod(), parameters: params,encoding : JSONEncoding.default,headers : headers)
                .responseJSON { response in
                    
                    switch(response.result) {
                        
                    case .success(let data):
                        rawJsonOnCompletion(data, nil, .success)
                    case .failure(let error):
                        rawJsonOnCompletion(nil, error, .failure)
                    }
            }
        }
    }
}
