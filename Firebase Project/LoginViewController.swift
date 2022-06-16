//
//  LoginViewController.swift
//  Firebase Project
//
//  Created by Emin Emini on 16.06.2022..
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func loginTouchUp(_ sender: Any) {
        loginFlow()
    }
    
    @IBAction func registerTouchUp(_ sender: Any) {
    }
    
}

// MARK: - Firebase Authentication
extension LoginViewController {
    func loginAuth(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let user = result?.user, error == nil else {
                print("Failed to login user.\nError:\(error?.localizedDescription)")
                return
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "feedVC")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}

// MARK: - TextField Validation
extension LoginViewController {
    func loginFlow() {
        guard let email = emailTextField.text else {
            print("Email cannot be empty")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("Password cannot be empty")
            return
        }
        
        loginAuth(email, password)
    }
}
