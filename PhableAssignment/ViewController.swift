//
//  ViewController.swift
//  PhableAssignment
//
//  Created by Usha Annadanapu on 10/06/20.
//  Copyright © 2020 Usha Annadanapu. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, getDataDelegate {
    
    @IBOutlet var contactsTable: UITableView!
    
    var contactslist: Results<ContactsModel>?
    
    let realm = try! Realm()
    var contactsViewModel = ContactsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //         Do any additional setup after loading the view.
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.topItem?.title = "Contacts"
        navigationController?.navigationBar.barTintColor =   UIColor(hexString: "#0b324e")
        self.navigationController?.navigationBar.isTranslucent = false
        self.contactsTable?.register(ContactsListTableViewCell.nib, forCellReuseIdentifier: ContactsListTableViewCell.identifier)
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddContactView))
        navigationItem.rightBarButtonItem = addBarButton
        self.loadItems()
    }
    
    func getDataFromAnotherVC() {
        self.loadItems()
    }
    
    
    @objc func showAddContactView() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = sb.instantiateViewController(withIdentifier: AddContactViewController.storyBoardIdentifier()) as? AddContactViewController {
            detailsVC.delegateCustom = self
            self.present(detailsVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactslist?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsListTableViewCell.identifier, for: indexPath)  as! ContactsListTableViewCell
        if let contacts =  contactslist?[indexPath.row] {
            cell.nameLabel.text = contacts.firstName + contacts.lastName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = sb.instantiateViewController(withIdentifier: ContactDetailsViewController.storyBoardIdentifier()) as? ContactDetailsViewController {
            detailsVC.contactsDetails = contactslist?[indexPath.row]
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let alert = UIAlertController(title: "Are you sure you want to delete the contact?", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                
                if let contacts =  self.contactslist?[indexPath.row] {
                    do {
                        try self.realm.write {
                            self.realm.delete(contacts)
                            self.loadItems()
                        }
                        
                    }catch {
                        print("error deleting item \(error)")
                    }
                }
                self.contactsTable.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func loadItems() {
        contactslist = realm.objects(ContactsModel.self)
        contactsTable.reloadData()
    }
}

