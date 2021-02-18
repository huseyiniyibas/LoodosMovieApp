//
//  SplashScreenViewController.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 18.02.2021.
//

import Network
import Firebase
import UIKit

class SplashScreenViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var remoteConfigLabel: UILabel!
    @IBOutlet private weak var warningLabel: UILabel!
    
    // MARK: - Variables
    var remoteConfig: RemoteConfig!
    let monitor = NWPathMonitor()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setRemoteConfig()
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
                    self.getRemoteConfigValue()
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
    
    private func setRemoteConfig() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    private func getRemoteConfigValue() {
        remoteConfig.fetch() { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate() { (changed, error) in
                    DispatchQueue.main.async {
                        self.remoteConfigLabel.text = self.remoteConfig.configValue(forKey: "loodos_config_text").stringValue
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.show(MainBuilder.make(), sender: nil)
                    }
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
}
