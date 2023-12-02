//
//  SignUpViewController.swift
//  Pramisu
//
//  Created by Kyowon on 2023/09/21.
//

import UIKit


class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var userId: String?
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("UserId: \(String(describing: userId))")
        
        let tapImageViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileUpload(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapImageViewRecognizer)
    }
    
    @objc func profileUpload(tapGestureRecognizer: UITapGestureRecognizer){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false){ () in
            let alert = UIAlertController(title: "", message: "이미지 선택을 취소하였습니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false){ () in
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.profileImage.image = image
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        
    }
}
