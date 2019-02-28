//
//  LoginViewController.swift
//  BitTicker
//
//  Created by skyit on 2/27/19.
//  Copyright © 2019 skyit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func onSwitchButtonHandler(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"

    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "BitTicker", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onLoginButtonHandler(_ sender: Any) {
        let kUserDefault = UserDefaults.standard

        let data = kUserDefault.value(forKey: "RegisterUserData") as? Data
        if(!(data != nil)) {
            self.showAlert(message: "Please signup to use the app")
            return
        }
        let dict = try? PropertyListDecoder().decode([String:RegisterUser].self, from: data!)
        
        guard let registerUser = dict else {
            return
        }
        guard let userCredentail  = registerUser["RegisterUser"] else {
            return
        }
        
        if(self.username.text == userCredentail.emailId && self.password.text == userCredentail.password){
            if(btnSwitch.isOn){
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tickerIdentifier") as? TickerViewController {
                    if let navigator = navigationController {
                        navigator.pushViewController(viewController, animated: true)
                    }
                }
            }else {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "landingIdentifier") as? ViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
        } else {
            self.showAlert(message: "Username/Password not matched!")
        }
    }
    
    @IBAction func onSignUpButtonHandler(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signUpIdentifier") as? RegistrationViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
