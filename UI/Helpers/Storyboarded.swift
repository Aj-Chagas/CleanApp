//
//  Storyboarded.swift
//  UI
//
//  Created by Anderson Chagas on 12/04/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import UIKit

public protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    public static func instantiate() -> Self {
        let viewController = String(describing: self)
        let sbName = viewController.components(separatedBy: "ViewController")[0]
        let sb = UIStoryboard(name: sbName, bundle: Bundle(for: Self.self))
        return sb.instantiateViewController(identifier: viewController)
    }
}
