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
    
    func getResource(rpc: String, body:[String: Any]?) {
        
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
                return
            }
            if let response = response {
                print(response)
            }
            if let data = data {
                let decoder = JSONDecoder()
                guard var resource = try? decoder.decode(T.self, from: data) else {
                    print("Error")
                    return
                }
                if let json = try? JSONSerialization.jsonObject(with: data, options: []), let dictionary = json as? [String: Any]  {
                    resource.jSONObject = dict
                }
            }
        }
        task.resume()
    }
}
