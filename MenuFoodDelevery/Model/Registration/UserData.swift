//
//  File.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/3/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import Foundation
public class UserData :Codable {
    let id : String?
    let username : String?
    let name: String?
    let Phone: String?
    let email: String?
    let password:String?
    let img: String?
    let type: String?
    let lat: String?
    let lang : String?
    let status: String?
    let active: String?
    let device_reg_id : String?
    let activation_code :String?
    let creation_date: String?
    
    
}

public class UserDataResult :Codable {
    let id : String?
    let name: String?
    let username : String?
    let Phone: String?
    let email: String?
    let img: String?
    let type: String?
    let lat: String?
    let lang : String?
    let status: String?
    let active: String?
    let device_reg_id : String?
    let activation_code :String?
    let creation_date: String?
    
    
}
public class userDataResponse:Codable{
    let message: String?
    let result: UserDataResult?
    let token: String?
    
}
