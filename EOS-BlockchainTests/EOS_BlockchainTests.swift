//
//  EOS_BlockchainTests.swift
//  EOS-BlockchainTests
//
//  Created by Jay Raval on 9/18/19.
//  Copyright © 2019 Jay Raval. All rights reserved.
//

import XCTest
@testable import EOS_Blockchain

class EOS_BlockchainTests: XCTestCase {
    
    // Properties
    var systemUnderTest: RecentBlocksViewController!
    var tableView: UITableView!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Blocks") as! RecentBlocksViewController)
        tableView = UITableView()
        tableView.dataSource = systemUnderTest
    
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func recentBlocksVC_tableViewIsNotNil() {
        XCTAssertNotNil(systemUnderTest.tableView)
    }
    
    func recentBlocksVC_isTableViewDataSource() {
        XCTAssertNotNil(systemUnderTest.tableView.dataSource)
        XCTAssertTrue(systemUnderTest.tableView.dataSource is RecentBlocksViewController)
    }
    
    func recentBlocksVC_isTableViewDelegate() {
        XCTAssertNotNil(systemUnderTest.tableView.delegate)
        XCTAssertTrue(systemUnderTest.tableView.delegate is RecentBlocksViewController)
    }
    
    func recentBlocksVC_numberOfRows() {
        // Should be 20
        systemUnderTest.rowCount = 20
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 20)
    }
    
    func recentBlocksVC_numberOfSectionsInTableView() {
        // Should be 1
        XCTAssertEqual(tableView.numberOfSections, 1)
    }
    
    func recentBlocksVC_numberOfRowsInSection() {
        // Should be 0
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
    }

}
