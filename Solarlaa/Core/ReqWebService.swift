//
//  ReqWebService.swift
//  Solarlaa
//
//  Created by GISC on 30/7/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import Foundation
import Alamofire

class ReqWebService {
    class func reqUrl(url: String? , params: [String: Any]?, completionHandler: @escaping (_ JSON : [String: Any]) -> ()) {
        do {
            var parameters = [String: Any]()
            if let params = params {
                parameters = params
            }
            
            let reqParameters: Parameters = parameters
            
            let headers: HTTPHeaders = [
                "Accept": "x-www-form-urlencoded",
                "Content-Type": "x-www-form-urlencoded"
            ]

            Alamofire.request(url ?? "", method: .post, parameters: reqParameters, encoding: JSONEncoding(options: []), headers: headers).responseJSON {
                response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        let jsonResult = value as! [String: Any]
                        completionHandler(jsonResult)
                    }
                case .failure(let error):
                    if let value = response.result.value {
                        let jsonResult = value as! [String: Any]
                        completionHandler(jsonResult)
                    }
                    else {
                        let jsonResult: [String:Any] = ["success": false, "total": 0, "data":[[String:Any]](), "message": error.localizedDescription, "error": error]
                        completionHandler(jsonResult)
                    }
                }
            }
        } catch let error {
            print(error)
            completionHandler(error as! [String: Any])
        }
    }
}
