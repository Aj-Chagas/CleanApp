//
//  TestExtensions.swift
//  UITests
//
//  Created by Anderson Chagas on 12/04/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import UIKit

extension UIControl {

    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            self.actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }

    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
