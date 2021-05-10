//
//  SignUpFactories.swift
//  Main
//
//  Created by Anderson Chagas on 10/05/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import UIKit
import UI
import Presentation
import Data
import Infra
import Validation

class SignUpFactory {
    static func makeController() -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let httpClient = AlamofireAdapter()
        let addAccount = RemoteAddAccount(url: URL(string: "https://clean-node-api.herokuapp.com/api/signup")!, httpClient: httpClient)
        
        let presenter = SignUpPresenter(alertView: controller,
                                        emailValidator: emailValidatorAdapter,
                                        addAccount: addAccount,
                                        loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}
