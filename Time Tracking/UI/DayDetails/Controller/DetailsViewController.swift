//
//  DetailsViewController.swift
//  Time Tracking
//
//  Created by Miguel Barone - MBA on 23/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//


import UIKit


struct Content2 {
    let name: String
    let completed: Bool
}

class DetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var workdayManager: WorkdayManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        
        DayDetailsTableViewCell.register(in: tableView)
    }
    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workdayManager.checkpoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DayDetailsTableViewCell.dequeue(from: tableView)!
       
        let checkpoint = workdayManager.checkpoints[indexPath.row]
        
        cell.configure(checkpoint)
        
        return cell
    }
}


extension DetailsViewController: UITableViewDelegate {
    
}
