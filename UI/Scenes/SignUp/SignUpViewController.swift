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

public final class SignUpViewController: UIViewController, Storyboarded {
    

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    public var signUp: ((SignUpViewModel) -> Void)?

    override public func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "4Dev"
        saveButton.layer.cornerRadius = 5
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
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

    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
        }
    }

}

extension SignUpViewController: AlertView {

    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        present(alert, animated: true)
    }

}
