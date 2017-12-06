//
//  ViewControllerUITests.swift
//  ToDoAppUITests
//
//  Created by Richa Netto on 12/6/17.
//  Copyright © 2017 Richa Netto. All rights reserved.
//

import XCTest

class ViewControllerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        XCTAssertEqual(app.tables.count, 1)
        XCTAssertEqual(app.navigationBars.buttons.count, 1)
        
        let table = app.tables.element(boundBy: 0)
        let initialCount =  table.cells.count
        //let app2 = app
        app.navigationBars["To Do List"].buttons["Add"].tap()
        let addTodoAlert = app.alerts["Add ToDo"]
        let collectionViewsQuery = addTodoAlert.collectionViews
        let enterTodoTextField = collectionViewsQuery.textFields["Enter ToDo"]
        enterTodoTextField.tap()
        enterTodoTextField.typeText("Dues")
        let enterPriorityBetween15TextField = collectionViewsQuery.textFields["Enter Priority between 1-5"]
        enterPriorityBetween15TextField.tap()
        enterPriorityBetween15TextField.typeText("4")
        addTodoAlert.buttons["Add"].tap()
        
        XCTAssertEqual(table.cells.count, initialCount + 1)
        
        
    }
    
}
