//
//  CheckInButton.swift
//  Time Tracking
//
//  Created by Victor Martins Tinoco - VTN on 15/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit

enum CheckinButtonState {
    case checkin
    case checkout
}

class CheckInButton: UIButton {
    private var buttonState = CheckinButtonState.checkin
    private let checkinImage = IconHelper.icon(for: .playFill)
    private let checkoutImage = IconHelper.icon(for: .pauseFill)
    
    var currentState: CheckinButtonState {
        return buttonState
    }
    
    
    
    override func didMoveToSuperview() {
        self.setCheckinState()
    }
    
    func toggle() {
        if buttonState == .checkin {
            setCheckoutState()
        } else {
            setCheckinState()
        }
        print(buttonState)
    }
    
    func set(state: CheckinButtonState) {
        switch state {
        case .checkin:
            setCheckinState()
        case .checkout:
            setCheckoutState()
        }
    }
    
    private func setCheckinState() {
        buttonState = .checkin
        self.setTitle("Check-in", for: .normal)
        self.setImage(checkinImage, for: .normal)
    }
    
    private func setCheckoutState() {
        buttonState = .checkout
        self.setTitle("Check-out", for: .normal)
        self.setImage(checkoutImage, for: .normal)
    }

}
