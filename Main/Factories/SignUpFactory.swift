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
import Validation
import Domain

public final class ControllerFactory {
    public static func makeSignUp(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let presenter = SignUpPresenter(alertView: WeakProxy(controller),
                                        emailValidator: emailValidatorAdapter,
                                        addAccount: addAccount,
                                        loadingView: WeakProxy(controller))
        controller.signUp = presenter.signUp
        return controller
    }
}
