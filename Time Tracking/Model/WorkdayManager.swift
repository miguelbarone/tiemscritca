//
//  WorkdayManager.swift
//  Time Tracking
//
//  Created by Marlon Morato on 16/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import Foundation

class WorkdayManager {
    private var _checkpoints: [Checkpoint] = []
    private var _currentCheckpoint: Checkpoint?
    
    var checkpoints: [Checkpoint] {
        return _checkpoints
    }
    
    var currentCheckpoint: Checkpoint? {
        return _currentCheckpoint
    }
    
    func checkin() {
        guard _currentCheckpoint == nil || _currentCheckpoint?.checkout != nil else {
            return
        }
        
        self._currentCheckpoint = Checkpoint(checkin: Checkin(date: Date(), latitude: nil, longitude: nil), checkout: nil, kind: .worktime)
    }
    
    func checkout() {
        guard let current = _currentCheckpoint, current.checkout == nil else {
            return
        }
        
        self._currentCheckpoint = current.setCheckout(checkout: Checkout(date: Date().addingTimeInterval(5464), latitude: nil, longitude: nil))
        self._checkpoints.append(self._currentCheckpoint!)
    }
    
    func registerLunchBreak() {
        guard let current = _currentCheckpoint, let lastCheckout = current.checkout else { return }
        
        self._currentCheckpoint = Checkpoint(checkin: Checkin(date: lastCheckout.date, latitude: lastCheckout.latitude, longitude: lastCheckout.longitude), checkout: Checkout(date: Date(), latitude: nil, longitude: nil), kind: .lunchBreak)
        self._checkpoints.append(self._currentCheckpoint!)
    }
    
    func registerGenericBreak() {
        guard let current = _currentCheckpoint, let lastCheckout = current.checkout else { return }
        
        self._currentCheckpoint = Checkpoint(checkin: Checkin(date: lastCheckout.date, latitude: lastCheckout.latitude, longitude: lastCheckout.longitude), checkout: Checkout(date: Date(), latitude: nil, longitude: nil), kind: .genericBreak)
        self._checkpoints.append(self._currentCheckpoint!)
    }
}
