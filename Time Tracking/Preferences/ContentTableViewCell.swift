//
//  ContentTableViewCell.swift
//  Time Tracking
//
//  Created by Nina Dominique Thomé Bernardo - NBE on 21/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var contentCell: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
        func configure(content: String, checked: Bool) {
            contentCell.text = content
            
            iconImageView.image = IconHelper.icon(for: .location)
            iconImageView.tintColor = checked ? .systemGreen : .systemGray
        }
    }
