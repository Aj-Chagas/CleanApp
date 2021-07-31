//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by Anderson Chagas on 10/07/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Domain

public final class MainQueueDispatchDecorator<T> {

    private let instance: T

    public init(instance: T) {
        self.instance = instance
    }

    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async { completion() } }
        completion()
    }
}

extension MainQueueDispatchDecorator: AddAccount where T: AddAccount {

    public func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
        instance.add(addAccountModel: addAccountModel) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }

}
