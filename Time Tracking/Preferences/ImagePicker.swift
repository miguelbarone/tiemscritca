//
//  ImagePicker.swift
//  Time Tracking
//
//  Created by Gabriel dos Santos Nascimento - GNS on 20/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit

enum MenuOptions {
    case camera
    case biblioteca
    case limparImagem
}

protocol ImagePickerSelectPhoto {
    func imagePickerSelectPhoto(_ foto:UIImage)
}


class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate:ImagePickerSelectPhoto?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        delegate?.imagePickerSelectPhoto(photo)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func optionsMenu(completion:@escaping(_ option:MenuOptions) -> Void) -> UIAlertController{
        
        let menu = UIAlertController(title: "Atenção", message: "Escolha uma das opções abaixo.", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Tirar Foto", style: .default) { (acao) in
            completion(.camera)
        }
        menu.addAction(camera)
        
        let biblioteca = UIAlertAction(title: "Biblioteca", style: .default) { (acao) in
            completion(.biblioteca)
        }
        menu.addAction(biblioteca)
        
        let limparImagem = UIAlertAction(title: "Limpar imagem", style: .destructive) { (acao) in
            completion(.limparImagem)
        }
        menu.addAction(limparImagem)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        
        return menu
        
    }
}
