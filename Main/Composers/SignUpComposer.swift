//
//  SignUpComposer.swift
//  Main
//
//  Created by Anderson Chagas on 17/05/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import UIKit
import UI
import Presentation
import Validation
import Domain

public final class SignUpComposer {
    public static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
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
