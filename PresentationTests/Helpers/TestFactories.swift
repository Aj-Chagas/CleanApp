//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 31/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

func makeErrorAlertViewModel(message: String) -> AlertViewModel {
    AlertViewModel(title: "Erro", message: message)
}

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
    AlertViewModel(title: "Sucesso", message: message)
}

func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
    AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é obrigatório")
}

func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
    AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é inválido")
}

func makeSignupViewModel(name: String? = "any_name",
                         email: String? = "any_email@email.com",
                         password: String? = "any_password",
                         passwordConfirmation: String? = "any_password") -> SignUpViewModel {
    SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}
