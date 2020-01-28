//
//  DayDetailsTableViewCell.swift
//  Time Tracking
//
//  Created by Miguel Barone - MBA on 23/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit

class DayDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
     @IBOutlet weak var timeCheckpointIntervalLabel: UILabel!
     @IBOutlet weak var timeOfCheckpointLabel: UILabel!
    
     func configure(_ checkpoint: Checkpoint) {
         timeCheckpointIntervalLabel.text =  "\(checkpoint.checkin.date.shortTime) - \(checkpoint.checkout!.date.shortTime)"
         let time: [Int] = Date().hoursInterval(from: checkpoint.checkin.date, to: checkpoint.checkout!.date)
         timeOfCheckpointLabel.text = Date().shortStringTime(hour: time[0], minute: time[1])
         
         switch checkpoint.kind {
         case .worktime:
             iconImageView.image = IconHelper.icon(for: .bagFill)
             break
         case .genericBreak:
             iconImageView.image = IconHelper.icon(for: .timer)
             iconImageView.tintColor = UIColor.systemRed
             break
         case .lunchBreak:
             iconImageView.image = IconHelper.icon(for: .tuningfork)
             iconImageView.tintColor = UIColor.systemRed
         }
     }
}
    extension DayDetailsTableViewCell {
        static let IDENTIFIER = "contentCell"
        static let NIB = UINib(nibName: "DayDetailsTableViewCell", bundle: nil)
        
        static func register(in tableView: UITableView) {
            tableView.register(NIB, forCellReuseIdentifier: IDENTIFIER)
        }
        
        static func dequeue(from tableView: UITableView) -> DayDetailsTableViewCell? {
            return tableView.dequeueReusableCell(withIdentifier: IDENTIFIER) as? DayDetailsTableViewCell
        }
    }
