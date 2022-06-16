//
//  RegisterViewController.swift
//  Firebase Project
//
//  Created by Emin Emini on 16.06.2022..
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    // MARK: - Actions
    @IBAction func changePhotoTouchUp(_ sender: Any) {
        showAlbum()
    }
    
    @IBAction func registerTouchUp(_ sender: Any) {
        registerFlow()
    }
    
    @IBAction func loginTouchUp(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

// MARK: - Navigate to User
extension RegisterViewController {
    func navigateInsideUser() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "feedVC")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

// MARK: - Firebase Authentication
extension RegisterViewController {
    func signUpAuth(image: UIImage, username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let user = result?.user, error == nil else {
                print("Failed to created user.\nError:\(error?.localizedDescription)")
                return
            }
            
            self.uploadProfileImage(image) { url in
                
                if url != nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = username
                    changeRequest?.photoURL = url
                    
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            print("User display name changed!")
                            
                            self.saveProfile(username: username, profileImageURL: url!) { success in
                                if success {
                                    self.navigateInsideUser()
                                }
                            }
                            
                        } else {
                            print("Error: \(error!.localizedDescription)")
                        }
                    }
                } else {
                    print("Error: Unable to upload profile image")
                    // Error unable to upload profile image
                }
                
            }
        }
    }
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                storageRef.downloadURL { url, error in
                    completion(url)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func saveProfile(username:String, profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
        ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
}

// MARK: - TextField Validation
extension RegisterViewController {
    func registerFlow() {
        guard let image = profileImage.image else {
            print("Profile Image cannot be empty")
            return
        }
        guard let username = usernameTextField.text else {
            print("Username cannot be empty")
            return
        }
        guard let email = emailTextField.text else {
            print("Email cannot be empty")
            return
        }
        guard let password = passwordTextField.text else {
            print("Password cannot be empty")
            return
        }
        
        signUpAuth(image: image, username: username, email: email, password: password)
    }
}

// MARK: - Image Picker
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showAlbum() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true

        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //print("\(info)")
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            profileImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
