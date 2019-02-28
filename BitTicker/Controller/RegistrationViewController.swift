//
//  RegistrationViewController.swift
//  BitTicker
//
//  Created by skyit on 2/27/19.
//  Copyright © 2019 skyit. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var password: UITextField!
    var validationItems = [Int]()

    @IBAction func onSubmitButtonClicked(_ sender: Any) {
       print("onSubmitButtonClicked")
        guard let fName = self.firstname.text, let lName = self.lastName.text,
              let email = self.emailId.text , let password = self.password.text   else {
            return
        }
        let kUserDefault = UserDefaults.standard
        let registerUser = RegisterUser(firstName:fName,
                                        lastName:lName,
                                        emailId:email,
                                        password:password)
        
        let dictionary: [String:RegisterUser] = ["RegisterUser":registerUser]
        
        kUserDefault.set(try? PropertyListEncoder().encode(dictionary),forKey: "RegisterUserData")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Registration"
        validationItems.append(0)
        validationItems.append(0)
        validationItems.append(0)
        validationItems.append(0)
    }
}

//MARK: - UITextfield Delegate
extension RegistrationViewController: UITextFieldDelegate{
    
    @objc func textFieldDidChange(_ tf: UITextField) {
        switch tf.tag {
        case 0:
            validationItems[0] = (tf.text?.count == 0) ? 0 : 1
        case 1:
            validationItems[1] = (tf.text?.count == 0) ? 0 : 1
        case 2:
            validationItems[2] = (tf.text?.count == 0) ? 0 : 1
        case 3:
            validationItems[3] = (tf.text?.count == 0) ? 0 : 1
        
        default:
            break
        }
        
        self.btnSubmit.isEnabled = (validationItems.filter({$0>=1}).count == 4) ? true : false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == self.firstname ) {
             validationItems[0] = (textField.text?.count == 0) ? 0 : 1
        }else if(textField == self.lastName ){
            validationItems[1] = (textField.text?.count == 0) ? 0 : 1
        }else if(textField == self.emailId ){
            validationItems[2] = (textField.text?.count == 0) ? 0 : 1
        }else if(textField == self.password ){
            validationItems[3] = (textField.text?.count == 0) ? 0 : 1
        }
        
        self.btnSubmit.isEnabled = (validationItems.filter({$0>=1}).count == 4) ? true : false
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let t1 = textField.text?.count else {
            return
        }
        
        if(textField == self.firstname ) {
            validationItems[0] = (t1 == 0) ? 0 : 1
        }else if(textField == self.lastName ){
            validationItems[1] = (t1 == 0) ? 0 : 1
        }else if(textField == self.emailId ){
            validationItems[2] = (t1 == 0) ? 0 : 1
        }else if(textField == self.password ){
            validationItems[3] = (t1 == 0) ? 0 : 1
        }
    }
}

