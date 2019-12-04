//
//  SignUpFirstStepResponse.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/2/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import Foundation
public class SignUpFirstStepResponse:Codable{
    let flage : String?
    let message: String?
    let result: result?
    
}

public class result :Codable{
    let activation_code: String?
    let phone: String?
    
}
