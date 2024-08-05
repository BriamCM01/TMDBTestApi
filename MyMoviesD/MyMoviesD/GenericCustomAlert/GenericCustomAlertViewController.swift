//
//  GenericCustomAlertViewController.swift
//  MyMoviesD
//
//  Created by Briam Cano on 04/08/24.
//

import UIKit

class GenericCustomAlertViewController: UIViewController {

    @IBOutlet weak var imgAlert: UIImageView!
    @IBOutlet weak var lblTitleAlert: UILabel!
    @IBOutlet weak var txtOverviewAlert: UITextView!
    @IBOutlet weak var btnAceptar: UIButton!
    
    var viewModel: CustomGenericAlertViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        imgAlert.image = UIImage(systemName: viewModel.img)
        lblTitleAlert.text = viewModel.title
        txtOverviewAlert.text = viewModel.overview
    }
    
    func setupViewModel(_ viewModel: CustomGenericAlertViewModel) {
        self.viewModel = viewModel
    }

    @IBAction func didTouchAccept(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
