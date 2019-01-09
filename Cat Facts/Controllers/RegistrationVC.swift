//
//  ViewController.swift
//  Cat Facts
//
//  Created by Nikita Nechyporenko on 05.01.2019.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import RealmSwift

var arrData = [Response]()

class RegistrationVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let realm = try! Realm() //access to storage
    var userData: Results<UserRegistrationData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userData = realm.objects(UserRegistrationData.self)
    }
    
    func alertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertOkAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func checkingForms(email: String, password: String, confirmPassword: String) -> Bool {
        var result  = false
        if isValidEmail(testStr: email) == true {
            if passwordCheck(passwordStr: password, confirmPasswordStr: confirmPassword) == true {
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
    func passwordCheck(passwordStr: String, confirmPasswordStr: String) -> Bool {
        var checkedPassword: Bool
        if passwordStr.count > 4 {
            if passwordStr == confirmPasswordStr {
                checkedPassword = true
            } else {
                alertController(title: "Format is not correct", message: "confirm password is not correct")
                checkedPassword = false
            }
        } else {
            alertController(title: "Format is not correct", message: "password must be at least five characters")
            checkedPassword = false
        }
        return checkedPassword
    }
    
    func checkingUser(email: String, password: String) -> Bool {
        var result = true
        print("checkingUser in progres")
        for i in 0..<userData.count {
            let userOnce = userData[i]
            if userOnce.userEmail == email {
                result = false
                return result
            } else {
                result = true
            }
        }
        print("result === \(result)")
        return result
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        if checkingForms(email: email, password: password, confirmPassword: confirmPassword) == true {
            let user = UserRegistrationData()
            user.userEmail = email
            user.userPassword = password
            if checkingUser(email: email, password: password) == true {
                try! realm.write {
                    realm.add(user)
                }
                let vc = storyboard?.instantiateViewController(withIdentifier: "GeneralVC")
                self.navigationController?.pushViewController(vc!, animated: true)
                
            } else {
                alertController(title: "User is already registered", message: "")
                print("error checkingUser")
            }
        } else {
            print("error checkingForms")
        }
    }
}

