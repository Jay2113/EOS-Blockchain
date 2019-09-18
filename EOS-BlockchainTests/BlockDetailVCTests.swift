//
//  BlockDetailVCTests.swift
//  EOS-BlockchainTests
//
//  Created by Jay Raval on 9/18/19.
//  Copyright © 2019 Jay Raval. All rights reserved.
//

import XCTest
@testable import EOS_Blockchain

class BlockDetailVCTests: XCTestCase {
    
    // Properties
    var systemUnderTest: BlockDetailViewController!
    var block: EOSBlock!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Details") as! BlockDetailViewController)
        block = EOSBlock(timestamp: "example", producer: "abc", confirmed: 0, previous: "pre", transactionMRoot: "abc", actionMRoot: "abc", scheduleVersion: 2, newProducers: nil, headerExtensions: ["ext"], producerSignature: "1q2w3e4r5t6y", transactions: [EOSTransaction(status: "status", cpuUsageUS: 1, netUsageWords: 3)], object: ["acc" : "111"])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func blockDetailsVC_IBOutletsConnected() {
        XCTAssertNotNil(systemUnderTest.detailDescriptionLabel)
        XCTAssertNotNil(systemUnderTest.timestamp)
        XCTAssertNotNil(systemUnderTest.blockNumber)
        XCTAssertNotNil(systemUnderTest.producer)
        XCTAssertNotNil(systemUnderTest.transactionCount)
        XCTAssertNotNil(systemUnderTest.producerSignature)
        XCTAssertNotNil(systemUnderTest.activityIndicator)
        XCTAssertNotNil(systemUnderTest.toggleData)
        XCTAssertNotNil(systemUnderTest.rawText)
    }
    
    func blockDetailsVC_prepopulateData() {
        let blockNumber = 123123
        systemUnderTest.block = block
        systemUnderTest.blockNum = blockNumber
        systemUnderTest.configureView()
        XCTAssertEqual(systemUnderTest.blockNumber.text, "\(blockNumber)")
        XCTAssertEqual(systemUnderTest.producer.text, block.producer)
        XCTAssertEqual(systemUnderTest.producerSignature.text, block.producerSignature)
        XCTAssertEqual(systemUnderTest.timestamp.text, block.timestamp)
        XCTAssertEqual(systemUnderTest.transactionCount.text, "\(block.transactions.count)")
    }
    
    func blockDetailsVC_rawTextisEmpty() {
        XCTAssertEqual(systemUnderTest.rawText.text.isEmpty, true)
    }
    
}
