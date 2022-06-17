//
//  ProfileViewController.swift
//  Firebase Project
//
//  Created by Emin Emini on 16.06.2022..
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ImageService.getImage(withURL: UserService.currentUserProfile!.photoURL) { image in
            self.userProfileImage.image = image
        }
        usernameLabel.text = UserService.currentUserProfile?.username
    }
    
    // MARK: - Actions
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UserService.currentUserProfile = nil
            self.dismiss(animated: true)
        } catch let error {
            print("Error: ", error.localizedDescription)
        }
    }

    @IBAction func deleteAccount(_ sender: Any) {
        showAlert()
    }
}

extension ProfileViewController {
    func showAlert() {
        let actionSheet = UIAlertController(title: "Delete Account", message: "Pay attention, if you delete your account, you'll not be able to revert it.", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action: UIAlertAction) in
            self.deleteAccount()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        let xOrigin = Int(self.view.frame.width)/2 // Replace this with one of the lines at the end
        let popoverRect = CGRect(x: xOrigin, y: Int(self.view.frame.height)/2, width: 1, height: 1)
        actionSheet.popoverPresentationController?.sourceRect = popoverRect
        actionSheet.popoverPresentationController?.permittedArrowDirections = .up

        //present(ac, animated: true)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func deleteAccount() {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if error != nil {
                print("Failed to delete user: \(error?.localizedDescription)")
            } else {
                print("Account Deleted")
                UserService.currentUserProfile = nil
                self.dismiss(animated: true)
            }
        }
    }
}
