//
//  SignUpComposer.swift
//  Main
//
//  Created by Anderson Chagas on 17/05/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain
import UI

public final class SignUpComposer {
    public static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        return ControllerFactory.makeSignUp(addAccount: addAccount)
    }
}
