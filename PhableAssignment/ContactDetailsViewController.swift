//
//  ContactDetailsViewController.swift
//  PhableAssignment
//
//  Created by Usha Annadanapu on 10/06/20.
//  Copyright © 2020 Usha Annadanapu. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var profilename: UILabel!
    @IBOutlet var emailText: UILabel!
    @IBOutlet var mobileText: UILabel!
    @IBOutlet var emailButton: UIButton!
    @IBOutlet var callButton: UIButton!
    
    
    var contactsDetails: ContactsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstName = contactsDetails?.firstName , let lastName = contactsDetails?.lastName {
            profilename.text = firstName + lastName
        }
        if let phoneNumber = contactsDetails?.phoneNumber {
            mobileText.text = phoneNumber
        }
        if let email = contactsDetails?.email {
            emailText.text = email
        }
        if let profileImage = contactsDetails?.profilePic {
            
            profilePic.image = UIImage(named: profileImage)
            profilePic.layer.masksToBounds = false
            profilePic.layer.cornerRadius = profilePic.frame.height/2
            profilePic.clipsToBounds = true
            profilePic.contentMode = .scaleToFill
        }
    }
    
    class func storyBoardIdentifier() -> String {
        return String(describing: self)
    }
    
    @IBAction func emailAction(_ sender: Any) {
        if let email = self.emailText.text {
            self.openEmail(email)
        }
    }
    @IBAction func callAction(_ sender: Any) {
        if let phone = self.mobileText.text {
            self.openDialer(phone)
            
        }
    }
    
    func openEmail(_ email: String) {
        if let coded = "mailto:\(email)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            if let emailURL = URL(string: coded) {
                if UIApplication.shared.canOpenURL(emailURL) {
                    UIApplication.shared.open(emailURL, options: [:],
                                              completionHandler: {
                                                (success) in
                                                print("Open \(emailURL): \(success)")
                    })
                    
                }
            }
        }
    }
    
    func openDialer(_ phone: String) {
        let phoneNumber = phone.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url, options: [:],
                                      completionHandler: {
                                        (success) in
                                        print("Open \(url): \(success)")
            })
        }
    }
    
}
