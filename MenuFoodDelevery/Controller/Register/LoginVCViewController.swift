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
    var flag = "1"
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
            if !self.DataFiled(self.PhoneNumbertextField.text!){
                self.showToast(message: "  ادخل رقم الهاتف ")
            }else if !self.PhoneNumbertextField.text!.isValidcontact{
                self.showToast(message: "  ادخل رقم الهاتف ")
            }else{
                if success! {
                print("success---------")
                self.userSignUpCode = result!
                print(self.userSignUpCode.result?.activation_code ?? "")
                print(self.userSignUpCode.result?.phone ?? "")
                print("flag -----------> \(result?.flage ?? "")")
                if result?.flage == "0"{
                    self.flag = "0"
                    if !self.PhoneNumbertextField.text!.isValidcontact{
                        self.showToast(message: result?.message ?? "")
                    }else{
                   
                    self.performSegue(withIdentifier: "AddVerificationCodeSegue", sender: nil)
                    }
                }else{
                    self.flag = "1"
                    if !self.PhoneNumbertextField.text!.isValidcontact{
                        self.showToast(message: result?.message ?? "")
                    }else{
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                    }
                }
            }else{
                print("failed---------")
            }
        }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if flag == "0"{
            let destinationvc = segue.destination as! AddVerificationCode
            destinationvc.userPhoneAndCode = self.userSignUpCode
        }else{
            let destinationvcLogin = segue.destination as! LoginFirstVisitor
            destinationvcLogin.phone = self.PhoneNumbertextField.text
        }
    }
    
    public func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 200, height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 9.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func DataFiled(_ value:String)->Bool{
        if ( value != "" ) {
            return true
        }
        return false
    }
    
}



extension String {
    var isValidcontact: Bool {
        let phoneNumberRegex = "^[0-9]\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
    
}
