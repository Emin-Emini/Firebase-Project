//
//  RegisterViewController.swift
//  Firebase Project
//
//  Created by Emin Emini on 16.06.2022..
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func registerTouchUp(_ sender: Any) {
    }
    
    @IBAction func loginTouchUp(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
