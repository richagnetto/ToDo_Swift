//
//  ViewController.swift
//  ToDoApp
//
//  Created by Richa Netto on 12/5/17.
//  Copyright © 2017 Richa Netto. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var toDoDetails: Results<ToDo>!
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let realm = RealmService.shared.realm
        toDoDetails = realm.objects(ToDo.self)
        
        notificationToken = realm.observe({ (notification, realm) in
            self.reloadData()
        })
        
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            print(error ?? "no error detected")
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let realm = try! Realm()
            if (searchBar.text?.characters.count)! > 0 {
                
                let predicate = NSPredicate(format: "detail CONTAINS [c] %@", searchBar.text!)
                self.toDoDetails = realm.objects(ToDo.self).filter(predicate)
                
                self.reloadData()
            } else {
                self.toDoDetails = realm.objects(ToDo.self)
                self.reloadData()
            }
        }
        return true
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
 
    
  //  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     //   searchBar.resignFirstResponder()
   // }
  
    func reloadData() {
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.invalidate()
        RealmService.shared.stopObservingErrors(in: self)
    }

    @IBAction func segmentSort(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.toDoDetails = self.toDoDetails.sorted(byKeyPath: "priority", ascending: false)
        }
        else{
            // date
            self.toDoDetails = self.toDoDetails.sorted(byKeyPath: "createdAt", ascending: true)
        }
        self.reloadData()
    }
    
    @IBAction func addToDoTapped() {
        AlertService.addAlert(in: self) { (detail, priority) in
            let newToDo = ToDo(detail: detail, priority: priority)
            RealmService.shared.create(newToDo)
        }
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoDetails.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as? ToDoCell else {
            return UITableViewCell()
        }
        let toDoDetail = toDoDetails[indexPath.row]
        cell.configureToDoCell(with: toDoDetail)
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ToDo selected")
        let toDoDetail = toDoDetails[indexPath.row]
        AlertService.updateAlert(in: self, toDo: toDoDetail) { (detail, priority) in
            let dict: [String: Any?] = ["detail": detail, "priority": priority]
            RealmService.shared.update(toDoDetail, with: dict)
        
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("Deleting")
        guard editingStyle == .delete else { return }
        let toDoDetail = toDoDetails[indexPath.row]
        
        RealmService.shared.delete(toDoDetail)
    }
}
