//
//  NewPostViewController.swift
//  Firebase Project
//
//  Created by Emin Emini on 17.06.2022..
//

import UIKit
import Firebase
import FirebaseDatabase

class NewPostViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Outlets
    @IBAction func addNewPost(_ sender: Any) {
        guard let postText = textView.text else {
            return
        }
        createNewPost(text: postText)
    }
    

}

// MARK: - Create New Post
extension NewPostViewController {
    func createNewPost(text: String) {
        guard let userProfile = UserService.currentUserProfile else { return }
        // Firebase code here
        
        let postRef = Database.database().reference().child("posts").childByAutoId()
        
        let postObject = [
            "author": [
                "uid": userProfile.uid,
                "username": userProfile.username,
                "photoURL": userProfile.photoURL.absoluteString
            ],
            "text": text,
        ] as [String:Any]
        
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Handle the error
                print("Error: \(error)")
            }
        })
    }
}
