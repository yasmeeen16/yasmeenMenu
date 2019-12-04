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
    var userObjectforRegisterationSecondStep: UserDataSentForRegistration!
    @IBOutlet weak var UseNameTF: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    var phone : String!
    var activation_code : String!
    var device_reg_id : String!
    var name : String!
    var email : String!
    var password : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }

  
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true) {
            print(true)
        }
    }
    @IBAction func secondStepRegistration(_ sender: Any) {
        
        self.phone = userPhoneAndCode.result!.phone
        self.activation_code = userPhoneAndCode.result?.activation_code
        self.device_reg_id = UIDevice.current.identifierForVendor?.uuidString ?? ""
        self.name = self.UseNameTF.text
        self.email = self.userEmail.text
        self.password = self.Password.text
        
        self.performSegue(withIdentifier: "ChoseLocationSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationvc = segue.destination as! ChoseLocation
        destinationvc.phone = self.phone
        destinationvc.activation_code = self.activation_code
        destinationvc.device_reg_id = self.device_reg_id
        destinationvc.name = self.name
        destinationvc.email = self.email
        destinationvc.password = self.password
        //destinationvc.userObjectforRegisterationSecondStep = self.userObjectforRegisterationSecondStep
    }
    
}
