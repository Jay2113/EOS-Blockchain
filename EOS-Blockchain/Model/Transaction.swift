//
//  Transaction.swift
//  EOS-Blockchain
//
//  Created by Jay Raval on 9/16/19.
//  Copyright © 2019 Jay Raval. All rights reserved.
//

import Foundation

struct Transaction {
    let status: String
    let cpuUsageUS: Int
    let netUsageWords: Int
    let trx: Data? = nil
    
    enum CodingKeys: String, CodingKey {
        case status
        case cpuUsageUS = "cpu_usage_us"
        case netUsageWords = "net_usage_words"
    }
}
