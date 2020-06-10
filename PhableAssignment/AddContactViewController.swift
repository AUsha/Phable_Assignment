//
//  AddContactViewController.swift
//  PhableAssignment
//
//  Created by Usha Annadanapu on 10/06/20.
//  Copyright © 2020 Usha Annadanapu. All rights reserved.
//

import UIKit

protocol  getDataDelegate {
    func getDataFromAnotherVC()
}

class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var addProfileImage: UIButton!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
        
    var contactsViewModel = ContactsViewModel()
        
    var contactsModelUpdated : ((_ contactData: [ContactsModel]?) -> Void)?
    
    var delegateCustom : getDataDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleToFill
    }
    
    class func storyBoardIdentifier() -> String {
        return String(describing: self)
    }
    
    @IBAction func doneActionButton(_ sender: Any) {
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let phoneNumber = phoneNumberTextField.text, let email = emailTextField.text {
            
            contactsViewModel.loadContactsData(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)
        }
        self.delegateCustom?.getDataFromAnotherVC()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelActionButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addProfileImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.contentMode = .scaleAspectFit
            profileImage.image = pickedImage
            profileImage.contentMode = .scaleToFill
            addProfileImage.isHidden = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //    func loadImageFromPath(_ path: NSString) -> UIImage? {
    //
    //        let image = UIImage(contentsOfFile: path as String)
    //
    //        if image == nil {
    //            return UIImage()
    //        } else{
    //            return image
    //        }
    //    }
}
