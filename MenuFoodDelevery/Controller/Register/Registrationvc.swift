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
        if !self.DataFiled(self.UseNameTF.text!){
            self.showToast(message:"Enter Your Name")
        }else if !self.DataFiled(self.userEmail.text!){
            self.showToast(message: "Enter Your email")
        }else if !self.DataFiled(self.Password.text!){
            self.showToast(message: "Enter Password")
        }else if !isEmailValid(self.userEmail.text!){
            self.showToast(message: "Email not valid")
        }else{
        
        self.phone = userPhoneAndCode.result!.phone
        self.activation_code = userPhoneAndCode.result?.activation_code
        self.device_reg_id = UIDevice.current.identifierForVendor?.uuidString ?? ""
        self.name = self.UseNameTF.text
        self.email = self.userEmail.text
        self.password = self.Password.text
        
        self.performSegue(withIdentifier: "ChoseLocationSegue", sender: nil)
        }
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
    
    public func isEmailValid(_ value: String) -> Bool {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                print("no")
                return false
            }
        } catch {
            print("no")
            return false
        }
        
        print("yes")
        return true
    }
    public func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 50))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
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


