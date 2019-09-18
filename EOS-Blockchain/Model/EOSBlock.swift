//
//  EOSBlock.swift
//  EOS-Blockchain
//
//  Created by Jay Raval on 9/16/19.
//  Copyright © 2019 Jay Raval. All rights reserved.
//

import Foundation

struct EOSBlock: JSONContainer, Codable {
    let timestamp: String
    let producer: String
    let confirmed: Int
    let previous: String
    let transactionMRoot: String
    let actionMRoot: String
    let scheduleVersion: Int
    let newProducers: String?
    let headerExtensions: [String]
    let producerSignature: String
    let transactions: [EOSTransaction]
    var object = [String: Any]()
    
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case producer = "producer"
        case confirmed = "confirmed"
        case previous = "previous"
        case transactionMRoot = "transaction_mroot"
        case actionMRoot = "action_mroot"
        case scheduleVersion = "schedule_version"
        case newProducers = "new_producers"
        case headerExtensions = "header_extensions"
        case producerSignature = "producer_signature"
        case transactions = "transactions"
    }
}
