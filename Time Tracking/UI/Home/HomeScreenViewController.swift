//
//  HomeViewController.swift
//  Time Tracking
//
//  Created by Victor Martins Tinoco - VTN on 23/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    {
        didSet {
            dateLabel.text = Date().shortDate
        }
    }
    @IBOutlet weak var buttonCheck: CheckInButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var securityService: SecurityServiceContract!
    var workdayManager: WorkdayManager!
    var userPreferences: UserPreferencesManager!
    var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        userPreferences = UserPreferencesManager()
        securityService = SecurityService()
        workdayManager = WorkdayManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        buttonCheck.layer.cornerRadius = 10
        usernameLabel.text = userPreferences.username != "" ? userPreferences.username : securityService.currentUser?.email
    }
    @IBAction func configButtonOnTouch(_ sender: Any) {
        let viewController = UserPreferences(nibName: "UserPreferences", bundle: nil)
              viewController.modalPresentationStyle = .overFullScreen
              
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        securityService.logout()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchCheckButtonController(_ sender: CheckInButton) {

       
        switch sender.currentState {
        
        
        case .checkout:
            checkout()
            if userPreferences.locationOnCheckin {
                // codigo para salvar a localizacao
                verifyAuthentication()

            }
        case .checkin:
            checkin()
            if userPreferences.photoOnCheckin && UIImagePickerController.isSourceTypeAvailable(.camera) {
                let multimidia = UIImagePickerController()
                multimidia.sourceType = .camera
                self.present(multimidia, animated: true, completion: nil)
            }
            if userPreferences.locationOnCheckin {
                // codigo para salvar a localizacao
            verifyAuthentication()
            }
        }
        sender.toggle()
    }
    @IBAction func buttonPreference(_ sender: Any) {
        goToPreferenceScreen()
    }
    
    @IBAction func buttonDayDetails(_ sender: Any) {
        goToDayDetailsScreen()
    }
    
    private func goToPreferenceScreen() {
        let viewController = UserPreferences(nibName: "UserPreferences", bundle: nil)
        viewController.modalPresentationStyle = .overFullScreen
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    private func goToDayDetailsScreen() {
        let viewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        viewController.modalPresentationStyle = .overFullScreen
        viewController.workdayManager = workdayManager
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    func verifyAuthentication() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                manager.requestLocation()
                break
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
                break
            case .denied:
                break
            default:
                break
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("LATITUDE: \(location.coordinate.latitude)")
            print("LONGITUDE: \(location.coordinate.longitude)")
        }
    }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to find user's location: \(error.localizedDescription)")
        }

    func checkin() {
        if let current = workdayManager.currentCheckpoint, let currentCheckout = current.checkout, DateInterval(start: currentCheckout.date, end: Date().addingTimeInterval(5464)).duration >= Double(60 * 60 * 30) {
            let alert = UIAlertController(title: "Pausa muito longa.", message: "Percebemos que sua pausa durou mais que 30 minutos, gostaria de registrá-la como pausa de almoço?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in self.workdayManager.registerLunchBreak()} ))
            alert.addAction(UIAlertAction(title: "Não", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in self.workdayManager.registerGenericBreak()} ))
            self.present(alert, animated: true, completion: nil)
        }
        
        workdayManager.checkin()
    }
    
    func checkout() {
        workdayManager.checkout()
        showTotalWorkedTime()
    }
    
    func showTotalWorkedTime() {
        let workTimeCheckpoints: [Checkpoint] = workdayManager.checkpoints.filter( { $0.kind == .worktime })
        var totalHours: Int = 0
        var totalMinutes: Int = 0
        workTimeCheckpoints.forEach { (Checkpoint) in
            let timeInterval = Checkpoint.checkin.date.hoursInterval(from: Checkpoint.checkin.date, to: Checkpoint.checkout!.date)
            totalHours += timeInterval[0]
            totalMinutes += timeInterval[1]
        }
        while totalMinutes > 59 {
            totalHours += 1
            totalMinutes -= 60
        }
        
        hoursLabel.text = Date().shortStringTime(hour: totalHours, minute: totalMinutes)
    }

}
