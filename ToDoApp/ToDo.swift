//
//  ToDo.swift
//  ToDoApp
//
//  Created by Richa Netto on 12/5/17.
//  Copyright © 2017 Richa Netto. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class ToDo: Object {
    
    dynamic var detail: String = ""
    dynamic var priority: Int = 0
    dynamic var createdAt = NSDate()
    
    convenience init(detail: String, priority: Int) {
        self.init()
        self.detail = detail
        self.priority = priority
        self.createdAt = NSDate()
    }
    
 
}
