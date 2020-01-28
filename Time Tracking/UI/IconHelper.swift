//
//  IconHelper.swift
//  Time Tracking
//
//  Created by Marlon Morato on 23/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit

enum IconType {
    case playFill
    case pauseFill
    case location
    case bagFill
    case timer
    case tuningfork
}

class IconHelper {
    static func icon(for type: IconType) -> UIImage? {
        if #available(iOS 13.0, *) {
            switch type {
            case .playFill: return UIImage(systemName: "play.fill")
            case .pauseFill: return UIImage(systemName: "pause.fill")
            case .location: return UIImage(systemName: "location")
            case .bagFill: return UIImage(systemName: "bag.fill")
            case .timer: return UIImage(systemName: "timer")
            case .tuningfork: return UIImage(systemName: "tuningfork")
            }
        } else {
            switch type {
            case .playFill: return nil
            case .pauseFill: return nil
            default: return nil
            }
        }
    }
}
