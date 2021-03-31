//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 31/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

class AlertViewSpy: AlertView {
    
    var emit: ((AlertViewModel) -> Void)?
    
    func observer(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }
    
    func showMessage(viewModel: AlertViewModel) {
        emit?(viewModel)
    }
}
