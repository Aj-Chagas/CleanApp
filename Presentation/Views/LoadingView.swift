//
//  LoadingView.swift
//  Presentation
//
//  Created by Anderson Chagas on 30/03/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
    
    public let isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
