//
//  RegisterationClient.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/3/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import Foundation
import Alamofire
class RegisterationClient: NSObject {
    
    static func AddNewuser(key:String = "1234567890",name:String ,Phone: String,email:String,password:String,device_reg_id:String,activation_code:String,lat:String,lag:String, completion: @escaping (_ error :Error?, _ success :Bool?,_ result:userDataResponse?) -> Void){
        // let apiKey = "e64bfbcc0b2b336e875493e881b4ab9b"
        let baseAPIURL = "https://menuonedelivery.com/"
        
        let url = "\(baseAPIURL)/api/second_step"
        let parameters = [
            "key":key,
            "name":name,
            "phone":Phone,
            "email":email,
            "password":password,
            "device_reg_id":device_reg_id,
            "activation_code":activation_code,
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
                    print("response ------------------->>>>>")
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
