//
//  AuthorizationVC.swift
//  Cat Facts
//
//  Created by Nikita Nechyporenko on 05.01.2019.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import RealmSwift

class AuthorizationVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let realm = try! Realm() //access to storage
    var userData: Results<UserRegistrationData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userData = realm.objects(UserRegistrationData.self)
    }
    
    func checkingUser(email: String, password: String) -> Bool {
        var result = false
        for i in 0..<userData.count {
            let userOnce = userData[i]
            if userOnce.userEmail == email {
                if userOnce.userPassword == password {
                    result = true
                    return result
                } else {
                    result = false
                }
            } else {
                result = false
            }
        }
        return result
    }
    
    func alertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertOkAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func checkingForms(email: String, password: String) -> Bool {
        var result  = false
        if isValidEmail(testStr: email) == true {
            if passwordCheck(passwordStr: password) == true {
                result = true
            } else {
                result = false
            }
        } else {
            alertController(title: "Format is not correct", message: "for example:  petrov@gmail.com")
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
    
    // password format check
    func passwordCheck(passwordStr: String) -> Bool {
        var checkedPassword: Bool
        if passwordStr.count > 4 {
            checkedPassword = true
        } else {
            checkedPassword = false
            alertController(title: "Format is not correct", message: "password must be at least five characters")
        }
        return checkedPassword
    }
    
    @IBAction func logInButton(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        if checkingForms(email: email, password: password) == true {
            if checkingUser(email: email, password: password) == true {
                userStatus = true
                let vc = storyboard?.instantiateViewController(withIdentifier: "GeneralVC")
                self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                alertController(title: "Invalid email or password", message: "check email or password and try again")
            }
        } else {
        }
    }
}
