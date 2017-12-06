//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by Richa Netto on 12/5/17.
//  Copyright © 2017 Richa Netto. All rights reserved.
//

import Foundation
import UIKit

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!

    func configureToDoCell(with toDo: ToDo) {
        detailLabel.text = toDo.detail
        priorityLabel.text = String(toDo.priority)
    }
}
