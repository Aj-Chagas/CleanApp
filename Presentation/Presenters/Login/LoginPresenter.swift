//
//  LoginPresenter.swift
//  Presentation
//
//  Created by Anderson Chagas on 03/08/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation

public final class LoginPresenter {
    private let validation: Validation
    
    public init(validation: Validation) {
        self.validation = validation
    }
    
    public func login(viewModel: LoginViewModel) {
        _ = validation.validate(data: viewModel.toJson())
    }
    
}
