//
//  Registrationvc.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/3/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import UIKit

class Registrationvc: UIViewController {
    var userPhoneAndCode: SignUpFirstStepResponse!
    
    @IBOutlet weak var UseNameTF: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello from registration add data --------------")
        print(userPhoneAndCode.result?.phone ?? "" )
        print(userPhoneAndCode.result?.activation_code ?? "" )
        print(UIDevice.current.identifierForVendor?.uuidString ?? "")
      
    }

    @IBAction func secondStepRegistration(_ sender: Any) {
    }
}
