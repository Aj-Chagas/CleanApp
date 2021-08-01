//
//  NavigationController.swift
//  UI
//
//  Created by Anderson Chagas on 01/08/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import UIKit

public final class NavigationController: UINavigationController {
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        navigationBar.barTintColor = Color.primaryDark
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
    }
}
