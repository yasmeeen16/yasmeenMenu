//
//  File.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/2/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import Foundation
import Alamofire
class API: NSObject {
   
                private let body: String
    
                init(body: String) { self.body = body }
    
                    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
                        guard var urlRequest = urlRequest.urlRequest else { throw Errors.emptyURLRequest }
                        guard let data = body.data(using: .utf8) else { throw Errors.encodingProblem }
                        urlRequest.httpBody = data
                        return urlRequest
                    }
    
    static func AddNewuser(Taken:String = "",Phone: String, completion: @escaping (_ error :Error?, _ success :Bool?,_ result:SignUpFirstStepResponse?) -> Void){
        
                let baseAPIURL = "https://menuonedelivery.com/"

                let url = "\(baseAPIURL)/api/first_step"
                let parameters = [
                    "key":"1234567890",
                    "phone":Phone
                
                ]
                let headers = [
                    "Lang" : "ar",
                    "Taken":Taken,
                    "Content-Type" : "application/x-www-form-urlencoded"
                ]
                
                Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody , headers: headers).responseJSON{ (response) in
                    switch response.result{
                    case .failure( let error):
                        print(error)
                        completion(nil,false,nil)
                    case .success( _):
                        let json = response.data
                        print(response)
                        do{
                            //create json decoder
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(SignUpFirstStepResponse.self, from: json!)
                            print("response -------------------")
                            print(response.message!)
                           print("sucess")
                            completion(nil,true,response)
                            
                        }catch let err{
                            print(err)
                            //completion(nil,false,[],page)
                        }
                        
                    }
                    
                }
     }// end of add user Number
    
}

extension API{
    enum Errors: Error {
        case emptyURLRequest
        case encodingProblem
    }
}


