//
//  BlockDetailViewController.swift
//  EOS-Blockchain
//
//  Created by Jay Raval on 9/16/19.
//  Copyright © 2019 Jay Raval. All rights reserved.
//

import UIKit

class BlockDetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var blockNumber: UILabel!
    @IBOutlet weak var producer: UILabel!
    @IBOutlet weak var transactionCount: UILabel!
    @IBOutlet weak var producerSignature: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var toggleData: UISwitch!
    @IBOutlet weak var rawText: UITextView!
    
    // Properties
    var block: EOSBlock?
    
    // MARK: - View Lifecycle
    
    func configureView() {
        // Update the user interface for the detail item.
        if blockNum != nil {
            detailDescriptionLabel.text = nil
            if block == nil {
                activityIndicator.startAnimating()
            }
        }
        if let block = block {
            blockNumber?.text = "\(blockNum!)"
            producer?.text = "\(block.producer)"
            producerSignature?.text = "\(block.producerSignature)"
            transactionCount?.text = "\(block.transactions.count)"
            timestamp?.text = "\(block.timestamp)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    // MARK: - Fetch details of the selected block
    
    var blockNum: Int? {
        didSet {
            fetchBlockDetail()
        }
    }
    
    func fetchBlockDetail() {
        guard let blockNum = blockNum else {
            return
        }
        activityIndicator?.startAnimating()
        EOSNetwork.shared.getBlock(blockNum: blockNum) {[weak self] (block, error) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
            
            if let error = error {
                var errorDescription = ""
                switch error {
                case .connectionError:
                    errorDescription = "Unable to reach the network. Please check that your device is connected to the internet and try again."
                case .serverError:
                    errorDescription = "Oops! Something went wrong. Please try again."
                case .parseError:
                    errorDescription = "Can not parse server response. Please try again."
                }
                DispatchQueue.main.async {
                    self?.displayError(description: errorDescription)
                }
            }
            
            if let block = block {
                self?.block = block
                DispatchQueue.main.async {
                    self?.configureView()
                }
            }
        }
    }
    
    // MARK: - Handle errors
    
    func displayError(description: String) {
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        let actionRetry = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            self.fetchBlockDetail()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.dismiss(animated: false, completion: nil)
            self.navigationController?.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(actionRetry)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Toggle RAW JSON
    
    @IBAction func toggleJSON(_ sender: Any) {
        if rawText.isHidden {
            rawText.isHidden = false
            if let block = block, let data = try? JSONSerialization.data(withJSONObject: block.object, options: .prettyPrinted), let rawData = String(data: data, encoding: .ascii) {
                rawText.text = rawData
            }
        } else {
            rawText.isHidden = true
        }
    }
}

