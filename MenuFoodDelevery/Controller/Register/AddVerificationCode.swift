//
//  AddVerificationCode.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/2/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import UIKit

class AddVerificationCode: UIViewController,UITextFieldDelegate {
    
    
    private var seconds: Int!
    private var mins: Int!
    private var timer: Timer!
    private var isTimerRunning: Bool!
    var userPhoneAndCode: SignUpFirstStepResponse!
    @IBOutlet private weak var codeTF1: UITextField!
    @IBOutlet private weak var codeTF2: UITextField!
    @IBOutlet private weak var codeTF3: UITextField!
    @IBOutlet private weak var codeTF4: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet private weak var timerLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello from verificaton code ")
        print(self.userPhoneAndCode.result?.activation_code ?? "")
        print(self.userPhoneAndCode.result?.phone ?? "")
        self.closeKeyboardOnOutsideTap()
        //displayAlert(withMessage: code ?? "")
        seconds = 60
        mins = 1
        timer = Timer()
        isTimerRunning =  false
        
        codeTF1.delegate = self
        codeTF2.delegate = self
        codeTF3.delegate = self
        codeTF4.delegate = self
        
        codeTF1.textAlignment = .center
        codeTF2.textAlignment = .center
        codeTF3.textAlignment = .center
        codeTF4.textAlignment = .center
        
        codeTF1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        codeTF2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        codeTF3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        codeTF4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
    }
  
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if true{
            if  text?.count == 1 {
                switch textField {
                case codeTF1:
                    codeTF2.becomeFirstResponder()
                case codeTF2:
                    codeTF3.becomeFirstResponder()
                case codeTF3:
                    codeTF4.becomeFirstResponder()
                case codeTF4 :
                    checkBtn.sendActions(for: .touchUpInside)
                default:
                    break
                }
            }
            
            if text?.count == 0 {
                switch textField {
                case codeTF1:
                    codeTF1.becomeFirstResponder()
                case codeTF2:
                    codeTF1.becomeFirstResponder()
                case codeTF3:
                    codeTF2.becomeFirstResponder()
                case codeTF4:
                    codeTF3.becomeFirstResponder()
                default:
                    break
                }
            }
            else{
                
            }
        } else {
            if  text?.count == 1 {
                switch textField{
                case codeTF1:
                    checkBtn.sendActions(for: .touchUpInside)
                case codeTF2:
                    codeTF1.becomeFirstResponder()
                case codeTF3:
                    codeTF2.becomeFirstResponder()
                case codeTF4:
                    codeTF3.becomeFirstResponder()
                default:
                    break
                }
            }
            if  text?.count == 0 {
                switch textField{
                case codeTF1:
                    codeTF2.becomeFirstResponder()
                case codeTF2:
                    codeTF3.becomeFirstResponder()
                case codeTF3:
                    codeTF4.becomeFirstResponder()
                case codeTF4:
                    codeTF4.becomeFirstResponder()
                default:
                    break
                }
            }
        }
        
        
        
    }
    @IBAction private func checkBtnTapped(_ sender: UIButton) {
        
        var verificationCode = ""
        
        
        verificationCode = "\(codeTF1.text!)\(codeTF2.text!)\(codeTF3.text!)\(codeTF4.text!)"
       
    
        guard verificationCode == self.userPhoneAndCode.result?.activation_code else {
            print("not equal ++++++++++++++++++++++++++++++++++")
            //displayAlert(withMessage: R.string.localizable.invalidCode())
            return
        }
        print("code equal success ++++++++++++++++++++++++++")
        self.performSegue(withIdentifier: "sendVerficationCodeSeguey", sender: nil)
        
        //        let dvc = R.storyboard.auth.registerVC()!
//        dvc.phone = phone ?? ""
//        dvc.code = code ?? ""
        //navigationController?.pushViewController(dvc, animated: true)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationvc = segue.destination as! Registrationvc
        destinationvc.userPhoneAndCode = self.userPhoneAndCode
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let string = textField.text! + string
        if string.count > 1 {
            return false
        }
        return true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        setupTimer()
        
        if true{
            codeTF1.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    private func setupTimer() {
        if isTimerRunning == false {
            runTimer()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        
        if seconds < 1 && mins == 1 {
            seconds = 60
            mins = 0
        }  else if seconds < 1 && mins == 0 {
            //resendCodeBtn.isHidden = false
            timerLbl.isHidden = true
            //waitLbl.isHidden = true
            timer.invalidate()
        } else {
            seconds -= 1
            timerLbl.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", mins, seconds)
    }
    
    @objc func resendBtnPressed(_ sender: Any) {
        seconds = 60
        mins = 1
        timerLbl.isHidden = false
        //waitLbl.isHidden = false
        //resendCodeBtn.isHidden = true
        isTimerRunning = false
        setupTimer()
    }
    
    
    func closeKeyboardOnOutsideTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
