//
//  SplashScreenViewController.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 18.02.2021.
//

import Network
import UIKit

class SplashScreenViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var warningLabel: UILabel!
    
    // MARK: - Variables
    let monitor = NWPathMonitor()
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkInternetAvailability()
    }
}

// MARK: - Functions
extension SplashScreenViewController {
    private func checkInternetAvailability() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.warningLabel.text = "Connected!"
                    self.warningLabel.textColor = .green
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.show(MainBuilder.make(), sender: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.warningLabel.text = "No Connection!"
                    self.warningLabel.textColor = .red
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
