//
//  ViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Richa Netto on 12/6/17.
//  Copyright © 2017 Richa Netto. All rights reserved.
//

import XCTest
import RealmSwift
@testable import ToDoApp

class ViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldTakeDetailAndPriority(){
        let newToDoObject = ToDo(detail: "Groceries", priority: 3)
        XCTAssertEqual(newToDoObject.detail, "Groceries")
        XCTAssertEqual(newToDoObject.priority, 3)
        XCTAssertNotNil(newToDoObject.createdAt)
    }
    
    //Can be tested when realm data is initially empty to check for sorting
    /*
    func testInit_EntriesShouldBeSortedByPriority(){
        let firstToDoObject = ToDo(detail: "Driving Practice", priority: 2)
        let secondToDoObject = ToDo(detail: "Dance Practice", priority: 4)
        RealmService.shared.create(firstToDoObject)
        RealmService.shared.create(secondToDoObject)
        //var ToDoObjs = [ToDo]()
        var ToDoPriorities = [Int]()
        for obj in RealmService.shared.realm.objects(ToDo.self).sorted(byKeyPath: "priority", ascending: false){
            ToDoPriorities.append(obj.priority)
        }
        print(ToDoPriorities)
        XCTAssertEqual(ToDoPriorities, [4,2])
        RealmService.shared.delete(firstToDoObject)
        RealmService.shared.delete(secondToDoObject)
    }
     */
    
}
