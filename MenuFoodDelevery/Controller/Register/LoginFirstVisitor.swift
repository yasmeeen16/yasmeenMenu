//
//  LoginFirstVisitor.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/4/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import UIKit

class LoginFirstVisitor: UIViewController {
    var phone:String!
    var device_reg_id = "\(UIDevice.current.identifierForVendor?.uuidString ?? "")"

    
    @IBOutlet weak var PasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func LoginBtn(_ sender: Any) {
        LoginApi.loginuser(Phone: phone, password: PasswordTF.text ?? "", device_reg_id: device_reg_id, lat: "", lag: "") { (error, success, result) in
            if (result?.token) != nil{
                print("token: --------------->  \(result?.token ?? "")")
            }else{
                print("message ---------------> \(result?.message ?? "")")
            }
        }
    }
    
    @IBAction func DesmissBtn(_ sender: Any) {
        self.dismiss(animated: false) {
            print(true)
        }
    }
    
}
