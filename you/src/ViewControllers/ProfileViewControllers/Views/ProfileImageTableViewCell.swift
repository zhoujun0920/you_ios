//
//  ProfileImageTableViewCell.swift
//  you
//
//  Created by Jun Zhou on 10/19/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import CoreStore
import Firebase
import FirebaseStorage
import CropViewController

class ProfileImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    var currentVC: ProfileViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImageView.setRounded()
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapProfileImage(_:))))
        if let user = Static.youStack.fetchOne(From(User.self)) {
            if let data = user.profileImage as Data? {
                self.profileImageView.image = UIImage(data: data)
            } else {
                if let currentUser = Auth.auth().currentUser {
                    let storage = Storage.storage()
                    let storageRef = storage.reference()
                    let fileRef = "profileImages/" + currentUser.uid + ".jpg"
                    let profileImageRef = storageRef.child(fileRef)
                    profileImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            // Uh-oh, an error occurred!
                        } else {
                            // Data for "images/island.jpg" is returned
                            let image = UIImage(data: data!)
                            self.profileImageView.image = image
                        }
                    }
                }
            }
        }
}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("selected profile image")
        // Configure the view for the selected state
    }
    
    @objc func tapProfileImage(_ sender: UITapGestureRecognizer) {
        let actionSheet = UIAlertController(title: "Edit your profile image", message: nil, preferredStyle: .actionSheet)
        let openCamera = UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self;
                myPickerController.sourceType = .camera
                myPickerController.allowsEditing = false
                self.currentVC.present(myPickerController, animated: true, completion: nil)
            }
        })
        let openPhotoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self;
                myPickerController.sourceType = .photoLibrary
                self.currentVC.present(myPickerController, animated: true, completion: nil)
            }
        })
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(openCamera)
        actionSheet.addAction(openPhotoLibrary)
        self.currentVC.present(actionSheet, animated: true, completion: nil)
    }
}

extension ProfileImageTableViewCell: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.profileImageView.image = image
        updateProfileImage(image: image)
        _ = try? Static.youStack.perform(
            synchronous: { (transaction) in
                guard let user = Static.youStack.fetchOne(From(User.self)) else {
                    return
                }
                if let data = image.pngData() {
                    user.profileImage = NSData(data: data)
                }
        })
        self.currentVC.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.profileImageView.image = image
        updateProfileImage(image: image)
        _ = try? Static.youStack.perform(
            synchronous: { (transaction) in
                guard let user = Static.youStack.fetchOne(From(User.self)) else {
                    return
                }
                if let data = image.pngData() {
                    user.profileImage = NSData(data: data)
                }
        })
        self.currentVC.dismiss(animated: true, completion: nil)
    }
}

extension ProfileImageTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.currentVC.dismiss(animated: true, completion: {
                self.presentCropViewController(image: image)
            })
        } else {
            self.currentVC.dismiss(animated: true, completion: nil)
            print("Something went wrong")
        }
        
    }
    
    func presentCropViewController(image: UIImage) {
        let cropViewController = CropViewController(croppingStyle: .circular, image: image)
        cropViewController.delegate = self
        cropViewController.doneButtonTitle
        self.currentVC.present(cropViewController, animated: true, completion: nil)
    }
    
    func compressProfileImage(imageData: NSData) -> Data {
        let image = UIImage(data: imageData as Data)
        if let compress = image?.jpeg(.lowest) {
            return compress
        }
        return imageData as Data
    }

    func updateProfileImage(image: UIImage) {
        if let currentUser = Auth.auth().currentUser {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let fileRef = "profileImages/" + currentUser.uid + ".jpg"
            let profileImagesRef = storageRef.child(fileRef)
            if let imageData = image.pngData() {
                let uploadTask = profileImagesRef.putData(imageData, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    // Metadata contains file metadata such as size, content-type.
                    let size = metadata.size
                    // You can also access to download URL after upload.
                    profileImagesRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            return
                        }
                        let changeRequest = currentUser.createProfileChangeRequest()
                        changeRequest.photoURL = downloadURL
                        changeRequest.commitChanges { (error) in
                            // ...
                        }
                    }
                }
            }
        }
    }
}

