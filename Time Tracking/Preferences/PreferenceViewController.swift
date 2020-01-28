//
//  PreferenceViewController.swift
//  Time Tracking
//
//  Created by Gabriel dos Santos Nascimento - GNS on 20/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit
import CoreData

struct Content1 {
    let name: String
    let completed: Bool
}

class PreferenceViewController: UIViewController, ImagePickerSelectPhoto {
    
    // MARK: - IBOutlets
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var photoOnCheckinSwitchView: UISwitch!
    @IBOutlet weak var locationOnCheckinSwitchView: UISwitch!
    @IBOutlet weak var nameInputView: UITextField!
    @IBOutlet weak var emailInputView: UITextField!
    
    // MARK: - LifeCycles of View Controller
    
    let contents = [
              Content2(name: "Iteris Faria Lima ", completed: false),
              Content2(name: "Iteris Fernandes Coelho", completed: true),
              Content2(name: "Iteris Alphaville", completed: false),
     
          ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        userPreferences = UserPreferencesManager()
        securityService = SecurityService()
        
        photoOnCheckinSwitchView.isOn = userPreferences.photoOnCheckin
        locationOnCheckinSwitchView.isOn = userPreferences.locationOnCheckin
        nameInputView.text = userPreferences.username
        emailInputView.isUserInteractionEnabled = false
        emailInputView.text = securityService.currentUser?.email
        
        imageProfile.layer.cornerRadius = 70
           
            
            print("PreferenceViewController viewDidLoad")
            
            tableView.dataSource = self
            tableView.delegate = self
            
            tableView.rowHeight = 50
        
        
        if let image = userPreferences.profileImage {
            imageProfile.image = image
        } else {
            imageProfile.image = UIImage(named: "default_profile_picture")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        userPreferences.setPhotoOnCheckin(with: photoOnCheckinSwitchView.isOn)
        userPreferences.setLocationOnCheckin(with: locationOnCheckinSwitchView.isOn)
        userPreferences.setUsername(with: nameInputView.text ?? "")
    }
    
    // MARK: - Variables
    
    var userPreferences: UserPreferencesManager!
    var securityService: SecurityService!
        
    
    
    let imagePicker = ImagePicker()
    
    // MARK: - Methods
    
    var context:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func showMultimidia(_ opcao:MenuOptions){
        let multimidia = UIImagePickerController()
        multimidia.delegate = imagePicker
        
        if opcao == .camera &&  UIImagePickerController.isSourceTypeAvailable(.camera){
            multimidia.sourceType = .camera
        }
        else{
             multimidia.sourceType = .photoLibrary
        }
            
        self.present(multimidia, animated: true, completion: nil)
    }
    
    func setup(){
        imagePicker.delegate = self
    }
    
    func imagePickerSelectPhoto(_ img: UIImage) {
        imageProfile.image = img
        _ = userPreferences.setProfileImage(image: img)
        
    }

    // MARK: - IBActions

    @IBAction func profileButtonImage(_ sender: UIButton) {
        
        let menu = ImagePicker().optionsMenu { (opcao) in
            if opcao != .limparImagem{
                self.showMultimidia(opcao)
            } else {
                // MARK: - ALERT
                // Make a code to clear profile image here
            }
        }
        present(menu, animated: true, completion: nil)
    }
}

    
    extension PreferenceViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.contents.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell") as! ContentTableViewCell
            
            let content = contents[indexPath.row]
            
            cell.configure(content: content.name, checked: content.completed)
            
            return cell
        }
    }
    

    extension PreferenceViewController: UITableViewDelegate {
        
    }



//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.savePreferences()
//    }

