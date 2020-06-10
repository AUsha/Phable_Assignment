//
//  ContactsViewModel.swift
//  PhableAssignment
//
//  Created by Usha Annadanapu on 11/06/20.
//  Copyright © 2020 Usha Annadanapu. All rights reserved.
//

import Foundation
import RealmSwift

class ContactsViewModel {
    
    let realm = try! Realm()
    
    let contacts = ContactsModel()
    
    var serverError:Error?
    
        var isLoadContactsSucceeded: Dynamic<Bool> = Dynamic(false)
    
    func loadContactsData(firstName: String, lastName: String, phoneNumber: String, email: String) {
        contacts.firstName = firstName
        
        contacts.lastName = lastName
        
        contacts.phoneNumber = phoneNumber
        
        contacts.email = email
        
        do {
            try realm.write {
                realm.add(contacts)
                self.isLoadContactsSucceeded.value = true

            }
        }catch {
            print("Error in saving contacts data \(error)")
            self.isLoadContactsSucceeded.value = false

        }
    }
    
}
