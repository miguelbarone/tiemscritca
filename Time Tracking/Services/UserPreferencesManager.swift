//
//  UserPreferencesManager.swift
//  Time Tracking
//
//  Created by Victor Martins Tinoco - VTN on 20/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import Foundation
import UIKit

class UserPreferencesManager {
    private let defaults = UserDefaults.standard
    
    private let USERNAME_KEY = "username"
    private let PHOTO_ON_CHECKIN_KEY = "photo_on_checkin"
    private let LOCATION_ON_CHECKIN_KEY = "location_on_checkin"
    
    var username: String {
        return defaults.string(forKey: USERNAME_KEY) ?? ""
    }
    
    func setUsername(with name: String) {
        defaults.set(name, forKey: USERNAME_KEY)
    }
    
    var photoOnCheckin: Bool {
        return defaults.bool(forKey: PHOTO_ON_CHECKIN_KEY)
    }
    
    func setPhotoOnCheckin(with boolean: Bool) {
        defaults.set(boolean, forKey: PHOTO_ON_CHECKIN_KEY)
    }

    var locationOnCheckin: Bool {
        return defaults.bool(forKey: LOCATION_ON_CHECKIN_KEY)
    }
    
    func setLocationOnCheckin(with boolean: Bool) {
        defaults.set(boolean, forKey: LOCATION_ON_CHECKIN_KEY)
    }
    
    var profileImage: UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("profilePicture").path)
        }
        return nil
    }
    
    func setProfileImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("profilePicture.png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
