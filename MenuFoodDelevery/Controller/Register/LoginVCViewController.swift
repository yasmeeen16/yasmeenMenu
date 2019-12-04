//
//  LoginVCViewController.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/2/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import UIKit

class LoginVCViewController: UIViewController, UITextFieldDelegate{

    var userSignUpCode: SignUpFirstStepResponse!
    @IBOutlet weak var PhoneNumbertextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PhoneNumbertextField.delegate = self
        // Do any additional setup after loading the view.
    }

    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        PhoneNumbertextField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func SignupBtn(_ sender: Any) {
       
        API.AddNewuser(Phone: "\(self.PhoneNumbertextField.text!)") { (error:Error? , success: Bool?, result:SignUpFirstStepResponse? ) in
    
            if success! {
                print("success---------")
                self.userSignUpCode = result!
                print(self.userSignUpCode.result?.activation_code ?? "")
                print(self.userSignUpCode.result?.phone ?? "")
                self.performSegue(withIdentifier: "AddVerificationCodeSegue", sender: nil)
            }else{
                print("failed---------")
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationvc = segue.destination as! AddVerificationCode
        destinationvc.userPhoneAndCode = self.userSignUpCode
    }
}
