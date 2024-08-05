//
//  UserInfoFormViewController.swift
//  MyMoviesD
//
//  Created by Briam Cano on 04/08/24.
//

import UIKit

class UserInfoFormViewController: UIViewController {
    @IBOutlet weak var txtuserName: UITextField!
    @IBOutlet weak var txtFavoriteMovie: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTouchContinue(_ sender: Any) {
        if txtuserName.text?.count == 0 || txtFavoriteMovie.text?.count == 0 {
            let image = UIImageView(image: UIImage(named: "exclamationmark.triangle.fill"))
            let perfomAlert = GenericCustomAlertViewController(nibName: "GenericCustomAlertViewController", bundle: .main)
            perfomAlert.setupViewModel(CustomGenericAlertViewModel(title: "¡Verifica tus datos!", img: "exclamationmark.triangle.fill", overview: "Verifica que todos los campos de texto no esten vacio."))
            perfomAlert.modalPresentationStyle = .overFullScreen
            self.present(perfomAlert, animated: true)
        } else {
            UserDefaults.standard.setValue(true, forKey: "formFulled")
            guard let textUserName = txtuserName.text, let textFavoriteMoview = txtFavoriteMovie.text else { return }
            UserDefaults.standard.setValue(textUserName, forKey: "userName")
            let rootHomeController =  HomeMoviesViewController(nibName: "HomeMoviesViewController", bundle: .main)
            rootHomeController.setupViewModel(viewModel: HomeMovieViewModel())
            rootHomeController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootHomeController, animated: true)
        }
        
    }
}

//extension UserInfoFormViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if txtuserName.text?.count == 0 && txtFavoriteMovie.text?.count == 0 {
//            btnContinue.isEnabled = false
//            btnContinue.backgroundColor = .appColor300
//            btnContinue.setTitleColor(.gray, for: .normal)
//        } else {
//            btnContinue.isEnabled = true
//            btnContinue.backgroundColor = .appColor900
//            btnContinue.setTitleColor(.white, for: .normal)
//        }
//        return true
//    }
//}
