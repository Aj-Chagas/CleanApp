//
//  WeakProxy.swift
//  Main
//
//  Created by Anderson Chagas on 17/05/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation

final class WeakProxy<T: AnyObject>  {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}


extension WeakProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
