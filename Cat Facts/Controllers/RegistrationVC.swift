//
//  ViewController.swift
//  Cat Facts
//
//  Created by Nikita Nechyporenko on 05.01.2019.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var userData = [UserData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func checkingForms(email: String, password: String, confirmPassword: String) -> Bool {
        var result  = false
        if isValidEmail(testStr: email) == true {
            print("e-mail = true")
            if passwordCheck(passwordStr: password, confirmPasswordStr: confirmPassword) == true {
                print("password = true")
                result = true
            } else {
                print("password = false")
                result = false
            }
        } else {
             print("e-mail = false")
            result = false
        }
        return result
    }
    
    // email format check
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func passwordCheck(passwordStr: String, confirmPasswordStr: String) -> Bool {
        var checkedPassword: Bool
        if passwordStr.count > 5 {
            if passwordStr == confirmPasswordStr {
                checkedPassword = true
            } else {
                checkedPassword = false
            }
        } else {
            checkedPassword = false
        }
        return checkedPassword
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        if checkingForms(email: email, password: password, confirmPassword: confirmPassword) == true {
            let user = UserData.init(email: email, password: password)
           userData.append(user)
        } else {
//            alert
        }
    }
    
}

