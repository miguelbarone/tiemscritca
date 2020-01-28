//
//  ContentUserCellTableViewCell.swift
//  Time Tracking
//
//  Created by Gabriel dos Santos Nascimento - GNS on 23/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit

class ContentUserCell: UITableViewCell {
    @IBOutlet weak var contentCell: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    
    func configure(content: String, checked: Bool) {
        contentCell.text = content
        
        iconImageView.image = IconHelper.icon(for: .location)
        iconImageView.tintColor = checked ? .systemGreen : .systemGray
    }
}

extension ContentUserCell {
    static let IDENTIFIER = "ContentUserCell"
    static let NIB = UINib(nibName: "ContentUserCellTableViewCell", bundle: nil)
    
    static func register(in tableView: UITableView) {
        tableView.register(NIB, forCellReuseIdentifier: IDENTIFIER)
    }
    
    static func dequeue(from tableView: UITableView) -> ContentUserCell? {
        return tableView.dequeueReusableCell(withIdentifier: IDENTIFIER) as? ContentUserCell
    }
}
