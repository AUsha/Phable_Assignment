//
//  ContactsModel.swift
//  PhableAssignment
//
//  Created by Usha Annadanapu on 11/06/20.
//  Copyright © 2020 Usha Annadanapu. All rights reserved.
//

import Foundation
import RealmSwift

class ContactsModel : Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var companyName: String = ""
    @objc dynamic var profilePic: String = ""

}
