//
//  TableTasksViewTests.swift
//  TaskManager2Tests
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import XCTest
@testable import TaskManager2


class TableTasksViewTests: XCTestCase {
    
    
    var sut: TableItemsView!
    var tableView: UITableView!
    

    override func setUpWithError() throws {
        sut = TableTasksView()
        tableView = sut.view.subviews.first as? UITableView
    }

    override func tearDownWithError() throws {
        sut = TableTasksView()
    }
    
    
    func test_BackGroundColorIsWhiteAfterViewDidLoad() {
        XCTAssertEqual(sut.view.backgroundColor, UIColor.white)
    }
    
    func test_TableViewDelegateIsSut() {
        XCTAssert(tableView.delegate === sut)
    }
    
    func test_TableViewDataSourceIsSut() {
        XCTAssert(tableView.dataSource === sut)
    }
    
}



