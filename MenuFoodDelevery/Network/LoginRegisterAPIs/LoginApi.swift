//
//  LoginApi.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/4/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//


import Foundation
import Alamofire
class LoginApi: NSObject {
    
    static func loginuser(key:String = "1234567890",Phone: String,password:String,device_reg_id:String,lat:String,lag:String, completion: @escaping (_ error :Error?, _ success :Bool?,_ result:userDataResponse?) -> Void){
        
        let baseAPIURL = "https://menuonedelivery.com/"
        
        let url = "\(baseAPIURL)/api/login_customer"
        let parameters = [
            "key":key,
            "phone":Phone,
            "password":password,
            "device_reg_id":device_reg_id,
            "lat":lat,
            "lag":lag
        ]
        let headers = [
            "Lang" : "ar"
            
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody , headers: headers).responseJSON{ (response) in
            switch response.result{
            case .failure( let error):
                print(error)
                completion(nil,false,nil)
            case .success( _):
                print(response)
                let json = response.data
                print(response)
                do{
                    //create json decoder
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(userDataResponse.self, from: json!)
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
