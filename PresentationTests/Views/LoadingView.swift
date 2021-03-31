//
//  LoadingView.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 31/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    
    var emit: ((LoadingViewModel) -> Void)?
    
    func observer(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }
    
    func display(viewModel: LoadingViewModel) {
        emit?(viewModel)
    }
    
}
