//
//  ViewController.swift
//  UIColorPicker
//
//  Created by Naoya Muto on 2017/01/31.
//  Copyright © 2017年 Naoya Muto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imagePickerController = UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func tappedSelectButton(_ sender: UIButton) {
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary

        present(imagePickerController, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
