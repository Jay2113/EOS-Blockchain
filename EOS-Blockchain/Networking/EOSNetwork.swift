//
//  EOSNetwork.swift
//  EOS-Blockchain
//
//  Created by Jay Raval on 9/16/19.
//  Copyright © 2019 Jay Raval. All rights reserved.
//

import Foundation
import UIKit

class EOSNetwork {
    let endPointURL = URL(string: "https://api.eosnewyork.io/v1/")
    
    let shared = EOSNetwork()
    
    init() {
        
    }
    
    func getResource<T:Codable>(rpc: String, body:[String: Any]?, callback: @escaping (T?, NetworkErrors?) -> Void) where T:JSONContainer {
        
        let url = URL(string: rpc, relativeTo: endPointURL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let body = body {
            let data = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = data
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                callback(nil, .connectionError)
                return
            }
            
            if let responseData = response as? HTTPURLResponse {
                print("Status code \(responseData.statusCode)")
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error")
                callback(nil, .serverError)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                guard var resource = try? decoder.decode(T.self, from: data) else {
                    print("Parsing Error")
                    callback(nil, .parseError)
                    return
                }
                if let json = try? JSONSerialization.jsonObject(with: data, options: []), let dictionary = json as? [String: Any] {
                    resource.object = dictionary
                }
                callback(resource, nil)
            }
        }
        task.resume()
    }
    
    func getChainInfo(_ callback: @escaping (ChainInfo?, NetworkErrors?) -> Void) {
        getResource(rpc: "chain/get_info", body: nil, callback: callback)
    }
    
    func getBlock(blockId: String, callback: @escaping (Block?, NetworkErrors?) -> Void) {
        getResource(rpc: "chain/get_block", body: ["block_num_or_id" : blockId], callback: callback)
    }
    
    func getBlock(blockNum: Int, callback: @escaping (Block?, NetworkErrors?) -> Void) {
        getResource(rpc: "chain/get_block", body: ["block_num_or_id" : blockNum], callback: callback)
    }
}

enum NetworkErrors: Error {
    case connectionError
    case serverError
    case parseError
}
