//
//  SignUpViewController.swift
//  UI
//
//  Created by Anderson Chagas on 05/04/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation
import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    var signUp: ((SignUpViewModel) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func saveButtonTapped() {
        signUp?(SignUpViewModel(name: nameTextField.text,
                                email: emailTextField.text,
                                password: passwordTextField.text,
                                passwordConfirmation: passwordConfirmationTextField.text))
    }
}

extension SignUpViewController: LoadingView {

    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }

}

extension SignUpViewController: AlertView {

    func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        present(alert, animated: true)
    }

}
