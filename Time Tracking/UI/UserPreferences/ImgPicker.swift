//
//  ImgPicker.swift
//  Time Tracking
//
//  Created by Gabriel dos Santos Nascimento - GNS on 24/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit

enum AlertOptions {
    case camera
    case biblioteca
    case limparImagem
}

protocol ImagePickerSelectedPhoto {
    func imagePickerSelectedPhoto(_ foto:UIImage)
}


class ImgPicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate:ImagePickerSelectedPhoto?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        delegate?.imagePickerSelectedPhoto(photo)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func optionsMenu(completion:@escaping(_ option:AlertOptions) -> Void) -> UIAlertController{
        
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
