//
//  ChainInfo.swift
//  EOS-Blockchain
//
//  Created by Jay Raval on 9/16/19.
//  Copyright © 2019 Jay Raval. All rights reserved.
//

import Foundation

struct ChainInfo {
    let serverVersion: String
    let chainId: String
    let headBlockNum: Int
    let lastIrreversibleBlockNum: Int
    let lastIrreversibleBlockId: String
    let headBlockId: String
    let headBlockTime: String
    let headBlockProducer: String
    let virtualBlockCPULimit: Int
    let virtualBlockNETLimit: Int
    let blockCPULimit: Int
    let blockNETLimit: Int
    let serverVersionString: String
    
    enum CodingKeys: String, CodingKey {
        case serverVersion = "server_version"
        case chainId = "chain_id"
        case headBlockNum = "head_block_num"
        case lastIrreversibleBlockNum = "last_irreversible_block_num"
        case lastIrreversibleBlockId = "last_irreversible_block_id"
        case headBlockId = "head_block_id"
        case headBlockTime = "head_block_time"
        case headBlockProducer = "head_block_producer"
        case virtualBlockCPULimit = "virtual_block_cpu_limit"
        case virtualBlockNETLimit = "virtual_block_net_limit"
        case blockCPULimit = "block_cpu_limit"
        case blockNETLimit = "block_net_limit"
        case serverVersionString = "server_version_string"
    }
}
