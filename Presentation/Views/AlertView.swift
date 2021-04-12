//
//  Views.swift
//  Presentation
//
//  Created by Anderson Chagas on 18/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation

public protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

public struct AlertViewModel: Equatable {
    public let title: String
    public let message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
