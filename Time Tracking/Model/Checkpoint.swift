//
//  Checkpoint.swift
//  Time Tracking
//
//  Created by Marlon Morato on 16/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import Foundation

enum CheckpointKind {
    case worktime
    case lunchBreak
    case genericBreak
}

struct Checkpoint {
    let checkin: Checkin
    let checkout: Checkout?
    let kind: CheckpointKind

    
    func setCheckout(checkout: Checkout) -> Checkpoint {
        return Checkpoint(checkin: self.checkin, checkout: checkout, kind: self.kind)
    }
}
