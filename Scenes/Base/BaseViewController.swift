//
//  BaseViewController.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import SVProgressHUD
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setControllerTitle(title: String){
        self.title = title
    }

    func showLoading() {
        SVProgressHUD.show()
        
    }

    func hideLoading() {
        SVProgressHUD.dismiss()
    }
}
