//
//  RecentBlockViewController.swift
//  EOS-Blockchain
//
//  Created by Jay Raval on 9/16/19.
//  Copyright © 2019 Jay Raval. All rights reserved.
//

import UIKit

class RecentBlocksViewController: UITableViewController {
    
    // Properties
    var detailViewController: BlockDetailViewController? = nil
    var headBlockNumber: Int!
    var rowCount = 0
    
    // Refresh Button
    lazy var refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshBlocks(_:)))
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        if let split = splitViewController {
            split.preferredDisplayMode = .allVisible
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? BlockDetailViewController
        }
        
        refreshBlocks(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - Refresh and fetch the 20 most recent blocks of the EOS Blockchain

    @objc
    func refreshBlocks(_ sender: Any) {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        
        EOSNetwork.shared.getChainInfo {[weak self] (info, error) in
            guard let self = self else {
                return
            }
            
            if let info = info {
                self.headBlockNumber = info.headBlockNum
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
            
            if let error = error {
                self.displayError(error: error)
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                self.navigationItem.rightBarButtonItem = self.refresh
            })
        }
    }
    
    // MARK: - Update the User Interface
    
    func updateUI() {
        if self.rowCount == 0 {
            self.rowCount = 20
            self.tableView.reloadData()
        } else {
            self.tableView.beginUpdates()
            self.tableView.reloadRows(at: self.tableView.indexPathsForVisibleRows ?? [IndexPath](), with: .bottom)
            self.tableView.endUpdates()
        }
    }
    
    // MARK: - Handle errors
    
    func displayError(error: NetworkErrors) {
        var description = ""
        switch error{
        case .connectionError:
            description = "Unable to reach the network. Please check that your device is connected to the internet and try again."
        case .serverError:
            description = "Oops! Something went wrong. Please try again later."
        case .parseError:
            description = "Cannot parse server response."
        }
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(actionOK)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let blockNumber = headBlockNumber - indexPath.row
                let controller = (segue.destination as! UINavigationController).topViewController as! BlockDetailViewController
                controller.blockNum = blockNumber
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = String(headBlockNumber - indexPath.row)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Block Number"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

