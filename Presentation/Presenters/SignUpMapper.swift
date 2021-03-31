//
//  SignUpMapper.swift
//  Presentation
//
//  Created by Anderson Chagas on 31/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain

final class SignUpMapper {
    static func toAddAccountModel(_ viewModel: SignUpViewModel) -> AddAccountModel {
        AddAccountModel(name: viewModel.name!,
                        email: viewModel.email!,
                        password: viewModel.password!,
                        passwordConfirmation: viewModel.passwordConfirmation!)
    }
}
