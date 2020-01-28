//
//  DetailsTableViewCell.swift
//  Time Tracking
//
//  Created by Miguel Barone - MBA on 23/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
   
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeIntervalLabel: UILabel!
   
    func configureCell(_ checkpoint: Checkpoint) {
        contentLabel.text =  "\(checkpoint.checkin.date.shortTime) - \(checkpoint.checkout!.date.shortTime)"
        let time: [Int] = Date().hoursInterval(from: checkpoint.checkin.date, to: checkpoint.checkout!.date)
        timeIntervalLabel.text = Date().shortStringTime(hour: time[0], minute: time[1])
        
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
