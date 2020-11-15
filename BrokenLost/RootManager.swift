//
//  RootManager.swift
//  Broken Lost
//
//  Created by Artur Islamgulov on 15.11.2020.
//

import UIKit
import Reachability

class RootManager {
    
    var window: UIWindow?
    
    func start() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
//        window?.rootViewController = R.storyboard.launchScreen().instantiateInitialViewController()
        
        showMenu()
    }
    
    private func showMenu() {
        let menuVC = MenuViewController()
        window?.rootViewController = menuVC
    }
    
    private func connectionAvailable() -> Bool {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
//            alertService.showErrorMessage(desc: R.string.localizable.errorNoInternet())
        }
        return reachability.connection != .unavailable
    }
    
}
