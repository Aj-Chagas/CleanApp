//
//  SignUpViewController.swift
//  UI
//
//  Created by Anderson Chagas on 05/04/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation
import Presentation
import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SignUpViewController: LoadingView {

    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }

}
