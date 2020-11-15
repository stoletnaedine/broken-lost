//
//  RootManager.swift
//  Broken Lost
//
//  Created by Artur Islamgulov on 15.11.2020.
//

import UIKit

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
    
}
