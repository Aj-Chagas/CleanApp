//
//  SignUpFactories.swift
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
import Validation
import Infra

public func makeSignUpController(addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController.instantiate()
    let validationComposite = ValidationComposite(validators: makeSignUpValidations())
    let presenter = SignUpPresenter(alertView: WeakProxy(controller),
                                    addAccount: addAccount,
                                    loadingView: WeakProxy(controller),
                                    validation: validationComposite)
    controller.signUp = presenter.signUp
    return controller
}

public func makeSignUpValidations() -> [Validation] {
    [RequiredFieldsValidation(fieldName: "name", fieldLabel: "Name"),
     RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email"),
     EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter()),
     RequiredFieldsValidation(fieldName: "password", fieldLabel: "Senha"),
     RequiredFieldsValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
     CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")]
}

