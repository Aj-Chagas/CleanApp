//
//  RoundedTextField.swift
//  UI
//
//  Created by Anderson Chagas on 01/08/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import UIKit

final class RoundedTextField: UITextField {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.borderColor = Color.primaryLight.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
}
