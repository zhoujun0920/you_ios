//
//  ProfileImageTableViewCell.swift
//  you
//
//  Created by Jun Zhou on 10/19/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import CoreStore

class ProfileImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    var currentVC: ProfileViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImageView.layer.borderWidth = 1
        self.profileImageView.layer.masksToBounds = false
        self.profileImageView.layer.borderColor = UIColor.clear.cgColor
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        self.profileImageView.clipsToBounds = true
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapProfileImage(_:))))
        _ = try? Static.youStack.perform(
            synchronous: { (transaction) in
                guard let user = Static.youStack.fetchOne(From(User.self)) else {
                    return
                }
                if let data = user.profileImage as Data? {
                    self.profileImageView.image = UIImage(data: data)
                }
        })
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
                myPickerController.allowsEditing = true
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

extension ProfileImageTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if #available(iOS 11, *)
//        { // iOS 11 support
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                self.profileImageView.image = image
                _ = try? Static.youStack.perform(
                    synchronous: { (transaction) in
                        guard let user = Static.youStack.fetchOne(From(User.self)) else {
                            return
                        }
                        guard let data = image.pngData() as NSData? else {
                            return
                        }
                        user.profileImage = data;
                })
            } else {
                print("Something went wrong")
            }
//        } else {
//            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//                self.profileImageView.image = image
//            } else {
//                print("Something went wrong")
//            }
//        }
        self.currentVC.dismiss(animated: true, completion: nil)
    }
    
    func compressProfileImage(imageData: NSData) -> Data {
        let image = UIImage(data: imageData as Data)
        if let compress = image?.jpeg(.lowest) {
            return compress
        }
        return imageData as Data
    }
}

