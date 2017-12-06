//
//  AlertService.swift
//  ToDoApp
//
//  Created by Richa Netto on 12/5/17.
//  Copyright © 2017 Richa Netto. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    
    private init() {
        
    }
    
    static func addAlert(in vc: UIViewController, completion: @escaping (String, Int) -> Void) {
        let alert = UIAlertController(title: "Add ToDo", message: nil, preferredStyle: .alert)
        alert.addTextField { (todoTF) in
            todoTF.placeholder = "Enter ToDo"
        }
        alert.addTextField { (priorityTF) in
            priorityTF.placeholder = "Enter Priority between 1-5"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let detail = alert.textFields?.first?.text,
                let priority = Int((alert.textFields?.last?.text)!)
                else { return }
            if (priority < 1 || priority > 5) {
                return
            }
            completion(detail, priority)
            
    }
        alert.addAction(action)
        vc.present(alert, animated: true)
}

    static func updateAlert(in vc: UIViewController,
                            toDo: ToDo,
                            completion: @escaping (String, Int) -> Void) {
        
        let alert = UIAlertController(title: "Update ToDo", message: nil, preferredStyle: .alert)
        alert.addTextField { (todoTF) in
            todoTF.placeholder = "Enter ToDo"
            todoTF.text = toDo.detail
        }
        alert.addTextField { (priorityTF) in
            priorityTF.placeholder = "Enter Priority between 1-5"
            priorityTF.text = String(toDo.priority)
        }
        
        let action = UIAlertAction(title: "Update", style: .default) { (_) in
            guard let detail = alert.textFields?.first?.text,
                let priority = Int((alert.textFields?.last?.text)!)
                else { return }
            
            completion(detail, priority)
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
}
