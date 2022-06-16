//
//  FeedViewController.swift
//  Firebase Project
//
//  Created by Emin Emini on 16.06.2022..
//

import UIKit
import Firebase

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch let error {
            print("Error: ", error.localizedDescription)
        }
    }
    

}
